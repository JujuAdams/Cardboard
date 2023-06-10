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
        case CB_PASS.LIGHT_DEPTH:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(true);
            gpu_set_cullmode(_global.__backfaceCulling? CB_BACKFACE_CULLING_DIRECTION : cull_noculling);
            gpu_set_blendmode_ext(bm_one, bm_zero);
            
            CbRenderShaderSet(_pass);
            CbIndexReset();
            
            //View and projection matrix is set per light
        break;
        
        case CB_PASS.OPAQUE:
        case CB_PASS.UNLIT:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(true);
            gpu_set_cullmode(_global.__backfaceCulling? CB_BACKFACE_CULLING_DIRECTION : cull_noculling);
            gpu_set_alphatestenable(true);
            gpu_set_alphatestref(_global.__alphaTestRef);
            
            CbRenderShaderSet(_pass);
            CbCameraMatricesSet();
            CbIndexReset();
        break;
        
        case CB_PASS.TRANSPARENT:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(false); //Don't write into the depth buffer!
            gpu_set_cullmode(_global.__backfaceCulling? CB_BACKFACE_CULLING_DIRECTION : cull_noculling);
            
            CbRenderShaderSet(_pass);
            CbCameraMatricesSet();
            CbIndexReset();
        break;
    }
}