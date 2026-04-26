// Feather disable all

/// Sets the game's render state to draw opaque graphics.
/// 
/// This function sets the following state:
/// - Enables z-writing and z-testing
/// - Sets backface culling (based on `CbSetBackfaceCulling()`)
/// - Enables alpha testing (if `alphaTest` parameter is set to `true`)
/// - Sets alpha test reference (based on `CbSetAlphaTestRef()`)
/// - Disables alpha blending
/// - Sets shader (based on `unlit` parameter and `CbSetLightingMode()`)
/// 
/// @param [unlit=false]
/// @param [alphaTest=true]
/// @param [viewMatrix]
/// @param [projectionMatrix]

function CbRenderStateOpaque(_unlit = false, _alphaTest = true, _viewMatrix = undefined, _projMatrix = undefined)
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
    __CbRenderShaderSwitch(_unlit? CB_LIGHTING_DISABLED : _global.__lighting.__lightMode, _viewMatrix, _projMatrix);
}