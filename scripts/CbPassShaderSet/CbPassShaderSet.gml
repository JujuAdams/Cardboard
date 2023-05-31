/// Sets the shader (and its uniforms) for the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbPassShaderSet(_pass)
{
    __CB_GLOBAL
    
    with(_global)
    {
        switch(_pass)
        {
            case CB_PASS.LIGHT_DEPTH:
                shader_set(__shdCbDepth);
                shader_set_uniform_f(shader_get_uniform(__shdCbDepth, "u_fAlphaTestRef"), __alphaTestRef);
                shader_set_uniform_f(shader_get_uniform(__shdCbDepth, "u_vZ"), __camera.__near, __camera.__far);
            break;
            
            case CB_PASS.OPAQUE:
                switch(CbSystemLightModeGet())
                {
                    case CB_LIGHT_MODE.NONE:
                        shader_set(__shdCbNone);
                        shader_set_uniform_f(shader_get_uniform(__shdCbNone, "u_fAlphaTestRef"), __alphaTestRef);
                    break;
                    
                    case CB_LIGHT_MODE.SIMPLE:
                        shader_set(__shdCbSimple);
                        shader_set_uniform_f(shader_get_uniform(__shdCbSimple, "u_fAlphaTestRef"), __alphaTestRef);
                        
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
                        __CbError("Not currently supported");
                    break;
                    
                    case CB_LIGHT_MODE.DEFERRED:
                        var _refSurface = surface_get_target();
                        
                        if (__CB_ON_OPENGL)
                        {
                            shader_set(__shdCbGBufferGLSL);
                            shader_set_uniform_f(shader_get_uniform(__shdCbGBufferGLSL, "u_fAlphaTestRef"), __alphaTestRef);
                            shader_set_uniform_f(shader_get_uniform(__shdCbGBufferGLSL, "u_vZ"), __camera.__near, __camera.__far);
                        }
                        else
                        {
                            shader_set(__shdCbGBufferHLSL);
                            shader_set_uniform_f(shader_get_uniform(__shdCbGBufferHLSL, "u_fAlphaTestRef"), __alphaTestRef);
                            shader_set_uniform_f(shader_get_uniform(__shdCbGBufferHLSL, "u_vZ"), __camera.__near, __camera.__far);
                        }
                        
                        __oldRenderStateResetSurface = true;
                        surface_set_target_ext(0, __CbDeferredSurfaceDiffuseEnsure(_refSurface));
                        surface_set_target_ext(1, __CbDeferredSurfaceDepthEnsure(  _refSurface));
                        surface_set_target_ext(2, __CbDeferredSurfaceNormalEnsure( _refSurface));
                    break;
                }
            break;
            
            case CB_PASS.TRANSPARENT:
                shader_reset();
            break;
            
            case CB_PASS.DEFERRED_LIGHT:
                var _matrices        = CbPassMatricesGet(CB_PASS.OPAQUE);
                var _vpMatrix        = matrix_multiply(_matrices.view, _matrices.projection);
                var _vpMatrixInverse = __CbMatrixInvert(_vpMatrix);
                
                var _refSurface = surface_get_target();
                
                shader_set(__shdCbDeferredUnshadowed);
                shader_set_uniform_f(shader_get_uniform(__shdCbDeferredUnshadowed, "u_vZ"), __camera.__near, __camera.__far);
                shader_set_uniform_matrix_array(shader_get_uniform(__shdCbDeferredUnshadowed, "u_mCameraInverse"), _vpMatrixInverse);
                texture_set_stage(shader_get_sampler_index(__shdCbDeferredUnshadowed, "u_sDepth" ), surface_get_texture(__CbDeferredSurfaceDepthEnsure( _refSurface)));
                texture_set_stage(shader_get_sampler_index(__shdCbDeferredUnshadowed, "u_sNormal"), surface_get_texture(__CbDeferredSurfaceNormalEnsure(_refSurface)));
                
                with(__lighting)
                {
                    shader_set_uniform_f(shader_get_uniform(__shdCbSimple, "u_vAmbient"), colour_get_red(  __ambient)/255,
                                                                                          colour_get_green(__ambient)/255,
                                                                                          colour_get_blue( __ambient)/255);
                    shader_set_uniform_f_array(shader_get_uniform(__shdCbSimple, "u_vPosRadArray"), __posRadArray);
                    shader_set_uniform_f_array(shader_get_uniform(__shdCbSimple, "u_vColorArray"),  __colorArray);
                }
            break;
        }
    }
}