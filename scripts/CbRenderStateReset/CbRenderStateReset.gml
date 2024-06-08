/// Resets the GPU render state for the given pass
/// This will set matrices, z-testing, and the current shader

function CbRenderStateReset()
{
    __CB_GLOBAL_RENDER
    
    CbRenderShaderReset();
    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
    gpu_set_cullmode(cull_noculling);
    gpu_set_alphatestenable(false);
}