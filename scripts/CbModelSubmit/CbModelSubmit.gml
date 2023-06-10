/// Submits the given model to the GPU (draws the model)
/// 
/// @param model  The model to submit to the GPU

function CbModelSubmit(_model)
{
    __CB_GLOBAL_BUILD
    var __global = _global;
    
    var _r = color_get_red(  _global.__indexInteger)/255
    var _g = color_get_green(_global.__indexInteger)/255
    var _b = color_get_blue( _global.__indexInteger)/255
    shader_set_uniform_f(_global.__shaderIndexOffsetUniform, _r, _g, _b);
    
    _model.__Submit();
    
    shader_set_uniform_f(_global.__shaderIndexOffsetUniform, 0, 0, 0);
    
    if (CB_WRITE_NORMALS)
    {
        _global.__indexInteger += _model.__indexMax;
    }
}