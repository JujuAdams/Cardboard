/// Resets the yaw angle being used for Cb's billboarded sprites
/// After calling this function, billboarded sprites will not longer be able to be drawn

function CbBillboardYawReset()
{
    __CB_GLOBAL
    
    _global.__billboardYaw    = undefined;
    _global.__billboardYawSin = 0;
    _global.__billboardYawCos = 0;
}