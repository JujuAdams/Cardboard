// Whether vertex buffers built by Cardboard should include normals. This is critical information
// for lighting scenes.
#macro CB_WRITE_NORMALS  true

// The space between layers when using the double-sided draw feature. Set this value to as small
// as possible without seeing z-fighting.
#macro CB_DOUBLE_SIDED_SPACING  1.33

// Versions of GameMaker around 2024.11 returned slightly incorrect tileset data. Set this macro to
// `true` if you're using one of these versions. Versions of GameMaker later than 2024.14 will
// likely want to set this macro to `false`.
#macro CB_LEGACY_TILESET_DATA  false