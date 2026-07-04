// Feather disable all

/// Renders lighting contributions from deferred lights.
/// 
/// @param viewMatrix
/// @param projectionMatrix

function CbRenderDrawDeferredLights(_viewMatrix, _projectionMatrix)
{
    __CB_GLOBAL_RENDER
    
    if (CbGetLightingMode() != CB_LIGHTING_DEFERRED) return;
    
    var _vpMatrix        = matrix_multiply(_viewMatrix, _projectionMatrix);
    var _vpMatrixInverse = matrix_inverse(_vpMatrix);
    
    var _destinationSurface = surface_get_target();
    var _depthTexture       = surface_get_texture_depth(_destinationSurface);
    var _gBufferSurface     = __CbDeferredSurfaceGBufferEnsure(_destinationSurface);
    var _lightingSurface    = __CbDeferredSurfaceLightEnsure(_destinationSurface);
    
    with(_global)
    {
        //Target the composite lighting surface
        //This surface is prepared in CbRenderPreDrawLighting()
        surface_set_target(_lightingSurface);
        gpu_set_blendmode(bm_add);
        
        //Draw unshadowed lights first
        shader_set(__shdCbDeferredUnshadowed);
        __CbSetProjectionMatrixUniform(shader_get_uniform(__shdCbDeferredUnshadowed, "u_mCameraInverse"), _vpMatrixInverse);
        texture_set_stage(shader_get_sampler_index(__shdCbDeferredUnshadowed, "u_sDepth" ), _depthTexture);
        
        with(__lighting)
        {
            //These two arrays are prepared in CbRenderPreDrawLighting()
            shader_set_uniform_f_array(shader_get_uniform(__shdCbDeferredUnshadowed, "u_vPosRadArray"), __posRadArray);
            shader_set_uniform_f_array(shader_get_uniform(__shdCbDeferredUnshadowed, "u_vColorArray"),  __colorArray);
            draw_surface(_gBufferSurface, 0, 0);
        }
        
        shader_reset();
        
        //Then draw shadowed lights
        shader_set(__shdCbDeferredShadowed);
        __CbSetProjectionMatrixUniform(shader_get_uniform(__shdCbDeferredShadowed, "u_mCameraInverse"), _vpMatrixInverse);
        texture_set_stage(shader_get_sampler_index(__shdCbDeferredShadowed, "u_sDepth"), _depthTexture);
        
        with(__lighting)
        {
            var _i = 0;
            repeat(array_length(__lightStructArray))
            {
                with(__lightStructArray[_i].ref)
                {
                    if (__hasShadows && visible)
                    {
                        __SetDeferredUniforms();
                        draw_surface(_gBufferSurface, 0, 0);
                    }
                }
                
                ++_i;
            }
        }
        
        shader_reset();
        gpu_set_blendmode(bm_normal);
        surface_reset_target();
    }
    
    //Once we're done with compositing, transfer the resulting lighting onto the target surface
    gpu_set_blendmode_ext(bm_one, bm_zero);
    shader_set(__shdCbDeferredTransferLighting);
    texture_set_stage(shader_get_sampler_index(__shdCbDeferredTransferLighting, "u_sLighting"), surface_get_texture(_lightingSurface));
    draw_surface(_gBufferSurface, 0, 0);
    shader_reset();
    gpu_set_blendmode(bm_normal);
}