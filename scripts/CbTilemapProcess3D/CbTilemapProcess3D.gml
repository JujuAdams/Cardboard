/// @param ruleset
/// @param tilemapArray
/// @param xOffset
/// @param yOffset
/// @param zOffset
/// @param xSize
/// @param ySize
/// @param zSize

function CbTilemapProcess3D(_ruleset, _tilemapArray, _xOffset, _yOffset, _zOffset, _xSize, _ySize, _zSize)
{
    if (array_length(_tilemapArray) <= 0) return;
    
    var _tilemapBelow = undefined;
    var _tilemap      = undefined;
    var _tilemapAbove = _tilemapArray[0];
    
    var _zWorld = _zOffset;
    
    var _i = 1;
    repeat(array_length(_tilemapArray)-1)
    {
        _tilemapBelow = _tilemap;
        _tilemap      = _tilemapAbove;
        _tilemapAbove = _tilemapArray[_i];
        CbTilemapProcess2D(_ruleset, _tilemapBelow, _tilemap, _tilemapAbove, _xOffset, _yOffset, _zWorld, _xSize, _ySize, _zSize);
        
        _zWorld += _zSize;
        ++_i;
    }
    
    _tilemapBelow = _tilemap;
    _tilemap      = _tilemapAbove;
    _tilemapAbove = undefined;
    CbTilemapProcess2D(_ruleset, _tilemapBelow, _tilemap, _tilemapAbove, _xOffset, _yOffset, _zWorld, _xSize, _ySize, _zSize);
}