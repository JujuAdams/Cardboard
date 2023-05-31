// Whether vertex buffers built by Cb should include normals
// This is critical information for lighting scenes
#macro CB_WRITE_NORMALS  false

// The space between layers when using the double-sided draw feature
// Set this value to as small as possible without seeing z-fighting
#macro CB_DOUBLE_SIDED_SPACING  0.1

// Whether to use backface culling
// Backface culling is automatically disabled if CB_WRITE_NORMALS is set to <false>
#macro CB_BACKFACE_CULLING  false