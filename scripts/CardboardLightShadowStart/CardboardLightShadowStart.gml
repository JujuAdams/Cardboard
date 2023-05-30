/// @param index
/// @param [setShader=true]

function CardboardLightShadowStart(_index, _setShader = true)
{
    __CARDBOARD_GLOBAL
    
    if (_global.__lightingShadowCurrent != undefined)
    {
        __CardboardError("Cannot set shadow mapping as a shadow mapping is already set (", _global.__lightingShadowCurrent, ")");
    }
    
    if (_index > __CARDBOARD_SHADOW_COUNT)
    {
        __CardboardError("Cannot set shadow mapping for light ", _index, " (shadow mapping can only be applied to light 0 and light 1)");
    }
    
    with(_global.__lightingShadowArray[_index])
    {
        if (not __state)
        {
            __CardboardError("Cannot set shadow mapping surface for light ", _index, " as it has been disabled");
        }
        
        _global.__lightingShadowCurrent = _index;
        
        //Ensure the surface exists
        __Tick();
        __BuildMatrix();
        
        __oldViewMatrix = matrix_get(matrix_view);
        __oldProjMatrix = matrix_get(matrix_projection);
        
        surface_set_target(__surface);
        draw_clear(c_white);
        
        gpu_set_ztestenable(true);
        gpu_set_zwriteenable(true);
        gpu_set_cullmode(cull_counterclockwise);
        
        if (_setShader)
        {
            shader_set(__shdCardboardDepth);
            shader_set_uniform_f(shader_get_uniform(__shdCardboardDepth, "u_fAlphaTestRef"), _global.__alphaTestRef);
            shader_set_uniform_f(shader_get_uniform(__shdCardboardDepth, "u_vZ"), __near, __far);
        }
        
        matrix_set(matrix_view,       __matrixView);
        matrix_set(matrix_projection, __matrixProj);
    }
}