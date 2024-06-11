/// Builds a z-tilt view matrix
/// 
/// @param fromX               x-coordinate of the camera
/// @param fromY               y-coordinate of the camera
/// @param fromZ               z-coordinate of the camera
/// @param toX                 x-coordinate of the camera's focal point
/// @param toY                 y-coordinate of the camera's focal point
/// @param toZ                 z-coordinate of the camera's focal point
/// @param [axonometric=true]  Optional, defaults to <true>; whether to use axonometric projection. This ensures sprites are never "squashed" regardless of the camera pitch angle
/// @param [upX=0]             x-component of the caFmera's up vector
/// @param [upY=0]             y-component of the camera's up vector
/// @param [upZ=1]             z-component of the camera's up vector

function CbCameraBuildZTiltViewMatrix_OLD(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _axonometric = true, _upX = 0, _upY = 0, _upZ = 1)
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

function CbCameraBuildZTiltViewMatrix(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _axonometric = true, _upX = 0, _upY = 0, _upZ = 1)
{
    static _matrix = matrix_build_identity();
    
    var _dX = _toX - _fromX;
    var _dY = _toY - _fromY;
    var _dZ = _toZ - _fromZ;
    
    var _xyDistance = sqrt(_dX*_dX + _dY*_dY);
    _dX /= _xyDistance;
    _dY /= _xyDistance;
    
    var _pzDistance = sqrt(_xyDistance*_xyDistance + _dZ*_dZ);
    var _dP  = _xyDistance / _pzDistance;
        _dZ /= _pzDistance;
    
    var _yawSin   = -_dY;
    var _yawCos   =  _dX;
    var _pitchSin = -_dZ;
    var _pitchCos =  _dP;
    
    var _ys2 = _yawSin*_yawSin;
    var _yc2 = _yawCos*_yawCos;
    var _pz  = _pitchSin * _toZ;
    
    if (_axonometric)
    {
        var _value  = 1 / _pitchSin;
        var _sc_vsc = _yawSin*_yawCos*(1 - _value);
        var _vc_s   = _value*_yc2 + _ys2;
        var _vs_c   = _value*_ys2 + _yc2;
        
        _matrix[ 0] = _vc_s;
        _matrix[ 1] = _sc_vsc;
        _matrix[ 4] = _sc_vsc;
        _matrix[ 5] = _vs_c;
        _matrix[ 8] = _pitchSin*_yawCos;
        _matrix[ 9] = -_pitchSin*_yawSin;
        _matrix[10] = _pitchCos;
        _matrix[12] = -(_toX*_vc_s)   - (_toY*_sc_vsc) - (_pz*_yawCos) + _toX;
        _matrix[13] = -(_toX*_sc_vsc) - (_toY*_vs_c)   + (_pz*_yawSin) + _toY;
        _matrix[14] = _toZ*(1 - _pitchCos);
    }
    else
    {
        _matrix[ 0] = 1;
        _matrix[ 1] = 0;
        _matrix[ 4] = 0;
        _matrix[ 5] = 1;
        _matrix[ 8] =  _pitchSin*_yawCos;
        _matrix[ 9] = -_pitchSin*_yawSin;
        _matrix[10] =  _pitchCos;
        _matrix[12] = -_pz*_yawCos;
        _matrix[13] = _pz*_yawSin;
        _matrix[14] = _toZ*(1 - _pitchCos);
    }
    
    matrix_stack_push(matrix_build_lookat(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _upX, _upY, _upZ));
    matrix_stack_push(_matrix);
    var _result = matrix_stack_top();
    matrix_stack_clear();
    
    return _result;
}