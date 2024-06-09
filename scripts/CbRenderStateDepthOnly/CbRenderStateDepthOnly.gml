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