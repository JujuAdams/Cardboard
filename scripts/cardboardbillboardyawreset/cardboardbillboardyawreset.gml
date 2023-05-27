/// Resets the yaw angle being used for Cardboard's billboarded sprites
/// After calling this function, billboarded sprites will not longer be able to be drawn

function CardboardBillboardYawReset()
{
    __CARDBOARD_GLOBAL
    
    _global.__billboardYaw    = undefined;
    _global.__billboardYawSin = 0;
    _global.__billboardYawCos = 0;
}