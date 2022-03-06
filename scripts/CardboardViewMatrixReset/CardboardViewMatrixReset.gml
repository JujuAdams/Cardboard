function CardboardViewMatrixReset()
{
    global.__cardboardBillboardYaw = undefined;
    matrix_set(matrix_view, global.__cardboardOldViewMatrix);
}