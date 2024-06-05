/// @param tilemap
/// @param xOffset
/// @param yOffset
/// @param zOffset
/// @param xSize
/// @param ySize

function CbTilemapAnimatedBuild(_tilemap, _xOffset, _yOffset, _zOffset, _xSize, _ySize)
{
    __CB_GLOBAL_BUILD
    
    if (is_string(_tilemap)) _tilemap = layer_tilemap_get_id(layer_get_id(_tilemap));
    
    var _vertexBuffer = vertex_create_buffer();
    vertex_begin(_vertexBuffer, _global.__batch.__vertexFormat);
    
    var _tilemapWidth  = tilemap_get_width( _tilemap);
    var _tilemapHeight = tilemap_get_height(_tilemap);
    
    var _tileset      = tilemap_get_tileset(_tilemap);
    var _tilesetData  = __CbTilesetDataGet(_tileset);
    var _tilesetWidth = _tilesetData.__tilesetWidth;
    
    var _yWorld = _yOffset;
    var _yMap = 0;
    repeat(_tilemapHeight)
    {
        var _xWorld = _xOffset;
        var _xMap = 0;
        repeat(_tilemapWidth)
        {
            var _tileIndex = tilemap_get(_tilemap, _xMap, _yMap);
            if (_tileIndex != 0)
            {
                __CbTileQuadAnimated(_vertexBuffer, _tileset, _tileIndex, _tilesetWidth,
                                     _xWorld,          _yWorld,          _zOffset,
                                     _xWorld + _xSize, _yWorld,          _zOffset,
                                     _xWorld,          _yWorld + _ySize, _zOffset,
                                     _xWorld + _xSize, _yWorld + _ySize, _zOffset);
            }
            
            _xWorld += _xSize;
            ++_xMap;
        }
        
        _yWorld += _ySize;
        ++_yMap;
    }
    
    vertex_end(_vertexBuffer);
    
    return {
        __vertexBuffer: _vertexBuffer,
        __texture:      tileset_get_texture(_tileset),
    };
}

