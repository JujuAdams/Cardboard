/// Sets the "from" position of Cardboard's camera
/// 
/// @param 

function CbCameraFromSet(_x, _y, _z)
{
    __CB_GLOBAL_RENDER
    
    with(_global.__camera)
    {
        __xFrom = _x;
        __yFrom = _y;
        __zFrom = _z;
        
        if (_global.__billboardYawSetFunc != undefined)
        {
            _global.__billboardYawSetFunc(__xFrom, __yFrom, __xTo, __yTo);
        }
    }
}