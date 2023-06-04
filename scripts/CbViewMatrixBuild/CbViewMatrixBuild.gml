/// Builds a z-tilt view matrix
/// 
/// @param fromX               x-coordinate of the camera
/// @param fromY               y-coordinate of the camera
/// @param fromZ               z-coordinate of the camera
/// @param toX                 x-coordinate of the camera's focal point
/// @param toY                 y-coordinate of the camera's focal point
/// @param toZ                 z-coordinate of the camera's focal point
/// @param [axonometric=true]  Optional, defaults to <true>; whether to use axonometric projection. This ensures sprites are never "squashed" regardless of the camera pitch angle
/// @param [upX=0]             x-component of the camera's up vector
/// @param [upY=0]             y-component of the camera's up vector
/// @param [upZ=1]             z-component of the camera's up vector

function CbViewMatrixBuild(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _axonometric = true, _upX = 0, _upY = 0, _upZ = 1)
{
    var _xyDistance = point_distance(_fromX, _fromY, _toX, _toY);
    var _yaw = point_direction(_fromX, _fromY, _toX, _toY);
    var _pitch = point_direction(0, _fromZ, _xyDistance, _toZ);
    
    var _pitchSin = dsin(_pitch);
    var _pitchCos = dcos(_pitch);
    
    //There is definitely a faster way to do all of this
    var _tiltMatrix = matrix_build(-_toX, -_toY, -_toZ,   0,0,0,   1,1,1);
    _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0, 0, -_yaw,   1,1,1));
    
    if (_axonometric) _tiltMatrix = matrix_multiply(_tiltMatrix, matrix_build(0,0,0,   0,0,0, 1/_pitchSin, 1, 1));
    
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