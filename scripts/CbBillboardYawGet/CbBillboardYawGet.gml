/// Returns the yaw angle used for Cb's billboarded sprites

function CbBillboardYawGet()
{
    __CB_GLOBAL
    
    return _global.__billboard.__yaw;
}