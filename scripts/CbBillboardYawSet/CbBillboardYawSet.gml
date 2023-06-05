/// Sets the yaw angle used for Cb's billboarded sprites
/// This function allows use of CbSpriteBillboard*()
/// 
/// @param fromX  x-coordinate of the camera
/// @param fromY  y-coordinate of the camera
/// @param toX    x-coordinate of the camera's focal point
/// @param toY    y-coordinate of the camera's focal point

function CbBillboardYawSet(_fromX, _fromY, _toX, _toY)
{
    __CB_GLOBAL_BUILD
    
    with(_global.__billboard)
    {
        //FIXME - this is janky af lmao
        __yaw    = point_direction(_fromX, _fromY, _toX, _toY) - 90;
        __yawSin = dsin(-__yaw);
        __yawCos = dcos(-__yaw);
    }
}