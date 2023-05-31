function CbDeferredLightEnd()
{
    __CB_GLOBAL
    
    if (_global.__lightingShadowCurrent == undefined)
    {
        __CbError("Cannot end shadow mapping as a shadow mapping is not set");
    }
    
    //If we've got a pending batch then submit that before resetting draw state
    CbBatchForceSubmit();
    
    shader_reset();
    surface_reset_target();
    
    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
    gpu_set_cullmode(cull_noculling);
    
    with(_global.__lightingShadowArray[_global.__lightingShadowCurrent])
    {
        matrix_set(matrix_view,       __oldViewMatrix);
        matrix_set(matrix_projection, __oldProjMatrix);
    }
    
    _global.__lightingShadowCurrent = undefined;
}