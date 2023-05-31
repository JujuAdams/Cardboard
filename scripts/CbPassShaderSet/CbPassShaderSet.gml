/// Sets the shader (and its uniforms) for the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbPassShaderSet(_pass)
{
    __CB_GLOBAL
    
    switch(_pass)
    {
        case CB_PASS.LIGHT_DEPTH:
            shader_reset();
        break;
        
        case CB_PASS.OPAQUE:
            switch(CbSystemLightModeGet())
            {
                case CB_LIGHT_MODE.NONE:
                    shader_set(__shdCbOpaqueNone);
                    shader_set_uniform_f(shader_get_uniform(__shdCbOpaqueNone, "u_fAlphaTestRef"), _global.__alphaTestRef);
                break;
                
                case CB_LIGHT_MODE.SIMPLE:
                    shader_set(__shdCbOpaqueSimple);
                    shader_set_uniform_f(shader_get_uniform(__shdCbOpaqueSimple, "u_fAlphaTestRef"), _global.__alphaTestRef);
                    
                    with(_global.__lighting)
                    {
                        shader_set_uniform_f(shader_get_uniform(__shdCbOpaqueSimple, "u_vAmbient"), colour_get_red(  __ambient)/255,
                                                                                                    colour_get_green(__ambient)/255,
                                                                                                    colour_get_blue( __ambient)/255);
                        shader_set_uniform_f_array(shader_get_uniform(__shdCbOpaqueSimple, "u_vPosRadArray"), __posRadArray);
                        shader_set_uniform_f_array(shader_get_uniform(__shdCbOpaqueSimple, "u_vColorArray"),  __colorArray);
                    }
                break;
                
                case CB_LIGHT_MODE.ONE_SHADOW_MAP:
                    shader_reset();
                break;
                
                case CB_LIGHT_MODE.DEFERRED:
                    shader_reset();
                break;
            }
        break;
        
        case CB_PASS.TRANSPARENT:
            shader_reset();
        break;
        
        case CB_PASS.DEFERRED_LIGHT:
            shader_reset();
        break;
    }
}