from __future__ import annotations

import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]


class LootBeamAssetAuditTests(unittest.TestCase):
    def test_release_audit_does_not_require_removed_custom_asset(self) -> None:
        offline_core = (
            ROOT / "tools" / "alas-offline" / "offline_core.py"
        ).read_text(encoding="utf-8")
        campaign_audit = (
            ROOT / "tools" / "alas-offline" / "assets"
            / "audit_alas_campaign.py"
        ).read_text(encoding="utf-8")

        self.assertNotIn("ALAS-OrangeLootBeam.mdx", offline_core)
        self.assertNotIn("ALAS-OrangeLootBeam.mdx", campaign_audit)
        self.assertNotIn("Rune-Blue-Aura_Raised20.mdx", campaign_audit)
        self.assertNotIn("FR_AddBeam", campaign_audit)


if __name__ == "__main__":
    unittest.main()
