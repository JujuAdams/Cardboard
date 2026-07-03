/// Sets a shader uniform to a projection matrix, after applying any necessary fixes.
/// 
/// @param uniformID
/// @param projectionMatrix

function __CbSetProjectionMatrixUniform(uniform_id, projection_matrix)
{
    static static_matrix = array_create(16);
    shader_set_uniform_matrix_array(uniform_id, CB_RENDER_NORMATIVE? projection_matrix : __CbFixProjectionMatrix(projection_matrix, static_matrix));
}