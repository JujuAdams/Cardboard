/// Draws a sprite perpendicular to the floor ("standing up")
/// 
/// This function presumes that the camera is pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// If auto-batching is turned on or you are building a model then the sprite may not be immediately drawn
/// 
/// @param tileset  Tileset to draw the tile from
/// @param tileX    
/// @param tileY    
/// @param x        x-coordinate to draw the sprite at
/// @param y        y-coordinate to draw the sprite at
/// @param z        z-coordinate to draw the sprite at

function CbTile(_tileset, _tileX, _tileY, _x, _y, _z)
{
    __CB_GLOBAL
    __CB_TILE_COMMON_TEXTURE
    __CB_TILE_COMMON_UVS
    
    //Cache the vertex positions
    var _l = _x;
    var _t = _z;
    var _r = _x + _tileWidth;
    var _b = _z - _tileHeight;
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    if (CB_WRITE_NORMALS)
    {
        if (_global.__doubleSided)
        {
            vertex_position_3d(_vertexBuffer, _l, _y + CB_DOUBLE_SIDED_SPACING, _t); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _l, _y + CB_DOUBLE_SIDED_SPACING, _b); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _r, _y + CB_DOUBLE_SIDED_SPACING, _t); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
            
            vertex_position_3d(_vertexBuffer, _r, _y + CB_DOUBLE_SIDED_SPACING, _t); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _l, _y + CB_DOUBLE_SIDED_SPACING, _b); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _r, _y + CB_DOUBLE_SIDED_SPACING, _b); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v1);
            
            vertex_position_3d(_vertexBuffer, _l, _y - CB_DOUBLE_SIDED_SPACING, _t); vertex_normal(_vertexBuffer, 0, -1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _r, _y - CB_DOUBLE_SIDED_SPACING, _t); vertex_normal(_vertexBuffer, 0, -1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _l, _y - CB_DOUBLE_SIDED_SPACING, _b); vertex_normal(_vertexBuffer, 0, -1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
            
            vertex_position_3d(_vertexBuffer, _r, _y - CB_DOUBLE_SIDED_SPACING, _t); vertex_normal(_vertexBuffer, 0, -1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _r, _y - CB_DOUBLE_SIDED_SPACING, _b); vertex_normal(_vertexBuffer, 0, -1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v1);
            vertex_position_3d(_vertexBuffer, _l, _y - CB_DOUBLE_SIDED_SPACING, _b); vertex_normal(_vertexBuffer, 0, -1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
        }
        else
        {
            vertex_position_3d(_vertexBuffer, _l, _y, _t); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _l, _y, _b); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _r, _y, _t); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
            
            vertex_position_3d(_vertexBuffer, _r, _y, _t); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _l, _y, _b); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _r, _y, _b); vertex_normal(_vertexBuffer, 0, 1, 0); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v1);
        }
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _l, _y, _t); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v0);
        vertex_position_3d(_vertexBuffer, _l, _y, _b); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _r, _y, _t); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
        
        vertex_position_3d(_vertexBuffer, _r, _y, _t); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v0);
        vertex_position_3d(_vertexBuffer, _l, _y, _b); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _r, _y, _b); vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, _u1, _v1);
    }
    
    __CB_FORCE_SUBMIT_CONDITION
}