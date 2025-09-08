### Stage 0: Foundations

Goal: Black window with a game loop.

- [ ] Set up Rust project (cargo new voxel_engine).
- [ ] Add wgpu + winit (for window/input).
- [ ] Create render loop: clear screen every frame.

Milestone: You can run a window at 60 FPS.

### Stage 1: Draw cubes (naive)

Goal: Put a cube on screen.

- [ ] Hardcode a cube mesh (36 vertices, indexed).
- [ ] Upload to GPU via wgpu::Buffer.
- [ ] Basic vertex + fragment shader (flat color).
- [ ] Camera: simple perspective projection, WASD movement.

Milestone: You can fly around a single cube.

### Stage 2: Naive voxel world

Goal: Display voxels directly (bad but works).

- [ ] Represent voxels as 3D array (e.g., 32×32×32).
- [ ] For each filled voxel → push a cube into a big vertex buffer.
- [ ] Re-upload buffer every frame (inefficient).

Milestone: You see a blocky landscape of cubes. (It’ll run at like 10 FPS if you go too big, but that’s fine — proof of concept.)

### Stage 3: Chunk system

Goal: Break world into chunks for sanity.

- [ ] World = hashmap keyed by (chunk_x, chunk_y, chunk_z).
- [ ] Each chunk = 16×16×16 voxel array.
- [ ] Each chunk has its own mesh buffer.
- [ ] Update only when chunk changes.

Milestone: You can load/generate multiple chunks and only re-mesh dirty ones.

### Stage 4: Basic greedy meshing

Goal: Stop drawing hidden faces.

- [ ] Instead of pushing 6 faces per cube, only push faces where neighbor is air.
- [ ] Keep face quads simple (don’t bother merging yet).

Milestone: World now renders MUCH faster (100k+ visible voxels at 60 FPS).

### Stage 5: World streaming

Goal: Move player, load/unload chunks.

- [ ] Keep “active radius” (e.g., 8×8 chunks around player).
- [ ] Spawn/despawn chunks when crossing chunk boundaries.
- [ ] Procedural gen stub: just random noise for terrain height.

Milestone: You can walk around an infinite terrain. (It’ll look ugly, but it’s infinite.)

### Stage 6: Optimization passes

- [ ] Replace “face culling” with greedy meshing (merge adjacent faces into bigger quads).
- [ ] Add frustum culling (don’t draw chunks outside camera view).
- [ ] Move chunk meshing onto worker threads (rayon).
- [ ] Use instancing or compute shaders later if you want more FPS.

### Architecture

- [ ] use a workspace

```sh
voxel-project/
│
├─ Cargo.toml           # workspace manifest
├─ engine/              # "engine" crate
│   ├─ src/
│   └─ Cargo.toml
├─ game/                # "game" crate (uses engine)
│   ├─ src/
│   └─ Cargo.toml
└─ shared/              # optional shared utils (math, noise, ECS, etc.)
    ├─ src/
    └─ Cargo.toml
```
