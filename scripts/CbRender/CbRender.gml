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
    if ((_litOpaqueFunc != undefined) || (_litAlphaBlendFunc != undefined))
    {
        CbRenderPrepareLighting();
        
        if (_litOpaqueFunc != undefined)
        {
            CbRenderStateOpaque(false, true, _viewMatrix, _projectionMatrix);
            _litOpaqueFunc();
            CbBatchForceSubmit();
            CbRenderStateReset();
        }
        
        if (_litAlphaBlendFunc != undefined)
        {
            CbRenderStateAlphaBlend(false, _viewMatrix, _projectionMatrix);
            _litAlphaBlendFunc();
            CbBatchForceSubmit();
            CbRenderStateReset();
        }
        
        if (CbLightModeGet() == CB_LIGHT_MODE.DEFERRED) CbRenderDeferredLights(_viewMatrix, _projectionMatrix);
    }
    
    if (_unlitOpaqueFunc != undefined)
    {
        CbRenderStateOpaque(true);
        _unlitOpaqueFunc();
        CbBatchForceSubmit();
        CbRenderStateReset();
    }
    
    if (_unlitAlphaBlendFunc != undefined)
    {
        CbRenderStateAlphaBlend(true);
        _unlitAlphaBlendFunc();
        CbBatchForceSubmit();
        CbRenderStateReset();
    }
}