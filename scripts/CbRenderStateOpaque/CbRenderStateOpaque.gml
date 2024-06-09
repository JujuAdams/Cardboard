/// @param [unlit=false]
/// @param [alphaTest=true]
/// @param [viewMatrixHint]
/// @param [projectionMatrixHint]

function CbRenderStateOpaque(_unlit = false, _alphaTest = true, _viewMatrix = undefined, _projectionMatrix = undefined)
{
    __CB_GLOBAL_RENDER
    
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(_global.__backfaceCulling? CB_CULLING_DIRECTION : cull_noculling);
    
    if (_alphaTest)
    {
        gpu_set_alphatestenable(true);
        gpu_set_alphatestref(_global.__alphaTestRef);
    }
    
    gpu_set_blendenable(false);
    __CbRenderShaderSwitch(_unlit? CB_LIGHT_MODE.DISABLE_LIGHTING : _global.__lighting.__lightMode, _viewMatrix, _projectionMatrix);
}