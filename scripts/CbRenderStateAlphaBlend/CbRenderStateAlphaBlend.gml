/// @param [unlit=false]
/// @param [viewMatrixHint]
/// @param [projectionMatrixHint]

function CbRenderStateAlphaBlend(_unlit = false, _viewMatrix = undefined, _projectionMatrix = undefined)
{
    __CB_GLOBAL_RENDER
    
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(false); //Don't write into the depth buffer!
    gpu_set_cullmode(_global.__backfaceCulling? CB_CULLING_DIRECTION : cull_noculling);
    __CbRenderShaderSwitch(_unlit? CB_LIGHT_MODE.DISABLE_LIGHTING : _global.__lighting.__lightMode, _viewMatrix, _projectionMatrix);
}