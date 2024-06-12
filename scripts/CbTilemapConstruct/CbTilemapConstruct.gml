/// @param layer

function CbTilemapConstruct(_layer)
{
    var _tilemap = layer_tilemap_get_id(_layer);
    
    var _tilemapWidth  = tilemap_get_width(_tilemap);
    var _tilemapHeight = tilemap_get_height(_tilemap);
    
    var _tileset       = tilemap_get_tileset(_tilemap);
    var _tilesetData   = __CbTilesetDataGet(_tileset);
    var _tilesetWidth  = _tilesetData.__tilesetWidth;
    var _tilesetHeight = _tilesetData.__tilesetHeight;
    
    var _deltaGrid   = ds_grid_create(_tilemapWidth, _tilemapHeight);
    var _visitedGrid = ds_grid_create(_tilemapWidth, _tilemapHeight);
    
    var _toProcessArray = [];
    
    var _yCell = _tilemapHeight-1;
    repeat(_tilemapHeight)
    {
        var _xCell = 0;
        repeat(_tilemapWidth)
        {
            var _tileIndex = tilemap_get(_tilemap, _xCell, _yCell);
            
            var _xTile = _tileIndex mod _tilesetWidth;
            var _yTile = _tileIndex div _tilesetWidth;
            
            if ((_xTile == 6) && (_yTile == 1))
            {
                _deltaGrid[# _xCell, _yCell-1] = _deltaGrid[# _xCell, _yCell] + 1;
                _visitedGrid[# _xCell, _yCell] = true;
                array_push(_toProcessArray, ((_yCell-1) << 32) | _xCell);
            }
            
            ++_xCell;
        }
        
        --_yCell;
    }
    
    var _directionalityArray = array_create(_tilesetWidth*_tilesetHeight, 0);
    
    //1 = East
    //2 = North
    //4 = West
    //8 = South
    
    _directionalityArray[ 2] = 1 | 2;
    _directionalityArray[ 3] =     2 | 4;
    _directionalityArray[ 4] = 1 |         8;
    _directionalityArray[ 5] =         4 | 8;
    _directionalityArray[ 6] = 1 | 2     | 8;
    _directionalityArray[10] = 1 | 2     | 8;
    _directionalityArray[11] = 1 | 2 | 4;
    _directionalityArray[12] = 1 |     4 | 8;
    _directionalityArray[13] =     2 | 4 | 8;
    
    while(array_length(_toProcessArray) > 0)
    {
        var _packed = array_shift(_toProcessArray);
        _xCell = _packed & 0xFFFFFFFF;
        _yCell = _packed >> 32;
        
        var _tileIndex = tilemap_get(_tilemap, _xCell, _yCell);
        var _directionality = _directionalityArray[_tileIndex];
        if (_directionality > 0)
        {
            var _delta = _deltaGrid[# _xCell, _yCell];
            
            if ((_directionality & 0x1) && (_xCell < _tilemapWidth-1))
            {
                var _xOther = _xCell+1;
                if (not _visitedGrid[# _xOther, _yCell])
                {
                    _deltaGrid[#   _xOther, _yCell] = _delta;
                    _visitedGrid[# _xOther, _yCell] = true;
                    array_push(_toProcessArray, (_yCell << 32) | _xOther);
                }
            }
            
            if ((_directionality & 0x2) && (_yCell > 0))
            {
                var _yOther = _yCell-1;
                if (not _visitedGrid[# _xCell, _yOther])
                {
                    _deltaGrid[#   _xCell, _yOther] = _delta;
                    _visitedGrid[# _xCell, _yOther] = true;
                    array_push(_toProcessArray, (_yOther << 32) | _xCell);
                }
            }
            
            if ((_directionality & 0x4) && (_xCell > 0))
            {
                var _xOther = _xCell-1;
                if (not _visitedGrid[# _xOther, _yCell])
                {
                    _deltaGrid[#   _xOther, _yCell] = _delta;
                    _visitedGrid[# _xOther, _yCell] = true;
                    array_push(_toProcessArray, (_yCell << 32) | _xOther);
                }
            }
            
            if ((_directionality & 0x8) && (_yCell < _tilemapHeight-1))
            {
                var _yOther = _yCell+1;
                if (not _visitedGrid[# _xCell, _yOther])
                {
                    _deltaGrid[#   _xCell, _yOther] = _delta;
                    _visitedGrid[# _xCell, _yOther] = true;
                    array_push(_toProcessArray, (_yOther << 32) | _xCell);
                }
            }
        }
    }
    
    var _yCell = 0;
    repeat(_tilemapHeight)
    {
        var _xCell = 0;
        repeat(_tilemapWidth)
        {
            var _tileIndex = tilemap_get(_tilemap, _xCell, _yCell);
            
            var _xTile = _tileIndex mod _tilesetWidth;
            var _yTile = _tileIndex div _tilesetWidth;
            
            var _height = _deltaGrid[# _xCell, _yCell];
            
            if ((_xTile == 6) && (_yTile == 1))
            {
                CbTile(_tileset, _xTile, _yTile, 32*_xCell, 32*(_yCell + _height + 1), 32*(_height + 1));
            }
            else
            {
                CbTileFloor(_tileset, _xTile, _yTile, 32*_xCell, 32*(_yCell + _height), 32*_height);
            }
            
            ++_xCell;
        }
        
        ++_yCell;
    }
}