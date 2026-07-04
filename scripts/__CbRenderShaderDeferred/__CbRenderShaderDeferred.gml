// Feather disable all

/// @param [viewMatrix]
/// @param [projectionMatrix]

function __CbRenderShaderDeferred(_viewMatrix = undefined, _projMatrix = undefined)
{
    __CB_GLOBAL_RENDER
    
    shader_set(__shdCbDeferredToGBuffer);
    surface_set_target(__CbDeferredSurfaceGBufferEnsure(surface_get_target()), surface_get_target());
    _global.__surfaceWorkaround = true;
    
    if (_viewMatrix != undefined)
    {
        matrix_set(matrix_view, _viewMatrix);
    }
    
    if (_projMatrix != undefined)
    {
        __CbSetProjectionMatrix(_projMatrix);
    }
}