// Feather disable all

/// Sets the game's render state to draw only into the depth buffer.
/// 
/// This function sets the following state:
/// - Enables z-writing and z-testing
/// - Sets backface culling (based on `CbSetBackfaceCulling()`)
/// - Enables alpha testing
/// - Sets alpha test reference (based on `CbSetAlphaTestRef()`)
/// - Disables RGB and alpha writing
/// - Disables alpha blending

function CbRenderStateDepthOnly()
{
    __CB_GLOBAL_RENDER
    
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(_global.__backfaceCulling? CB_DEPTH_MAP_CULLING_DIRECTION : cull_noculling);
    gpu_set_alphatestenable(true);
    gpu_set_alphatestref(_global.__alphaTestRef);
    gpu_set_colorwriteenable(false, false, false, false);
    gpu_set_blendenable(false);
}