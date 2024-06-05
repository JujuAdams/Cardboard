/// @param animatedTilemapModel
/// @param frame
/// @param [setShader=true]

function CbTilemapAnimatedSubmit(_animatedTilemapModel, _frame, _setShader = true)
{
    static _shdTilemapAnimatedNormals_u_fAnimFrame = shader_get_uniform(__shdTilemapAnimatedNormals, "u_fAnimFrame");
    static _shdTilemapAnimated_u_fAnimFrame        = shader_get_uniform(__shdTilemapAnimated,        "u_fAnimFrame");
    
    if (_setShader)
    {
        if (CB_WRITE_NORMALS)
        {
            shader_set(__shdTilemapAnimatedNormals);
            shader_set_uniform_f(_shdTilemapAnimatedNormals_u_fAnimFrame, floor(_frame));
            vertex_submit(_animatedTilemapModel.__vertexBuffer, pr_trianglelist, _animatedTilemapModel.__texture);
            shader_reset();
        }
        else
        {
            shader_set(__shdTilemapAnimated);
            shader_set_uniform_f(_shdTilemapAnimated_u_fAnimFrame, floor(_frame));
            vertex_submit(_animatedTilemapModel.__vertexBuffer, pr_trianglelist, _animatedTilemapModel.__texture);
            shader_reset();
        }
    }
    else
    {
        vertex_submit(_animatedTilemapModel.__vertexBuffer, pr_trianglelist, _animatedTilemapModel.__texture);
    }
}