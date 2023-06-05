/// @param tilemap
/// @param xOffset
/// @param yOffset
/// @param zOffset
/// @param xSize
/// @param ySize

function CbTilemap(_tilemap, _xOffset, _yOffset, _zOffset, _xSize, _ySize)
{
    if (is_string(_tilemap)) _tilemap = layer_tilemap_get_id(layer_get_id(_tilemap));
    
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
                var _xTile = _tileIndex mod _tilesetWidth;
                var _yTile = _tileIndex div _tilesetWidth;
                
                CbTileQuad(_tileset, _xTile, _yTile,
                           _xWorld,          _yWorld,          _zOffset,
                           _xWorld + _xSize, _yWorld,          _zOffset,
                           _xWorld,          _yWorld + _ySize, _zOffset,
                           _xWorld + _xSize, _yWorld + _ySize, _zOffset,
                           c_white, 1);
            }
            
            _xWorld += _xSize;
            ++_xMap;
        }
        
        _yWorld += _ySize;
        ++_yMap;
    }
}