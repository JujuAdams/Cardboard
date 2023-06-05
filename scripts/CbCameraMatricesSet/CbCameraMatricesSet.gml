/// Sets the view and projection matrices for the current Cardboard camera

function CbCameraMatricesSet()
{
    __CB_GLOBAL
    
    //Track matrices that are being used
    with(_global.__oldRenderState)
    {
        if (not __set)
        {
            __set              = true;
            __worldMatrix      = matrix_get(matrix_world); 
            __viewMatrix       = matrix_get(matrix_view); 
            __projectionMatrix = matrix_get(matrix_projection);
        }
    }
    
    //Then actually set the matrices
    var _matrixStruct = CbCameraMatricesGet();
    matrix_set(matrix_view,       _matrixStruct.view);
    matrix_set(matrix_projection, _matrixStruct.projection);
}