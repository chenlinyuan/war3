"""Command line interface: ``python -m w3xd`` or the ``w3xd`` console script."""

import argparse
import glob
import os
import sys
import time

from . import __version__, kdf
from .container import Container, W3xdError
from .mpq import MPQ


def _fmt(n):
    return format(n, ",")


def cmd_info(args):
    c = Container.from_file(args.file)
    t = c.trailer
    print("file          : %s" % args.file)
    print("size          : %s bytes" % _fmt(c.size))
    print("xorshift seed : %#010x  (matches size/license formula: %s)"
          % (c.seed, c.seed_matches_formula))
    print("trailer       : version=%d flags=%d block_size=%#x"
          % (t["version"], t["flags"], t["block_size"]))
    print("header size   : %d" % t["hdr_size"])
    print("payload size  : %s bytes" % _fmt(t["payload_size"]))
    print("license       : %#018x" % t["license"])
    print("AES-256 key   : %s" % c.key.hex())
    if args.key_material:
        m = kdf.check_key(t["license"])
        print("  buffer A    : %s" % m["buffer_a"].hex())
        print("  buffer B    : %s" % m["buffer_b"].hex())
        print("  SHA1(A)     : %s" % m["sha1_a"])
        print("  SHA1(B)     : %s" % m["sha1_b"])
    if args.payload:
        pt = c.decrypt_payload()
        print("nonce offset  : %#x" % c.nonce_off)
        print("tag offset    : %#x" % c.tag_off)
        print("payload       : %s bytes, magic %r" % (_fmt(len(pt)), pt[:4]))
    return 0


def cmd_license(args):
    c = Container.from_file(args.file)
    if args.key:
        print(c.key.hex())
    else:
        print("%#018x" % c.license)
    return 0


def cmd_decrypt(args):
    t0 = time.time()
    c = Container.from_file(args.file)
    pt = c.decrypt_payload()
    out = args.out or os.path.splitext(args.file)[0] + ".w3x"
    with open(out, "wb") as fh:
        fh.write(pt)
    print("license %#018x" % c.license)
    print("wrote %s (%s bytes) in %.1fs" % (out, _fmt(len(pt)), time.time() - t0))
    return 0


def cmd_extract(args):
    m = MPQ(args.file)
    written = m.extract(args.out, verbose=args.verbose)
    named = sum(1 for n, _ in written if not n.startswith("_unknown"))
    print("%d members (%d named), %s bytes -> %s"
          % (len(written), named, _fmt(sum(s for _, s in written)), args.out))
    return 0


def cmd_unpack(args):
    t0 = time.time()
    c = Container.from_file(args.file)
    pt = c.decrypt_payload()
    base = os.path.splitext(args.file)[0]
    w3x = args.out or base + ".w3x"
    with open(w3x, "wb") as fh:
        fh.write(pt)
    print("license %#018x -> %s (%s bytes)" % (c.license, w3x, _fmt(len(pt))))
    outdir = args.dir or base + ".files"
    m = MPQ.from_bytes(w3x, pt)
    written = m.extract(outdir, verbose=args.verbose)
    named = sum(1 for n, _ in written if not n.startswith("_unknown"))
    print("%d members (%d named), %s bytes -> %s"
          % (len(written), named, _fmt(sum(s for _, s in written)), outdir))
    print("total %.1fs" % (time.time() - t0))
    return 0


def cmd_batch(args):
    files = sorted(glob.glob(os.path.join(args.directory, "*.w3xd")))
    if not files:
        print("no .w3xd found in %s" % args.directory)
        return 1
    print("found %d container(s)\n" % len(files))
    ok = 0
    for f in files:
        try:
            t0 = time.time()
            c = Container.from_file(f)
            pt = c.decrypt_payload()
            w3x = os.path.splitext(f)[0] + ".w3x"
            with open(w3x, "wb") as fh:
                fh.write(pt)
            line = ("%-34s %10s -> %-9s hdr=%-4d payload=%-9d license=%#018x %5.1fs"
                    % (os.path.basename(f), _fmt(c.size), os.path.basename(w3x),
                       c.hdr_size, c.payload_size, c.license, time.time() - t0))
            if args.extract:
                m = MPQ.from_bytes(w3x, pt)
                written = m.extract(os.path.splitext(f)[0] + ".files")
                line += "  members=%d" % len(written)
            print(line, flush=True)
            ok += 1
        except (W3xdError, ValueError) as e:
            print("%-34s FAILED: %s" % (os.path.basename(f), e), flush=True)
    print("\n%d/%d decrypted" % (ok, len(files)))
    return 0 if ok == len(files) else 1


def build_parser():
    p = argparse.ArgumentParser(
        prog="w3xd",
        description="Warcraft III Reforged 3.0 .w3xd container toolkit")
    p.add_argument("--version", action="version", version="w3xd-toolkit " + __version__)
    sub = p.add_subparsers(dest="cmd", required=True)

    s = sub.add_parser("info", help="show container structure and license")
    s.add_argument("file")
    s.add_argument("--payload", action="store_true",
                   help="also verify the CCM tag and report the payload")
    s.add_argument("--key-material", action="store_true",
                   help="print the KDF inputs and intermediate digests")
    s.set_defaults(func=cmd_info)

    s = sub.add_parser("license", help="recover and print the license")
    s.add_argument("file")
    s.add_argument("--key", action="store_true", help="print the AES key instead")
    s.set_defaults(func=cmd_license)

    s = sub.add_parser("decrypt", help=".w3xd -> .w3x")
    s.add_argument("file")
    s.add_argument("-o", "--out")
    s.set_defaults(func=cmd_decrypt)

    s = sub.add_parser("extract", help="extract members of a decrypted .w3x")
    s.add_argument("file")
    s.add_argument("-o", "--out")
    s.add_argument("-v", "--verbose", action="store_true")
    s.set_defaults(func=cmd_extract)

    s = sub.add_parser("unpack", help=".w3xd -> .w3x plus extracted members")
    s.add_argument("file")
    s.add_argument("-o", "--out", help="output .w3x path")
    s.add_argument("-d", "--dir", help="output member directory")
    s.add_argument("-v", "--verbose", action="store_true")
    s.set_defaults(func=cmd_unpack)

    s = sub.add_parser("batch", help="decrypt every .w3xd in a directory")
    s.add_argument("directory")
    s.add_argument("-x", "--extract", action="store_true", help="also extract members")
    s.set_defaults(func=cmd_batch)
    return p


def main(argv=None):
    args = build_parser().parse_args(argv)
    try:
        return args.func(args)
    except (W3xdError, ValueError, OSError) as e:
        print("error: %s" % e, file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
