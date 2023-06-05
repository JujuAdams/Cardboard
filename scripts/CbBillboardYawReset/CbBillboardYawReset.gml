/// Resets the yaw angle being used for Cb's billboarded sprites
/// After calling this function, billboarded sprites will not longer be able to be drawn

function CbBillboardYawReset()
{
    __CB_GLOBAL
    
    with(_global.__billboard)
    {
        __yaw    = undefined;
        __yawSin = 0;
        __yawCos = 0;
    }
}