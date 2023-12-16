/// Draws a tile parallel to the floor ("lying down")
/// 
/// This function presumes that the camera is pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// If auto-batching is turned on or you are building a model then the tile may not be immediately drawn
/// 
/// @param tileset  Tileset to draw the tile from
/// @param tileX    Grid x-coordinate of the tile on the tileset
/// @param tileY    Grid y-coordinate of the tile on the tileset
/// @param x        x-coordinate to draw the tile at
/// @param y        y-coordinate to draw the tile at
/// @param z        z-coordinate to draw the tile at

function CbTileFloor(_tileset, _tileX, _tileY, _x, _y, _z)
{
    __CB_GLOBAL_BUILD
    __CB_INDEX
    __CB_TILE_COMMON_TEXTURE
    __CB_TILE_COMMON_UVS
    
    //Cache the vertex positions
    var _l = _x;
    var _t = _y;
    var _r = _x + _tileWidth;
    var _b = _y + _tileHeight;
    
    //Add this tile to the vertex buffer
    var _vertexBuffer = _global.__batch.__vertexBuffer;
    
    if (_global.__doubleSided)
    {
        vertex_position_3d(_vertexBuffer, _l, _t, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v0); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _l, _b, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _r, _t, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
        
        vertex_position_3d(_vertexBuffer, _r, _t, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _l, _b, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _r, _b, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v1); __CB_WRITE_INDEX
        
        vertex_position_3d(_vertexBuffer, _l, _t, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v0); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _r, _t, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _l, _b, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
        
        vertex_position_3d(_vertexBuffer, _r, _t, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _r, _b, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v1); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _l, _b, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _l, _t, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v0); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _l, _b, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _r, _t, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
        
        vertex_position_3d(_vertexBuffer, _r, _t, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _l, _b, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
        vertex_position_3d(_vertexBuffer, _r, _b, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v1); __CB_WRITE_INDEX
    }
    
    __CB_CONDITIONAL_SUBMIT
}