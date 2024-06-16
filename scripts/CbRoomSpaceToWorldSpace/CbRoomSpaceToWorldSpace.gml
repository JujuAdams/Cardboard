/// @param roomX
/// @param roomY
/// @param deltaGrid
/// @param cellWidth
/// @param cellHeight
/// @param [cellDepth=cellHeight]

function CbRoomSpaceToWorldSpace(_x, _y, _zGrid, _cellWidth, _cellHeight, _cellDepth = _cellHeight)
{
    static _result = {
        x: 0,
        y: 0,
        z: 0,
    };
    
    if (_zGrid == undefined)
    {
        var _z = 0;
    }
    else
    {
        var _z = _cellDepth*(_zGrid[# clamp(_x div _cellWidth, 0, ds_grid_width(_zGrid)-1), clamp(_y div _cellHeight, 0, ds_grid_height(_zGrid)-1)] ?? 0);
    }
    
    _result.x = _x;
    _result.y = _y + _z;
    _result.z = _z;
    
    return _result;
}