/// Sets the GPU render state for the given pass
/// This will set matrices, z-testing, and the current shader
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbPassRenderStateSet(_pass)
{
    __CB_GLOBAL
    
    //Track matrices that are being used
    _global.__oldRenderStateMatrixWorld      = matrix_get(matrix_world); 
    _global.__oldRenderStateMatrixView       = matrix_get(matrix_view); 
    _global.__oldRenderStateMatrixProjection = matrix_get(matrix_projection);
    
    switch(_pass)
    {
        case CB_PASS.LIGHT_DEPTH:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(true);
            gpu_set_cullmode(CB_BACKFACE_CULLING? cull_counterclockwise : cull_noculling);
            gpu_set_alphatestenable(true);
            gpu_set_alphatestref(_global.__alphaTestRef);
            
            CbPassShaderSet(_pass);
            
            //View and projection matrix is set per light
        break;
        
        case CB_PASS.OPAQUE:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(true);
            gpu_set_cullmode(CB_BACKFACE_CULLING? cull_clockwise : cull_noculling);
            gpu_set_alphatestenable(true);
            gpu_set_alphatestref(_global.__alphaTestRef);
            
            CbPassShaderSet(_pass);
            CbPassMatricesSet(_pass);
        break;
        
        case CB_PASS.TRANSPARENT:
            gpu_set_ztestenable(true);
            gpu_set_zwriteenable(false); //Don't write into the alpha channel!
            gpu_set_cullmode(CB_BACKFACE_CULLING? cull_clockwise : cull_noculling);
            gpu_set_alphatestenable(false);
            
            CbPassShaderSet(_pass);
            CbPassMatricesSet(_pass);
        break;
    }
}