// Feather disable all

/// @param [viewMatrix]
/// @param [projectionMatrix]

function __CbRenderShaderDeferred(_viewMatrix = undefined, _projMatrix = undefined)
{
    __CB_GLOBAL_RENDER
    
    var _refSurface = surface_get_target();
    
    shader_set(CB_RENDER_NORMATIVE? __shdCbGBufferHLSL : __shdCbGBufferGLSL);
    if (__CB_SURFACE_SET_TARGET_EXT_WORKAROUND) surface_set_target(__CbDeferredSurfaceNormalEnsure(_refSurface));
    
    _global.__surfaceWorkaround = true;
    surface_set_target_ext(0, _refSurface);
    surface_set_target_ext(1, __CbDeferredSurfaceNormalEnsure(_refSurface));
    
    if (_viewMatrix != undefined)
    {
        matrix_set(matrix_view, _viewMatrix);
    }
    
    if (_projMatrix != undefined)
    {
        __CbSetProjectionMatrix(_projMatrix);
    }
}