/// Sets the yaw angle used for Cardboard's billboarded sprites
/// This function allows use of CardboardSpriteBillboard*()
/// 
/// @param fromX  x-coordinate of the camera
/// @param fromY  y-coordinate of the camera
/// @param toX    x-coordinate of the camera's focal point
/// @param toY    y-coordinate of the camera's focal point

function CardboardBillboardYawSet(_fromX, _fromY, _toX, _toY)
{
    //FIXME - this is janky af lmao
    global.__cardboardBillboardYaw    = point_direction(_fromX, _fromY, _toX, _toY) - 90;
    global.__cardboardBillboardYawSin = dsin(-global.__cardboardBillboardYaw);
    global.__cardboardBillboardYawCos = dcos(-global.__cardboardBillboardYaw);
}