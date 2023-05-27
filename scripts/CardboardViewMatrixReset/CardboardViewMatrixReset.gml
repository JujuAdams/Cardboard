/// Resets GameMaker's active view matrix, as set by CardboardViewMatrixSet()

function CardboardViewMatrixReset()
{
    __CARDBOARD_GLOBAL
    
    CardboardBillboardYawReset();
    
    matrix_set(matrix_view, _global.__oldMatrixView);
}