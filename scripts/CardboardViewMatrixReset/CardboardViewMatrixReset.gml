/// Resets GameMaker's active view matrix, as set by CardboardViewMatrixSet()

function CardboardViewMatrixReset()
{
    global.__cardboardBillboardYaw = undefined;
    matrix_set(matrix_view, global.__cardboardOldViewMatrix);
}