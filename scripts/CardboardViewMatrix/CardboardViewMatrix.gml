/// @param fromX
/// @param fromY
/// @param toX
/// @param toY
/// @param toZ

function CardboardViewMatrix(_fromX, _fromY, _toX, _toY, _toZ)
{
    var _xyDistance = point_distance(_fromX, _fromY, _toX, _toY);
    var _yaw = point_direction(_fromX, _fromY, _toX, _toY);
    
    //There is definitely a faster way to do all of this
    var _tiltMatrix = matrix_build(-_toX, -_toY, -_toZ,   0,0,0,   1,1,1);
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0, 0, -_yaw,   1,1,1));
    
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0,0,0,   sqrt(2), 1, 1));
    
    _tiltMatrix = matrix_multiply(_tiltMatrix, [
        1, 0, 0, 0,
        0, 1, 0, 0,
        sqrt(1/2), 0, sqrt(1/2), 0,
        0, 0, 0, 1,
    ]);
    
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0, 0, _yaw,   1,1,1));
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(_toX, _toY, _toZ,   0,0,0,   1,1,1));
    
    var _lookatMatrix = matrix_build_lookat(_fromX, _fromY, _xyDistance + _toZ, _toX, _toY, _toZ, 0, 0, 1);
    return matrix_multiply(_tiltMatrix, _lookatMatrix);
}