/// Resets GameMaker's active view matrix, as set by CbViewMatrixSet()

function CbViewMatrixReset()
{
    __CB_GLOBAL
    
    CbBillboardYawReset();
    
    matrix_set(matrix_view, _global.__oldMatrixView);
}