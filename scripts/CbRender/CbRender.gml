/// Convenience function that executes all Cardboard render passes, including lighting
/// 
/// @param [litOpaqueFunc]
/// @param [litAlphaBlendFunc]
/// @param [unlitOpaqueFunc]
/// @param [unlitAlphaBlendFunc]
/// @param [viewMatrixHint]
/// @param [projectionMatrixHint]

function CbRender(_litOpaqueFunc, _litAlphaBlendFunc, _unlitOpaqueFunc, _unlitAlphaBlendFunc, _viewMatrix = matrix_get(matrix_view), _projectionMatrix = matrix_get(matrix_projection))
{
    CbRenderPrepareLighting();
    
    CbRenderPass(_litOpaqueFunc,     CB_PASS.LIT_OPAQUE,      _viewMatrix, _projectionMatrix);
    CbRenderPass(_litAlphaBlendFunc, CB_PASS.LIT_ALPHA_BLEND, _viewMatrix, _projectionMatrix);
    
    if (CbLightModeGet() == CB_LIGHT_MODE.DEFERRED) CbRenderDeferredLights(_viewMatrix, _projectionMatrix);
    
    CbRenderPass(_unlitOpaqueFunc,     CB_PASS.UNLIT_OPAQUE);
    CbRenderPass(_unlitAlphaBlendFunc, CB_PASS.UNLIT_ALPHA_BLEND);
}