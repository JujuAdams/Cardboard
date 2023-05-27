/// Sets the yaw angle used for Cardboard's billboarded sprites
/// This function allows use of CardboardSpriteBillboard*()
/// 
/// @param fromX  x-coordinate of the camera
/// @param fromY  y-coordinate of the camera
/// @param toX    x-coordinate of the camera's focal point
/// @param toY    y-coordinate of the camera's focal point

function CardboardBillboardYawSet(_fromX, _fromY, _toX, _toY)
{
    __CARDBOARD_GLOBAL
    
    //FIXME - this is janky af lmao
    _global.__billboardYaw    = point_direction(_fromX, _fromY, _toX, _toY) - 90;
    _global.__billboardYawSin = dsin(-_global.__billboardYaw);
    _global.__billboardYawCos = dcos(-_global.__billboardYaw);
}