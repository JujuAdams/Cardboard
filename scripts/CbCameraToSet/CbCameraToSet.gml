/// Sets the "to" position of Cardboard's camera
/// 
/// @param 

function CbCameraToSet(_x, _y, _z)
{
    __CB_GLOBAL_RENDER
    
    with(_global.__camera)
    {
        __xTo = _x;
        __yTo = _y;
        __zTo = _z;
        
        CbBillboardYawSet(__xFrom, __yFrom, _x, _y);
    }
}