/// @param fromX
/// @param fromY
/// @param fromZ
/// @param toX
/// @param toY
/// @param toZ
/// @param [upX=0]
/// @param [upY=0]
/// @param [upZ=1]

function CardboardViewMatrixExt(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _upX = 0, _upY = 0, _upZ = 1)
{
    var _xyDistance = point_distance(_fromX, _fromY, _toX, _toY);
    var _yaw = point_direction(_fromX, _fromY, _toX, _toY);
    var _pitch = point_direction(0, _fromZ, _xyDistance, _toZ);
    
    var _pitchSin = dsin(_pitch);
    var _pitchCos = dcos(_pitch);
    
    //There is definitely a faster way to do all of this
    var _tiltMatrix = matrix_build(-_toX, -_toY, -_toZ,   0,0,0,   1,1,1);
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0, 0, -_yaw,   1,1,1));
    
    
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0,0,0,   1/_pitchSin, 1, 1));
    
    _tiltMatrix = matrix_multiply(_tiltMatrix, [
        1, 0, 0, 0,
        0, 1, 0, 0,
        _pitchSin, 0, _pitchCos, 0,
        0, 0, 0, 1,
    ]);
    
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0, 0, _yaw,   1,1,1));
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(_toX, _toY, _toZ,   0,0,0,   1,1,1));
    
    var _lookatMatrix = matrix_build_lookat(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _upX, _upY, _upZ);
    return matrix_multiply(_tiltMatrix, _lookatMatrix);
}

/*
function CardboardViewMatrix(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _upX = 0, _upY = 0, _upZ = 1)
{
    var _yaw   = 90 - point_direction(_fromX, _fromY, _toX, _toY);
    var _pitch = point_direction(_fromY, _fromZ, _toY, _toZ);
    
    var _tiltMatrix = matrix_build(0,0,0,   0,0,0,   1,1,1);
    
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(-_toX, -_toY, -_toZ,   0,0,0,   1,1,1));
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0, 0, _yaw,   1,1,1));
    
    //Correct y-height
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0,0,0,   1,1/dsin(_pitch),1));
    
    //Skew
    _tiltMatrix = matrix_multiply(_tiltMatrix, [
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, -dsin(_pitch), -dcos(_pitch), 0,
        0, 0, 0, 1,
    ]);
    
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0, 0, -_yaw,   1,1,1));
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(_toX, _toY, _toZ,   0,0,0,   1,1,1));
    
    var _lookatMatrix = matrix_build_lookat(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _upX, _upY, _upZ);
    return matrix_multiply(_tiltMatrix, _lookatMatrix);
}
*/