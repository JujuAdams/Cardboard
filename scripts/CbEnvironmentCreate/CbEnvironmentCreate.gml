function CbEnvironmentCreate()
{
    return new __CbClassEnvironment();
}

function __CbClassEnvironment() constructor
{
    __destroyed = false;
    
    __cellWidth  = 1;
    __cellHeight = 1;
    __cellDepth  = 1;
    
    __gridWidth  = undefined;
    __gridHeight = undefined;
    
    __roomZOffsetGrid = undefined;
    __zGrid = undefined;
    
    __model = undefined;
    
    
    
    static BuildFromTilemap = function(_tilemap)
    {
        __model = CbModelCreate();
        CbModelOpen(__model);
        
        __gridWidth  = tilemap_get_width(_tilemap);
        __gridHeight = tilemap_get_height(_tilemap);
        
        var _tileset     = tilemap_get_tileset(_tilemap);
        var _tilesetData = __CbTilesetDataGet(_tileset);
        
        __cellWidth  = _tilesetData.__tileWidth;
        __cellHeight = _tilesetData.__tileHeight;
        __cellDepth  = __cellHeight;
        
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
        
        
        
        __roomZOffsetGrid = ds_grid_create(__gridWidth, __gridHeight);
        __zGrid = ds_grid_create(__gridWidth, __gridHeight);
        var _visitedGrid = ds_grid_create(__gridWidth, __gridHeight);
    
        var _toProcessArray = [];
    
        var _yCell = __gridHeight-1;
        repeat(__gridHeight)
        {
            var _xCell = 0;
            repeat(__gridWidth)
            {
                var _tileIndex = tilemap_get(_tilemap, _xCell, _yCell);
            
                var _xTile = _tileIndex mod _tilesetWidth;
                var _yTile = _tileIndex div _tilesetWidth;
            
                if ((_xTile == 6) && (_yTile == 1))
                {
                    if (not _visitedGrid[# _xCell, _yCell-1])
                    {
                        __roomZOffsetGrid[# _xCell, _yCell-1] = __roomZOffsetGrid[# _xCell, _yCell] + 1;
                        _visitedGrid[# _xCell, _yCell] = true;
                    
                        //Perform floodfill
                        array_push(_toProcessArray, ((_yCell-1) << 32) | _xCell);
                        while(array_length(_toProcessArray) > 0)
                        {
                            var _packed = array_shift(_toProcessArray);
                            var _xFill = _packed & 0xFFFFFFFF;
                            var _yFill = _packed >> 32;
                        
                            var _delta = __roomZOffsetGrid[# _xFill, _yFill];
                        
                            //Backfill displaced tiles
                            if (_delta > 0)
                            {
                                CbTileFloor(_tileset, 6, 0, __cellWidth*_xFill, __cellHeight*_yFill, 0);
                            }
                        
                            var _tileIndex = tilemap_get(_tilemap, _xFill, _yFill);
                            var _directionality = _directionalityArray[_tileIndex];
                            if (_directionality > 0)
                            {
                            
                                if ((_directionality & 0x1) && (_xFill < __gridWidth-1))
                                {
                                    var _xOther = _xFill+1;
                                    if (not _visitedGrid[# _xOther, _yFill])
                                    {
                                        __roomZOffsetGrid[#   _xOther, _yFill] = _delta;
                                        _visitedGrid[# _xOther, _yFill] = true;
                                        array_push(_toProcessArray, (_yFill << 32) | _xOther);
                                    }
                                }
                            
                                if ((_directionality & 0x2) && (_yFill > 0))
                                {
                                    var _yOther = _yFill-1;
                                    if (not _visitedGrid[# _xFill, _yOther])
                                    {
                                        __roomZOffsetGrid[#   _xFill, _yOther] = _delta;
                                        _visitedGrid[# _xFill, _yOther] = true;
                                        array_push(_toProcessArray, (_yOther << 32) | _xFill);
                                    }
                                }
                            
                                if ((_directionality & 0x4) && (_xFill > 0))
                                {
                                    var _xOther = _xFill-1;
                                    if (not _visitedGrid[# _xOther, _yFill])
                                    {
                                        __roomZOffsetGrid[#   _xOther, _yFill] = _delta;
                                        _visitedGrid[# _xOther, _yFill] = true;
                                        array_push(_toProcessArray, (_yFill << 32) | _xOther);
                                    }
                                }
                            
                                if ((_directionality & 0x8) && (_yFill < __gridHeight-1))
                                {
                                    var _yOther = _yFill+1;
                                    if (not _visitedGrid[# _xFill, _yOther])
                                    {
                                        __roomZOffsetGrid[#   _xFill, _yOther] = _delta;
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
        
        ds_grid_destroy(_visitedGrid);
    
        var _yCell = 0;
        repeat(__gridHeight)
        {
            var _xCell = 0;
            repeat(__gridWidth)
            {
                var _tileIndex = tilemap_get(_tilemap, _xCell, _yCell);
            
                var _xTile = _tileIndex mod _tilesetWidth;
                var _yTile = _tileIndex div _tilesetWidth;
            
                var _delta = __roomZOffsetGrid[# _xCell, _yCell];
            
                if ((_xTile == 6) && (_yTile == 1))
                {
                    CbTile(_tileset, _xTile, _yTile, __cellWidth*_xCell, __cellHeight*(_yCell + _delta + 1), __cellDepth*(_delta + 1));
                }
                else
                {
                    CbTileFloor(_tileset, _xTile, _yTile, __cellWidth*_xCell, __cellHeight*(_yCell + _delta), __cellDepth*_delta);
                    __zGrid[# _xCell, _yCell + _delta] = _delta;
                }
            
                ++_xCell;
            }
        
            ++_yCell;
        }
    
        var _yCell = 0;
        repeat(__gridHeight)
        {
            var _xCell = 0;
            repeat(__gridWidth)
            {
                var _z = __zGrid[# _xCell, _yCell];
                if (_z > 0)
                {
                    var _zLeft = __zGrid[# _xCell-1, _yCell];
                    var _diffLeft = _z - _zLeft;
                
                    if (_diffLeft > 0)
                    {
                        var _zCell = _zLeft+1;
                        repeat(_diffLeft)
                        {
                            CbTileExt(_tileset, 6, 1, __cellWidth*_xCell, __cellHeight*_yCell, __cellDepth*_zCell, 1, 1, 0, 270, c_white, 1, false);
                            ++_zCell;
                        }
                    }
                
                    var _zRight = __zGrid[# _xCell+1, _yCell];
                    var _diffRight = _z - _zRight;
                
                    if (_diffRight > 0)
                    {
                        var _zCell = _zRight+1;
                        repeat(_diffRight)
                        {
                            CbTileExt(_tileset, 6, 1, __cellWidth*(_xCell+1), __cellHeight*(_yCell+1), __cellDepth*_zCell, 1, 1, 0, 90, c_white, 1, false);
                            ++_zCell;
                        }
                    }
                
                    var _zTop = __zGrid[# _xCell, _yCell-1];
                    var _diffTop = _z - _zTop;
                
                    if (_diffTop > 0)
                    {
                        var _zCell = _zTop+1;
                        repeat(_diffTop)
                        {
                            CbTileExt(_tileset, 6, 1, __cellWidth*(_xCell+1), __cellHeight*_yCell, __cellDepth*_zCell, 1, 1, 0, 180, c_white, 1, false);
                            ++_zCell;
                        }
                    }
                }
            
                ++_xCell;
            }
            
            ++_yCell;
        }
        
        CbModelClose();
    }
    
    static RoomCoordToWorldCoord = function(_x, _y)
    {
        static _result = {
            x: 0,
            y: 0,
            z: 0,
        };
        
        if (__zGrid == undefined)
        {
            var _z = 0;
        }
        else
        {
            var _z = __cellDepth*(__roomZOffsetGrid[# clamp(_x div __cellWidth, 0, __gridWidth-1), clamp(_y div __cellHeight, 0, __gridHeight-1)] ?? 0);
        }
        
        _result.x = _x;
        _result.y = _y + _z;
        _result.z = _z;
        
        return _result;
    }
    
    static GetZ = function(_x, _y)
    {
        return __cellDepth*(__zGrid[# clamp(_x div __cellWidth, 0, __gridWidth-1), clamp(_y div __cellHeight, 0, __gridHeight-1)] ?? 0);
    }
    
    static GetRoomZOffsetGrid = function()
    {
        return __roomZOffsetGrid;
    }
    
    static GetZGrid = function()
    {
        return __zGrid;
    }
    
    static GetModel = function()
    {
        return __model;
    }
    
    static Destroy = function()
    {
        if (__destroyed) return;
        __destroyed = true;
        
        if (__roomZOffsetGrid != undefined)
        {
            ds_grid_destroy(__roomZOffsetGrid);
            __roomZOffsetGrid = undefined;
        }
        
        if (__zGrid != undefined)
        {
            ds_grid_destroy(__zGrid);
            __zGrid = undefined;
        }
    }
}