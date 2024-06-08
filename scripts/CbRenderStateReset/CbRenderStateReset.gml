/// Resets the GPU render state for the given pass
/// This will set matrices, z-testing, and the current shader

function CbRenderStateReset()
{
    __CB_GLOBAL_RENDER
    
    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
    gpu_set_cullmode(cull_noculling);
    gpu_set_alphatestenable(false);
    gpu_set_colorwriteenable(true, true, true, true);
    gpu_set_blendenable(true);
    shader_reset();
    
    if (_global.__surfaceWorkaround)
    {
        _global.__surfaceWorkaround = false;
        surface_reset_target();
        if (__CB_SURFACE_SET_TARGET_EXT_WORKAROUND) surface_reset_target();
    }
}