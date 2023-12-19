/// Sets the GPU render state for the given pass
/// This will set matrices, z-testing, and the current shader
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbRenderStateSet(_pass)
{
    __CB_GLOBAL_RENDER
    
    switch(_pass)
    {
        case CB_PASS.DEPTH_MAP:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(true);
            gpu_set_cullmode(_global.__backfaceCulling? CB_DEPTH_MAP_CULLING_DIRECTION : cull_noculling);
            //View and projection matrix is set per light
            CbRenderShaderSet(_pass);
        break;
        
        case CB_PASS.LIT_OPAQUE:
        case CB_PASS.UNLIT_OPAQUE:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(true);
            gpu_set_cullmode(_global.__backfaceCulling? CB_CULLING_DIRECTION : cull_noculling);
            gpu_set_alphatestenable(true);
            gpu_set_alphatestref(_global.__alphaTestRef);
            
            CbRenderShaderSet(_pass);
            CbCameraMatricesSet();
        break;
        
        case CB_PASS.LIT_ALPHA_BLEND:
        case CB_PASS.UNLIT_ALPHA_BLEND:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(false); //Don't write into the depth buffer!
            gpu_set_cullmode(_global.__backfaceCulling? CB_CULLING_DIRECTION : cull_noculling);
            
            CbRenderShaderSet(_pass);
            CbCameraMatricesSet();
        break;
    }
}