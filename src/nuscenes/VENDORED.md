# Vendored nuscenes-devkit (nuscenes package only)

This `nuscenes/` package is vendored, **not** installed from PyPI.

- **Source**: <https://github.com/nutonomy/nuscenes-devkit> (official, v1.2.0)
- **Commit**: `d9de17a73bdc06ce97a02f77ae7edb9b0406e851`
- **Why vendored**: OpenPCDet is the only consumer and this is pinned to a fixed
  upstream commit. Vendoring keeps the Docker image self-contained (no git/pip fetch at build)
  and lets all runtime deps be resolved by pixi in a single conda-first solve, avoiding
  the conda-vs-pypi same-name hazard (e.g. `py-opencv` vs `opencv-python-headless`).

## What is included / excluded

- Included: the full `nuscenes` package (importable as `import nuscenes`).
- Excluded: `nuimages` (unrelated SDK, unused), `tutorials/` (notebooks), the old
  `setup/` packaging, and `descartes`/`torch` deps.

## Dependencies

Declared in OpenPCDet's `pixi.toml` (conda-forge), NOT here:
`numpy matplotlib scikit-learn scipy shapely pyquaternion cachetools fire tqdm pillow`
(opencv via the existing `py-opencv`).

Two submodules need extras that are intentionally NOT installed (OpenPCDet never
imports them):

- `nuscenes/map_expansion/map_api.py` → `descartes` (map rendering)
- `nuscenes/prediction/**` → `torch`/`torchvision` (already provided by OpenPCDet anyway)

OpenPCDet only uses: `nuscenes.nuscenes.NuScenes`, `nuscenes.eval.detection.*`,
`nuscenes.utils.{splits,data_classes,geometry_utils}` — none of which touch the above.
