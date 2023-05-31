/// Resets the rendering state set by CbRendererSet()

function CbRenderStateReset()
{
    __CB_GLOBAL
    
    //If we've got a pending batch then submit that before resetting draw state
    CbBatchForceSubmit();
    
    //Reset GPU state
    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
    gpu_set_cullmode(cull_noculling);
    gpu_set_alphatestenable(false);
    
    //Restore the old matrices we've been using
    matrix_set(matrix_world,      _global.__oldRenderStateMatrixWorld);
    matrix_set(matrix_view,       _global.__oldRenderStateMatrixView);
    matrix_set(matrix_projection, _global.__oldRenderStateMatrixProjection);
}