function __CbTileQuadAnimated()
{
    __CB_GLOBAL_BUILD
    
    var _vertexBuffer  = argument[ 0];
    var _tileset       = argument[ 1];
    var _tileBaseIndex = argument[ 2];
    var _tilesetWidth  = argument[ 3];
    var _x1            = argument[ 4];
    var _y1            = argument[ 5];
    var _z1            = argument[ 6];
    var _x2            = argument[ 7];
    var _y2            = argument[ 8];
    var _z2            = argument[ 9];
    var _x3            = argument[10];
    var _y3            = argument[11];
    var _z3            = argument[12];
    var _x4            = argument[13];
    var _y4            = argument[14];
    var _z4            = argument[15];
    
    var _tilesetData   = __CbTilesetDataGet(_tileset);
    var _uvs           = _tilesetData.__UVs;
    var _borderWidth   = _tilesetData.__tileSeparatorH;
    var _borderHeight  = _tilesetData.__tileSeparatorV;
    var _animMap       = _tilesetData.__tileAnimMap;
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
    
    if (CB_WRITE_NORMALS)
    {
        //Cross product
        var _normalX = (_y2 - _y1)*(_z3 - _z1) - (_z2 - _z1)*(_y3 - _y1);
        var _normalY = (_z2 - _z1)*(_x3 - _x1) - (_x2 - _x1)*(_z3 - _z1);
        var _normalZ = (_x2 - _x1)*(_y3 - _y1) - (_y2 - _y1)*(_x3 - _x1);
    }
    
    var _framesArray = _animMap[? _tileBaseIndex];
    if (is_array(_framesArray))
    {
        var _length = array_length(_framesArray);
        var _i = 0;
        repeat(_length)
        {
            var _tileIndex = _framesArray[_i];
            
            var _tileX = _tileIndex mod _tilesetWidth;
            var _tileY = _tileIndex div _tilesetWidth;
            
            var _u0 = lerp(_tilesetU0, _tilesetU1, (_borderWidth  + _tileWidthExt *_tileX              ) / _textureWidth );
            var _v0 = lerp(_tilesetV0, _tilesetV1, (_borderHeight + _tileHeightExt*_tileY              ) / _textureHeight);
            var _u1 = lerp(_tilesetU0, _tilesetU1, (_borderWidth  + _tileWidthExt *_tileX + _tileWidth ) / _textureWidth );
            var _v1 = lerp(_tilesetV0, _tilesetV1, (_borderHeight + _tileHeightExt*_tileY + _tileHeight) / _textureHeight);
            
            var _packedData = make_color_rgb(_i, _length-1, 0);
            
            if (_global.__doubleSided)
            {
                var _invLength = 1 / point_distance_3d(0, 0, 0, _normalX, _normalY, _normalZ);
                _normalX *= _invLength;
                _normalY *= _invLength;
                _normalZ *= _invLength;
                
                var _dX = CB_DOUBLE_SIDED_SPACING*_normalX;
                var _dY = CB_DOUBLE_SIDED_SPACING*_normalY;
                var _dZ = CB_DOUBLE_SIDED_SPACING*_normalZ;
                
                vertex_position_3d(_vertexBuffer, _x1 + _dX, _y1 + _dY, _z1 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
                vertex_position_3d(_vertexBuffer, _x3 + _dX, _y3 + _dY, _z3 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
                vertex_position_3d(_vertexBuffer, _x2 + _dX, _y2 + _dY, _z2 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
                
                vertex_position_3d(_vertexBuffer, _x2 + _dX, _y2 + _dY, _z2 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
                vertex_position_3d(_vertexBuffer, _x3 + _dX, _y3 + _dY, _z3 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
                vertex_position_3d(_vertexBuffer, _x4 + _dX, _y4 + _dY, _z4 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
                
                vertex_position_3d(_vertexBuffer, _x1 - _dX, _y1 - _dY, _z1 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
                vertex_position_3d(_vertexBuffer, _x2 - _dX, _y2 - _dY, _z2 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
                vertex_position_3d(_vertexBuffer, _x3 - _dX, _y3 - _dY, _z3 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
                
                vertex_position_3d(_vertexBuffer, _x2 - _dX, _y2 - _dY, _z2 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
                vertex_position_3d(_vertexBuffer, _x4 - _dX, _y4 - _dY, _z4 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
                vertex_position_3d(_vertexBuffer, _x3 - _dX, _y3 - _dY, _z3 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
            }
            else
            {
                vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
                vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
                vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
                
                vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
                vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
                vertex_position_3d(_vertexBuffer, _x4, _y4, _z4); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
            }
            ++_i;
        }
    }
    else
    {
        var _tileX = _tileBaseIndex mod _tilesetWidth;
        var _tileY = _tileBaseIndex div _tilesetWidth;
        
        var _u0 = lerp(_tilesetU0, _tilesetU1, (_borderWidth  + _tileWidthExt *_tileX              ) / _textureWidth );
        var _v0 = lerp(_tilesetV0, _tilesetV1, (_borderHeight + _tileHeightExt*_tileY              ) / _textureHeight);
        var _u1 = lerp(_tilesetU0, _tilesetU1, (_borderWidth  + _tileWidthExt *_tileX + _tileWidth ) / _textureWidth );
        var _v1 = lerp(_tilesetV0, _tilesetV1, (_borderHeight + _tileHeightExt*_tileY + _tileHeight) / _textureHeight);
        
        var _packedData = c_black;
        
        if (_global.__doubleSided)
        {
            var _invLength = 1 / point_distance_3d(0, 0, 0, _normalX, _normalY, _normalZ);
            _normalX *= _invLength;
            _normalY *= _invLength;
            _normalZ *= _invLength;
            
            var _dX = CB_DOUBLE_SIDED_SPACING*_normalX;
            var _dY = CB_DOUBLE_SIDED_SPACING*_normalY;
            var _dZ = CB_DOUBLE_SIDED_SPACING*_normalZ;
            
            vertex_position_3d(_vertexBuffer, _x1 + _dX, _y1 + _dY, _z1 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _x3 + _dX, _y3 + _dY, _z3 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _x2 + _dX, _y2 + _dY, _z2 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
            
            vertex_position_3d(_vertexBuffer, _x2 + _dX, _y2 + _dY, _z2 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _x3 + _dX, _y3 + _dY, _z3 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _x4 + _dX, _y4 + _dY, _z4 + _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer,  _normalX,  _normalY,  _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
            
            vertex_position_3d(_vertexBuffer, _x1 - _dX, _y1 - _dY, _z1 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _x2 - _dX, _y2 - _dY, _z2 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _x3 - _dX, _y3 - _dY, _z3 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
            
            vertex_position_3d(_vertexBuffer, _x2 - _dX, _y2 - _dY, _z2 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _x4 - _dX, _y4 - _dY, _z4 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
            vertex_position_3d(_vertexBuffer, _x3 - _dX, _y3 - _dY, _z3 - _dZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
        }
        else
        {
            vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
            vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
            
            vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
            vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
            vertex_position_3d(_vertexBuffer, _x4, _y4, _z4); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); } vertex_color(_vertexBuffer, _packedData, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
        }
    }
}