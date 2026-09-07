// Feather disable all

/// Sets the yaw angle used for Cb's billboarded sprites
/// This function allows use of CbSpriteBillboard*()
/// 
/// @param yaw  Yaw angle for the camera

function CbBillboardSetYaw(_yaw)
{
    __CB_GLOBAL_BUILD
    
    with(_global.__billboard)
    {
        __yaw    = _yaw - 90;
        __yawSin = dsin(_yaw);
        __yawCos = dcos(_yaw);
    }
}