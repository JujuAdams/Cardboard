function CardboardViewMatrixReset()
{
    global.__cardboardBillboardYaw = 0;
    matrix_set(matrix_view, global.__cardboardOldViewMatrix);
}