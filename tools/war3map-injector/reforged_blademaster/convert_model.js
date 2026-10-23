"use strict";

const fs = require("fs");
const path = require("path");
const War3Model = require("war3-model");

const input = path.resolve(process.argv[2]);
const output = path.resolve(process.argv[3]);
const raw = fs.readFileSync(input);
const model = War3Model.parseMDX(
  raw.buffer.slice(raw.byteOffset, raw.byteOffset + raw.byteLength)
);

const internalPrefix = "war3campImported\\ReforgedBladeMaster";
model.Version = 800;

// v800 cannot select LOD geosets. Keep only the highest-detail set, otherwise
// all four LODs render simultaneously in 1.27.
model.Geosets = model.Geosets.filter(
  (geoset) => (geoset.LevelOfDetail === undefined || geoset.LevelOfDetail === 0)
);
for (const geoset of model.Geosets) {
  const minimum = new Float32Array([Infinity, Infinity, Infinity]);
  const maximum = new Float32Array([-Infinity, -Infinity, -Infinity]);
  let radius = 0;
  for (let i = 0; i < geoset.Vertices.length; i += 3) {
    const x = geoset.Vertices[i];
    const y = geoset.Vertices[i + 1];
    const z = geoset.Vertices[i + 2];
    minimum[0] = Math.min(minimum[0], x);
    minimum[1] = Math.min(minimum[1], y);
    minimum[2] = Math.min(minimum[2], z);
    maximum[0] = Math.max(maximum[0], x);
    maximum[1] = Math.max(maximum[1], y);
    maximum[2] = Math.max(maximum[2], z);
    radius = Math.max(radius, Math.hypot(x, y, z));
  }
  geoset.MinimumExtent = minimum;
  geoset.MaximumExtent = maximum;
  geoset.BoundsRadius = radius;

  // v800 stores one matrix-group index per vertex. Reforged stores four
  // weighted bone IDs; keep the dominant weighted bone for classic skinning.
  const vertexCount = geoset.Vertices.length / 3;
  const groupByBone = new Map();
  geoset.Groups.forEach((bones, groupIndex) => {
    for (const bone of bones) groupByBone.set(bone, groupIndex);
  });
  const classicGroups = new Uint8Array(vertexCount);
  for (let vertex = 0; vertex < vertexCount; vertex++) {
    const off = vertex * 8;
    let bestWeight = -1;
    let bestBone = -1;
    for (let k = 0; k < 4; k++) {
      const weight = geoset.SkinWeights[off + k];
      const bone = geoset.SkinWeights[off + 4 + k];
      if (bone !== 255 && weight > bestWeight) {
        bestWeight = weight;
        bestBone = bone;
      }
    }
    classicGroups[vertex] = groupByBone.has(bestBone)
      ? groupByBone.get(bestBone)
      : 0;
  }
  geoset.VertexGroup = classicGroups;
  delete geoset.SkinWeights;
  delete geoset.Tangents;
  delete geoset.LevelOfDetail;
  delete geoset.Name;
}
model.GeosetAnims = (model.GeosetAnims || []).filter(
  (anim) => anim.GeosetId >= 0 && anim.GeosetId < model.Geosets.length
);

// Keep only textures used by the v800 materials, team color and the flame
// particle emitter. HD normal/ORM/reflection maps have no v800 material slot.
model.Textures = [
  { ReplaceableId: 0, Image: "Textures\\RibbonBlur1.blp", Flags: 3 },
  { ReplaceableId: 0, Image: internalPrefix + "\\HeroBladeMaster_Main.blp", Flags: 3 },
  { ReplaceableId: 0, Image: internalPrefix + "\\HeroBladeMaster_Hair.blp", Flags: 3 },
  { ReplaceableId: 0, Image: internalPrefix + "\\HeroBladeMaster_Flag.blp", Flags: 3 },
  { ReplaceableId: 0, Image: internalPrefix + "\\HeroBladeMaster_Weapon.blp", Flags: 3 },
  { ReplaceableId: 1, Image: "", Flags: 3 },
  { ReplaceableId: 0, Image: "Textures\\Flame4.blp", Flags: 3 }
];

function baseLayer(source, textureId, filterMode) {
  return {
    FilterMode: filterMode,
    Shading: 0,
    TextureID: textureId,
    TVertexAnimId: null,
    CoordId: 0,
    Alpha: source.Alpha
  };
}

function teamLayer(source) {
  return {
    FilterMode: 0,
    Shading: 0,
    TextureID: 5,
    TVertexAnimId: null,
    CoordId: 0,
    Alpha: source.Alpha
  };
}

function teamMaterial(material, textureId) {
  const source = material.Layers[0];
  material.Layers = [teamLayer(source), baseLayer(source, textureId, 2)];
  material.PriorityPlane = 0;
  material.RenderMode = 0;
  delete material.Shader;
  return material;
}

model.Materials[0].Layers = [baseLayer(model.Materials[0].Layers[0], 0, 3)];
teamMaterial(model.Materials[1], 1);
teamMaterial(model.Materials[2], 1);
model.Materials[3].Layers = [baseLayer(model.Materials[3].Layers[0], 2, 1)];
teamMaterial(model.Materials[4], 3);
teamMaterial(model.Materials[5], 3);
teamMaterial(model.Materials[6], 4);
teamMaterial(model.Materials[7], 4);

// The HD flame particle used texture 0; in the compact texture table that is
// the seventh entry.
for (const emitter of model.ParticleEmitters2 || []) {
  if (emitter.TextureID === 0) emitter.TextureID = 6;
}

// The two HD spin attachments point at separate Reforged submodels that do not
// exist in the classic CASC. The native spin sequence and particles remain.
model.Attachments = (model.Attachments || []).filter(
  (attachment) => !/BladeMasterSpin/i.test(attachment.Name || "")
);

const generated = War3Model.generateMDX(model);
fs.writeFileSync(output, Buffer.from(generated));

console.log(JSON.stringify({
  output,
  bytes: fs.statSync(output).size,
  version: model.Version,
  geosets: model.Geosets.length,
  materials: model.Materials.length,
  textures: model.Textures.length,
  sequences: model.Sequences.length,
  bones: model.Bones.length,
  attachments: model.Attachments.length
}, null, 2));
