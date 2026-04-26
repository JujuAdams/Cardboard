// Feather disable all

/// Returns the yaw angle used for Cb's billboarded sprites

function CbBillboardGetYaw()
{
    __CB_GLOBAL_BUILD
    
    return _global.__billboard.__yaw;
}