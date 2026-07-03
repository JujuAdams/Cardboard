/// Sets the global GPU projection matrix. This function should be called in place of
/// `matrix_set(matrix_projection, matrix)`.
/// 
/// @param projectionMatrix

function __CbSetProjectionMatrix(_matrix)
{
    static _staticMatrix = matrix_build_identity();
    
    matrix_set(matrix_projection, CB_RENDER_NORMATIVE? _matrix : __CbFixProjectionMatrix(_matrix, _staticMatrix));
}