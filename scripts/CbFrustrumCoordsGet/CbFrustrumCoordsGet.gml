// Feather disable all

/// @param viewMatrix
/// @param projMatrix

function CbFrustrumCoordsGet(_viewMatrix, _projMatrix)
{
    __CB_GLOBAL_RENDER
    
    static _result = {
        tlNear: undefined,
        trNear: undefined,
        blNear: undefined,
        brNear: undefined,
        tlFar:  undefined,
        trFar:  undefined,
        blFar:  undefined,
        brFar:  undefined,
    };
    
    var _vpMatrixInverse = __CbMatrixInvert(matrix_multiply(_viewMatrix, _projMatrix));
    
    with(_result)
    {
        tlNear = matrix_transform_vector_4d_div_w(_vpMatrixInverse, -1, -1, 0, 1);
        trNear = matrix_transform_vector_4d_div_w(_vpMatrixInverse,  1, -1, 0, 1);
        blNear = matrix_transform_vector_4d_div_w(_vpMatrixInverse, -1,  1, 0, 1);
        brNear = matrix_transform_vector_4d_div_w(_vpMatrixInverse,  1,  1, 0, 1);
        tlFar  = matrix_transform_vector_4d_div_w(_vpMatrixInverse, -1, -1, 1, 1);
        trFar  = matrix_transform_vector_4d_div_w(_vpMatrixInverse,  1, -1, 1, 1);
        blFar  = matrix_transform_vector_4d_div_w(_vpMatrixInverse, -1,  1, 1, 1);
        brFar  = matrix_transform_vector_4d_div_w(_vpMatrixInverse,  1,  1, 1, 1);
    }
    
    return _result;
}