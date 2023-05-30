// Whether vertex buffers built by Cardboard should include normals
// This is critical information for lighting scenes
#macro CARDBOARD_WRITE_NORMALS  true

// The space between layers when using the double-sided draw feature
// Set this value to as small as possible without seeing z-fighting
#macro CARDBOARD_DOUBLE_SIDED_SPACING  0.1

// Whether to use backface culling
// Backface culling is automatically disabled if CARDBOARD_WRITE_NORMALS is set to <false>
#macro CARDBOARD_BACKFACE_CULLING  true