/// Resets the yaw angle being used for Cardboard's billboarded sprites
/// After calling this function, billboarded sprites will not longer be able to be drawn

function CardboardBillboardYawReset()
{
    global.__cardboardBillboardYaw    = undefined;
    global.__cardboardBillboardYawSin = 0;
    global.__cardboardBillboardYawCos = 0;
}