/// Draws a tile stretched over an arbitrary quadrilateral
/// 
/// If auto-batching is turned on or you are building a model then the tile may not be immediately drawn
/// 
/// @param tileset  Tileset to draw the tile from
/// @param tileX    Grid x-coordinate of the tile on the tileset
/// @param tileY    Grid y-coordinate of the tile on the tileset
/// @param x1       x-coordinate for the top-left corner of the texture
/// @param y1       y-coordinate for the top-left corner of the texture
/// @param z1       z-coordinate for the top-left corner of the texture
/// @param u1       U-coordinate, normalised to the size of the tile's texture
/// @param v1       V-coordinate, normalised to the size of the tile's texture
/// @param x2       x-coordinate for the top-right corner of the texture
/// @param y2       y-coordinate for the top-right corner of the texture
/// @param z2       z-coordinate for the top-right corner of the texture
/// @param u2       U-coordinate, normalised to the size of the tile's texture
/// @param v2       V-coordinate, normalised to the size of the tile's texture
/// @param x3       x-coordinate for the bottom-left corner of the texture
/// @param y3       y-coordinate for the bottom-left corner of the texture
/// @param z3       z-coordinate for the bottom-left corner of the texture
/// @param u3       U-coordinate, normalised to the size of the tile's texture
/// @param v3       V-coordinate, normalised to the size of the tile's texture
/// @param color    Blend color for the tile (c_white is "no blending")
/// @param alpha    Blend alpha for the tile (0 being transparent and 1 being 100% opacity)
        
function CbTileTriangle()
{
    __CB_GLOBAL_BUILD
    __CB_INDEX
    
    var _tileset = argument[ 0];
    var _tileX   = argument[ 1];
    var _tileY   = argument[ 2];
    var _x1      = argument[ 3];
    var _y1      = argument[ 4];
    var _z1      = argument[ 5];
    var _u1prop  = argument[ 6];
    var _v1prop  = argument[ 7];
    var _x2      = argument[ 8];
    var _y2      = argument[ 9];
    var _z2      = argument[10];
    var _u2prop  = argument[11];
    var _v2prop  = argument[12];
    var _x3      = argument[13];
    var _y3      = argument[14];
    var _z3      = argument[15];
    var _u3prop  = argument[16];
    var _v3prop  = argument[17];
    var _color   = argument[18];
    var _alpha   = argument[19];
    
    __CB_TILE_COMMON_TEXTURE
    __CB_TILE_COMMON_UVS
    
    //Add this tile to the vertex buffer
    var _vertexBuffer = _global.__batch.__vertexBuffer;
    
    if (CB_WRITE_NORMALS)
    {
        //Cross product
        var _normalX = (_y2 - _y1)*(_z3 - _z1) - (_z2 - _z1)*(_y3 - _y1);
        var _normalY = (_z2 - _z1)*(_x3 - _x1) - (_x2 - _x1)*(_z3 - _z1);
        var _normalZ = (_x2 - _x1)*(_y3 - _y1) - (_y2 - _y1)*(_x3 - _x1);
        
        if (_global.__doubleSided)
        {
            var _invLength = 1 / point_distance_3d(0, 0, 0, _normalX, _normalY, _normalZ);
            _normalX *= _invLength;
            _normalY *= _invLength;
            _normalZ *= _invLength;
            
            var _dX = CB_DOUBLE_SIDED_SPACING*_normalX;
            var _dY = CB_DOUBLE_SIDED_SPACING*_normalY;
            var _dZ = CB_DOUBLE_SIDED_SPACING*_normalZ;
            
            vertex_position_3d(_vertexBuffer, _x1 + _dX, _y1 + _dY, _z1 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u1prop), lerp(_v0, _v1, _v1prop)); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _x3 + _dX, _y3 + _dY, _z3 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u3prop), lerp(_v0, _v1, _v3prop)); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _x2 + _dX, _y2 + _dY, _z2 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u2prop), lerp(_v0, _v1, _v2prop)); __CB_WRITE_INDEX
            
            vertex_position_3d(_vertexBuffer, _x1 - _dX, _y1 - _dY, _z1 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u1prop), lerp(_v0, _v1, _v1prop)); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _x2 - _dX, _y2 - _dY, _z2 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u2prop), lerp(_v0, _v1, _v2prop)); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _x3 - _dX, _y3 - _dY, _z3 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u3prop), lerp(_v0, _v1, _v3prop)); __CB_WRITE_INDEX
        }
        else
        {
            vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u1prop), lerp(_v0, _v1, _v1prop)); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u2prop), lerp(_v0, _v1, _v2prop)); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u3prop), lerp(_v0, _v1, _v3prop)); __CB_WRITE_INDEX
        }
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u1prop), lerp(_v0, _v1, _v1prop));
        vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u2prop), lerp(_v0, _v1, _v2prop));
        vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0, _u1, _u3prop), lerp(_v0, _v1, _v3prop));
    }
    
    __CB_FORCE_SUBMIT_CONDITION
}