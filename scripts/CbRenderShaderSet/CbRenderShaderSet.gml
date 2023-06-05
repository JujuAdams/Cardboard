/// Sets the shader (and its uniforms) for the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbRenderShaderSet(_pass)
{
    __CB_GLOBAL
    
    with(_global)
    {
        switch(_pass)
        {
            case CB_PASS.LIGHT_DEPTH:
                shader_set(__shdCbDepth);
                shader_set_uniform_f(shader_get_uniform(__shdCbDepth, "u_fAlphaTestRef"), __alphaTestRef);
            break;
            
            case CB_PASS.OPAQUE:
                switch(CbLightModeGet())
                {
                    case CB_LIGHT_MODE.NONE:
                        shader_set(__shdCbNone);
                        shader_set_uniform_f(shader_get_uniform(__shdCbNone, "u_fAlphaTestRef"), __alphaTestRef);
                        
                        with(__fog)
                        {
                            if (__enabled)
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbNone, "u_vFogParams"), __near, __far);
                                shader_set_uniform_f(shader_get_uniform(__shdCbNone, "u_vFogColor"), colour_get_red(  __color)/255,
                                                                                                     colour_get_green(__color)/255,
                                                                                                     colour_get_blue( __color)/255);
                            }
                            else
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbNone, "u_vFogParams"), 999998, 999999);
                            }
                        }
                    break;
                    
                    case CB_LIGHT_MODE.SIMPLE:
                        shader_set(__shdCbSimple);
                        shader_set_uniform_f(shader_get_uniform(__shdCbSimple, "u_fAlphaTestRef"), __alphaTestRef);
                        
                        with(__fog)
                        {
                            if (__enabled)
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbSimple, "u_vFogParams"), __near, __far);
                                shader_set_uniform_f(shader_get_uniform(__shdCbSimple, "u_vFogColor"), colour_get_red(  __color)/255,
                                                                                                       colour_get_green(__color)/255,
                                                                                                       colour_get_blue( __color)/255);
                            }
                            else
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbSimple, "u_vFogParams"), 999998, 999999);
                            }
                        }
                        
                        with(__lighting)
                        {
                            shader_set_uniform_f(shader_get_uniform(__shdCbSimple, "u_vAmbient"), colour_get_red(  __ambient)/255,
                                                                                                  colour_get_green(__ambient)/255,
                                                                                                  colour_get_blue( __ambient)/255);
                            shader_set_uniform_f_array(shader_get_uniform(__shdCbSimple, "u_vPosRadArray"), __posRadArray);
                            shader_set_uniform_f_array(shader_get_uniform(__shdCbSimple, "u_vColorArray"),  __colorArray);
                        }
                    break;
                    
                    case CB_LIGHT_MODE.ONE_SHADOW_MAP:
                        shader_set(__shdCbOneShadowMap);
                        shader_set_uniform_f(shader_get_uniform(__shdCbOneShadowMap, "u_fAlphaTestRef"), __alphaTestRef);
                        
                        with(__fog)
                        {
                            if (__enabled)
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbOneShadowMap, "u_vFogParams"), __near, __far);
                                shader_set_uniform_f(shader_get_uniform(__shdCbOneShadowMap, "u_vFogColor"), colour_get_red(  __color)/255,
                                                                                                             colour_get_green(__color)/255,
                                                                                                             colour_get_blue( __color)/255);
                            }
                            else
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbOneShadowMap, "u_vFogParams"), 999998, 999999);
                            }
                        }
                        
                        with(__lighting)
                        {
                            shader_set_uniform_f(shader_get_uniform(__shdCbOneShadowMap, "u_vAmbient"), colour_get_red(  __ambient)/255,
                                                                                                        colour_get_green(__ambient)/255,
                                                                                                        colour_get_blue( __ambient)/255);
                            shader_set_uniform_f_array(shader_get_uniform(__shdCbOneShadowMap, "u_vPosRadArray"), __posRadArray);
                            shader_set_uniform_f_array(shader_get_uniform(__shdCbOneShadowMap, "u_vColorArray"),  __colorArray);
                            
                            var _shadowedLightFound = false;
                            var _i = 0;
                            repeat(array_length(__array))
                            {
                                with(__array[_i].ref)
                                {
                                    if (__hasShadows && visible)
                                    {
                                        __SetDeferredUniformsForOneShadowMap();
                                        _shadowedLightFound = true;
                                        break;
                                    }
                                }
                                
                                ++_i;
                            }
                            
                            //Ensure that we reset the shadowed light colour if it disappears for some reason
                            if (not _shadowedLightFound)
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbOneShadowMap, "u_vLightColor"), 0, 0, 0);
                            }
                        }
                    break;
                    
                    case CB_LIGHT_MODE.DEFERRED:
                        var _refSurface = surface_get_target();
                        
                        if (__CB_ON_OPENGL)
                        {
                            shader_set(__shdCbGBufferGLSL);
                            shader_set_uniform_f(shader_get_uniform(__shdCbGBufferGLSL, "u_fAlphaTestRef"), __alphaTestRef);
                        }
                        else
                        {
                            shader_set(__shdCbGBufferHLSL);
                            shader_set_uniform_f(shader_get_uniform(__shdCbGBufferHLSL, "u_fAlphaTestRef"), __alphaTestRef);
                        }
                        
                        __renderStateResetSurface = true;
                        if (__CB_SURFACE_SET_TARGET_EXT_WORKAROUND) surface_set_target(__CbDeferredSurfaceNormalEnsure(_refSurface));
                        
                        surface_set_target_ext(0, _refSurface);
                        surface_set_target_ext(1, __CbDeferredSurfaceDepthEnsure( _refSurface));
                        surface_set_target_ext(2, __CbDeferredSurfaceNormalEnsure(_refSurface));
                    break;
                }
            break;
            
            case CB_PASS.TRANSPARENT:
            case CB_PASS.UNLIT:
                shader_reset();
            break;
        }
    }
}