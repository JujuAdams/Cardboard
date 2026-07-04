// Feather disable all

/// Resets the GPU render state:
/// - Disables z-writing and z-testing
/// - Disables culling
/// - Disables alpha testing
/// - Enables RGB and alpha writing
/// - Enables alpha blending
/// - Resets the active shader

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
    }
}