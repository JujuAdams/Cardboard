/// Returns the yaw angle used for Cardboard's billboarded sprites

function CardboardBillboardYawGet()
{
    __CARDBOARD_GLOBAL
    
    return _global.__billboardYaw;
}