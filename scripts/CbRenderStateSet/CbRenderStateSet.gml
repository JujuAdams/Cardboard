/// Sets the GPU render state for the given pass
/// This will set matrices, z-testing, and the current shader
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass
/// @param [viewMatrix]
/// @param [projectionMatrix]

function CbRenderStateSet(_pass, _viewMatrix = undefined, _projectionMatrix = undefined)
{
    __CB_GLOBAL_RENDER
    
    with(_global)
    {
        switch(_pass)
        {
            case CB_PASS.DEPTH_MAP:
                gpu_set_ztestenable(true);
                gpu_set_zwriteenable(true);
                gpu_set_cullmode(__backfaceCulling? CB_DEPTH_MAP_CULLING_DIRECTION : cull_noculling);
                gpu_set_colorwriteenable(false, false, false, false);
                gpu_set_blendenable(false);
                
                shader_set(__shdCbAlphaTestOnly);
                shader_set_uniform_f(shader_get_uniform(__shdCbAlphaTestOnly, "u_fAlphaTestRef"), __alphaTestRef);
            break;
            
            case CB_PASS.LIT_OPAQUE:
                gpu_set_ztestenable(true);
                gpu_set_zwriteenable(true);
                gpu_set_cullmode(__backfaceCulling? CB_CULLING_DIRECTION : cull_noculling);
                gpu_set_alphatestenable(true);
                gpu_set_alphatestref(__alphaTestRef);
                gpu_set_blendenable(false);
                
                switch(CbLightModeGet())
                {
                    case CB_LIGHT_MODE.DISABLE_LIGHTING:
                        shader_set(__shdCbNoLights);
                        shader_set_uniform_f(shader_get_uniform(__shdCbNoLights, "u_fAlphaTestRef"), __alphaTestRef);
                        
                        with(__fog)
                        {
                            if (__enabled)
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbNoLights, "u_vFogParams"), __near, __far);
                                shader_set_uniform_f(shader_get_uniform(__shdCbNoLights, "u_vFogColor"), colour_get_red(  __color)/255,
                                                                                                         colour_get_green(__color)/255,
                                                                                                         colour_get_blue( __color)/255);
                            }
                            else
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbNoLights, "u_vFogParams"), 999998, 999999);
                            }
                        }
                    break;
                    
                    case CB_LIGHT_MODE.NO_SHADOWED_LIGHTS:
                        shader_set(__shdCbSimpleLights);
                        shader_set_uniform_f(shader_get_uniform(__shdCbSimpleLights, "u_fAlphaTestRef"), __alphaTestRef);
                        
                        with(__fog)
                        {
                            if (__enabled)
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbSimpleLights, "u_vFogParams"), __near, __far);
                                shader_set_uniform_f(shader_get_uniform(__shdCbSimpleLights, "u_vFogColor"), colour_get_red(  __color)/255,
                                                                                                             colour_get_green(__color)/255,
                                                                                                             colour_get_blue( __color)/255);
                            }
                            else
                            {
                                shader_set_uniform_f(shader_get_uniform(__shdCbSimpleLights, "u_vFogParams"), 999998, 999999);
                            }
                        }
                        
                        with(__lighting)
                        {
                            shader_set_uniform_f(shader_get_uniform(__shdCbSimpleLights, "u_vAmbient"), colour_get_red(  __ambient)/255,
                                                                                                        colour_get_green(__ambient)/255,
                                                                                                        colour_get_blue( __ambient)/255);
                            shader_set_uniform_f_array(shader_get_uniform(__shdCbSimpleLights, "u_vPosRadArray"), __posRadArray);
                            shader_set_uniform_f_array(shader_get_uniform(__shdCbSimpleLights, "u_vColorArray"),  __colorArray);
                        }
                    break;
                    
                    case CB_LIGHT_MODE.ONE_SHADOWED_LIGHT:
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
                            repeat(array_length(__lightStructArray))
                            {
                                with(__lightStructArray[_i].ref)
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
                            else
                            {
                                matrix_set(matrix_view,       _viewMatrix);
                                matrix_set(matrix_projection, _projectionMatrix);
                            }
                        }
                    break;
                    
                    case CB_LIGHT_MODE.DEFERRED:
                        var _refSurface = surface_get_target();
                        
                        if (__CB_RENDER_OPENGL)
                        {
                            shader_set(__shdCbGBufferGLSL);
                            shader_set_uniform_f(shader_get_uniform(__shdCbGBufferGLSL, "u_fAlphaTestRef"), __alphaTestRef);
                        }
                        else
                        {
                            shader_set(__shdCbGBufferHLSL);
                            shader_set_uniform_f(shader_get_uniform(__shdCbGBufferHLSL, "u_fAlphaTestRef"), __alphaTestRef);
                        }
                        
                        __surfaceWorkaround = true;
                        if (__CB_SURFACE_SET_TARGET_EXT_WORKAROUND) surface_set_target(__CbDeferredSurfaceNormalEnsure(_refSurface));
                        
                        surface_set_target_ext(0, _refSurface);
                        surface_set_target_ext(1, __CbDeferredSurfaceNormalEnsure(_refSurface));
                        
                        matrix_set(matrix_view,       _viewMatrix);
                        matrix_set(matrix_projection, _projectionMatrix);
                    break;
                }
            break;
            
            case CB_PASS.UNLIT_OPAQUE:
                gpu_set_ztestenable(true);
                gpu_set_zwriteenable(true);
                gpu_set_cullmode(__backfaceCulling? CB_CULLING_DIRECTION : cull_noculling);
                gpu_set_alphatestenable(true);
                gpu_set_alphatestref(__alphaTestRef);
                gpu_set_blendenable(false);
                
                //TODO
                shader_reset();
            break;
            
            case CB_PASS.LIT_ALPHA_BLEND:
            case CB_PASS.UNLIT_ALPHA_BLEND:
                gpu_set_ztestenable(true);
                gpu_set_zwriteenable(false); //Don't write into the depth buffer!
                gpu_set_cullmode(__backfaceCulling? CB_CULLING_DIRECTION : cull_noculling);
                
                //TODO
                shader_reset();
            break;
        }
    }
}