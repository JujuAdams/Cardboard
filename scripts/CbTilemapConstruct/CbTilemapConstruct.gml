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
    
    
    
    var _directionalityArray = array_create(_tilesetWidth*_tilesetHeight, 0);
    
    //1 = East
    //2 = North
    //4 = West
    //8 = South
    
    _directionalityArray[ 2] = 1 | 2;
    _directionalityArray[ 3] =     2 | 4;
    _directionalityArray[ 4] = 1 |         8;
    _directionalityArray[ 5] =         4 | 8;
    _directionalityArray[ 6] =     2     | 8;
    _directionalityArray[10] = 1 | 2     | 8;
    _directionalityArray[11] = 1 | 2 | 4;
    _directionalityArray[12] = 1 |     4 | 8;
    _directionalityArray[13] =     2 | 4 | 8;
    
    
    
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
                if (not _visitedGrid[# _xCell, _yCell-1])
                {
                    _deltaGrid[# _xCell, _yCell-1] = _deltaGrid[# _xCell, _yCell] + 1;
                    _visitedGrid[# _xCell, _yCell] = true;
                    
                    //Perform floodfill
                    array_push(_toProcessArray, ((_yCell-1) << 32) | _xCell);
                    while(array_length(_toProcessArray) > 0)
                    {
                        var _packed = array_shift(_toProcessArray);
                        var _xFill = _packed & 0xFFFFFFFF;
                        var _yFill = _packed >> 32;
                        
                        var _tileIndex = tilemap_get(_tilemap, _xFill, _yFill);
                        var _directionality = _directionalityArray[_tileIndex];
                        if (_directionality > 0)
                        {
                            var _delta = _deltaGrid[# _xFill, _yFill];
                            
                            if ((_directionality & 0x1) && (_xFill < _tilemapWidth-1))
                            {
                                var _xOther = _xFill+1;
                                if (not _visitedGrid[# _xOther, _yFill])
                                {
                                    _deltaGrid[#   _xOther, _yFill] = _delta;
                                    _visitedGrid[# _xOther, _yFill] = true;
                                    array_push(_toProcessArray, (_yFill << 32) | _xOther);
                                }
                            }
                            
                            if ((_directionality & 0x2) && (_yFill > 0))
                            {
                                var _yOther = _yFill-1;
                                if (not _visitedGrid[# _xFill, _yOther])
                                {
                                    _deltaGrid[#   _xFill, _yOther] = _delta;
                                    _visitedGrid[# _xFill, _yOther] = true;
                                    array_push(_toProcessArray, (_yOther << 32) | _xFill);
                                }
                            }
                            
                            if ((_directionality & 0x4) && (_xFill > 0))
                            {
                                var _xOther = _xFill-1;
                                if (not _visitedGrid[# _xOther, _yFill])
                                {
                                    _deltaGrid[#   _xOther, _yFill] = _delta;
                                    _visitedGrid[# _xOther, _yFill] = true;
                                    array_push(_toProcessArray, (_yFill << 32) | _xOther);
                                }
                            }
                            
                            if ((_directionality & 0x8) && (_yFill < _tilemapHeight-1))
                            {
                                var _yOther = _yFill+1;
                                if (not _visitedGrid[# _xFill, _yOther])
                                {
                                    _deltaGrid[#   _xFill, _yOther] = _delta;
                                    _visitedGrid[# _xFill, _yOther] = true;
                                    array_push(_toProcessArray, (_yOther << 32) | _xFill);
                                }
                            }
                        }
                    }
                }
            }
            
            ++_xCell;
        }
        
        --_yCell;
    }
    
    global.tilemapWidth  = _tilemapWidth;
    global.tilemapHeight = _tilemapHeight;
    
    var _zGrid = ds_grid_create(_tilemapWidth, _tilemapHeight);
    
    var _yCell = 0;
    repeat(_tilemapHeight)
    {
        var _xCell = 0;
        repeat(_tilemapWidth)
        {
            var _tileIndex = tilemap_get(_tilemap, _xCell, _yCell);
            
            var _xTile = _tileIndex mod _tilesetWidth;
            var _yTile = _tileIndex div _tilesetWidth;
            
            var _delta = _deltaGrid[# _xCell, _yCell];
            
            if ((_xTile == 6) && (_yTile == 1))
            {
                CbTile(_tileset, _xTile, _yTile, 32*_xCell, 32*(_yCell + _delta + 1), 32*(_delta + 1));
            }
            else
            {
                CbTileFloor(_tileset, _xTile, _yTile, 32*_xCell, 32*(_yCell + _delta), 32*_delta);
                _zGrid[# _xCell, _yCell + _delta] = _delta;
            }
            
            ++_xCell;
        }
        
        ++_yCell;
    }
    
    var _yCell = 0;
    repeat(_tilemapHeight)
    {
        var _xCell = 0;
        repeat(_tilemapWidth)
        {
            var _z = _zGrid[# _xCell, _yCell];
            if (_z > 0)
            {
                var _zLeft = _zGrid[# _xCell-1, _yCell];
                var _diffLeft = _z - _zLeft;
                
                if (_diffLeft > 0)
                {
                    var _zCell = _zLeft+1;
                    repeat(_diffLeft)
                    {
                        CbTileExt(_tileset, 6, 1, 32*_xCell, 32*_yCell, 32*_zCell, 1, 1, 0, 270, c_white, 1, false);
                        ++_zCell;
                    }
                }
                
                var _zRight = _zGrid[# _xCell+1, _yCell];
                var _diffRight = _z - _zRight;
                
                if (_diffRight > 0)
                {
                    var _zCell = _zRight+1;
                    repeat(_diffRight)
                    {
                        CbTileExt(_tileset, 6, 1, 32*(_xCell+1), 32*(_yCell+1), 32*_zCell, 1, 1, 0, 90, c_white, 1, false);
                        ++_zCell;
                    }
                }
                
                var _zTop = _zGrid[# _xCell, _yCell-1];
                var _diffTop = _z - _zTop;
                
                if (_diffTop > 0)
                {
                    var _zCell = _zTop+1;
                    repeat(_diffTop)
                    {
                        CbTileExt(_tileset, 6, 1, 32*(_xCell+1), 32*_yCell, 32*_zCell, 1, 1, 0, 180, c_white, 1, false);
                        ++_zCell;
                    }
                }
            }
            
            ++_xCell;
        }
            
        ++_yCell;
    }
}