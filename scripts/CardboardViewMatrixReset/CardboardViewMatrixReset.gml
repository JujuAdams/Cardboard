/// Resets GameMaker's active view matrix, as set by CardboardViewMatrixSet()

function CardboardViewMatrixReset()
{
    CardboardBillboardYawReset();
    
    matrix_set(matrix_view, global.__cardboardOldViewMatrix);
}