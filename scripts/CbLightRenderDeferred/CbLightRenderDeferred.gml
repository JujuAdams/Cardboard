function CbLightRenderDeferred()
{
    __CB_GLOBAL
    
    var _matrices        = CbPassMatricesGet(CB_PASS.OPAQUE);
    var _vpMatrix        = matrix_multiply(_matrices.view, _matrices.projection);
    var _vpMatrixInverse = __CbMatrixInvert(_vpMatrix);
    
    var _refSurface = surface_get_target();
    
    with(_global)
    {
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
    }
    
    draw_surface(__CbDeferredSurfaceDiffuseEnsure(surface_get_target()), 0, 0);
    
    shader_reset();
}