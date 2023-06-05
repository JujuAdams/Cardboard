/// Sets the "up" position of Cardboard's camera
/// 
/// @param 

function CbCameraUpSet(_x, _y, _z)
{
    __CB_GLOBAL_RENDER
    
    with(_global.__camera)
    {
        __xUp = _x;
        __yUp = _y;
        __zUp = _z;
    }
}