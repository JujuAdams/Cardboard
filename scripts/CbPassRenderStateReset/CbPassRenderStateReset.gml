/// Resets the GPU render state for the given pass
/// This will set matrices, z-testing, and the current shader

function CbPassRenderStateReset()
{
    __CB_GLOBAL
    
    //Reset GPU state
    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
    gpu_set_cullmode(cull_noculling);
    gpu_set_alphatestenable(false);
    shader_reset();
    surface_reset_target();
    
    //Restore the old matrices we've been using
    matrix_set(matrix_world,      _global.__oldRenderStateMatrixWorld);
    matrix_set(matrix_view,       _global.__oldRenderStateMatrixView);
    matrix_set(matrix_projection, _global.__oldRenderStateMatrixProjection);
}