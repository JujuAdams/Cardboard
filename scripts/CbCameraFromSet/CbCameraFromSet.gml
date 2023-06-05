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
        
        CbBillboardYawSet(_x, _y, __xTo, __yTo);
    }
}