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
/// @param x2       x-coordinate for the top-right corner of the texture
/// @param y2       y-coordinate for the top-right corner of the texture
/// @param z2       z-coordinate for the top-right corner of the texture
/// @param x3       x-coordinate for the bottom-left corner of the texture
/// @param y3       y-coordinate for the bottom-left corner of the texture
/// @param z3       z-coordinate for the bottom-left corner of the texture
/// @param x4       x-coordinate for the bottom-right corner of the texture
/// @param y4       y-coordinate for the bottom-right corner of the texture
/// @param z4       z-coordinate for the bottom-right corner of the texture
/// @param color    Blend color for the tile (c_white is "no blending")
/// @param alpha    Blend alpha for the tile (0 being transparent and 1 being 100% opacity)

function CbTileQuad()
{
    __CB_GLOBAL
    
    var _tileset = argument[ 0];
    var _tileX   = argument[ 1];
    var _tileY   = argument[ 2];
    var _x1      = argument[ 3];
    var _y1      = argument[ 4];
    var _z1      = argument[ 5];
    var _x2      = argument[ 6];
    var _y2      = argument[ 7];
    var _z2      = argument[ 8];
    var _x3      = argument[ 9];
    var _y3      = argument[10];
    var _z3      = argument[11];
    var _x4      = argument[12];
    var _y4      = argument[13];
    var _z4      = argument[14];
    var _color   = argument[15];
    var _alpha   = argument[16];
    
    static _borderWidth  = 2;
    static _borderHeight = 2;
    
    var _tilesetData   = __CbGetTileset(_tileset);
    var _texture       = _tilesetData.__texture;
    var _uvs           = _tilesetData.__UVs;
    var _tilesetU0     = _uvs[0];
    var _tilesetV0     = _uvs[1];
    var _tilesetU1     = _uvs[2];
    var _tilesetV1     = _uvs[3];
    var _tileWidth     = _tilesetData.__tileWidth;
    var _tileHeight    = _tilesetData.__tileHeight;
    var _tileWidthExt  = _tileWidth  + 2*_borderWidth;
    var _tileHeightExt = _tileHeight + 2*_borderHeight;
    var _textureWidth  = _tilesetData.__textureWidth;
    var _textureHeight = _tilesetData.__textureHeight;
    
    //Break the batch if we've swapped texture
    if (_texture != _global.__batch.__textureIndex)
    {
        __CbBatchComplete();
        _global.__batch.__texturePointer = _texture;
        _global.__batch.__textureIndex   = undefined;
    }
    
    var _u0 = lerp(_tilesetU0, _tilesetU1, (_borderWidth  + _tileWidthExt *_tileX              ) / _textureWidth );
    var _v0 = lerp(_tilesetV0, _tilesetV1, (_borderHeight + _tileHeightExt*_tileY              ) / _textureHeight);
    var _u1 = lerp(_tilesetU0, _tilesetU1, (_borderWidth  + _tileWidthExt *_tileX + _tileWidth ) / _textureWidth );
    var _v1 = lerp(_tilesetV0, _tilesetV1, (_borderHeight + _tileHeightExt*_tileY + _tileHeight) / _textureHeight);
    
    
    
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
            
            vertex_position_3d(_vertexBuffer, _x1 + _dX, _y1 + _dY, _z1 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _x3 + _dX, _y3 + _dY, _z3 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _x2 + _dX, _y2 + _dY, _z2 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
            
            vertex_position_3d(_vertexBuffer, _x2 + _dX, _y2 + _dY, _z2 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _x3 + _dX, _y3 + _dY, _z3 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _x4 + _dX, _y4 + _dY, _z4 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
            
            vertex_position_3d(_vertexBuffer, _x1 - _dX, _y1 - _dY, _z1 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _x2 - _dX, _y2 - _dY, _z2 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _x3 - _dX, _y3 - _dY, _z3 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
            
            vertex_position_3d(_vertexBuffer, _x2 - _dX, _y2 - _dY, _z2 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _x4 - _dX, _y4 - _dY, _z4 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
            vertex_position_3d(_vertexBuffer, _x3 - _dX, _y3 - _dY, _z3 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
        }
        else
        {
            vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
            
            vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _x4, _y4, _z4); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
        }
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
        vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
        
        vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
        vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _x4, _y4, _z4); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
    }
    
    __CB_FORCE_SUBMIT_CONDITION
}