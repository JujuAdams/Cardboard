/// Sets the view and projection matrices for the current Cardboard camera

function CbCameraMatricesSet()
{
    __CB_GLOBAL
    
    with(_global)
    {
        if (__oldMatrixSet)
        {
            __oldMatrixSet = false;
            
            //Track matrices that are being used
            __oldRenderStateMatrixWorld      = matrix_get(matrix_world); 
            __oldRenderStateMatrixView       = matrix_get(matrix_view); 
            __oldRenderStateMatrixProjection = matrix_get(matrix_projection);
        }
    }
    
    //Then actually set the matrices
    var _matrixStruct = CbCameraMatricesGet();
    matrix_set(matrix_view, _matrixStruct.view);
    matrix_set(matrix_projection, _matrixStruct.projection);
}