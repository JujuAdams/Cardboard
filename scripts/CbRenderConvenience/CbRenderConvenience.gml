/// Convenience function that executes all Cardboard render passes, including lighting
/// 
/// @param [litOpaqueFunc]
/// @param [litAlphaBlendFunc]
/// @param [unlitOpaqueFunc]
/// @param [unlitAlphaBlendFunc]
/// @param [viewMatrixHint]
/// @param [projectionMatrixHint]

function CbRenderConvenience(_litOpaqueFunc, _litAlphaBlendFunc, _unlitOpaqueFunc, _unlitAlphaBlendFunc, _viewMatrix = matrix_get(matrix_view), _projectionMatrix = matrix_get(matrix_projection))
{
    if ((_litOpaqueFunc != undefined) || (_litAlphaBlendFunc != undefined))
    {
        CbRenderPreDrawLighting();
        
        if (_litOpaqueFunc != undefined)
        {
            matrix_set(matrix_view, _viewMatrix);
            matrix_set(matrix_projection, _projectionMatrix);
            
            CbRenderStateOpaque(false, true, _viewMatrix, _projectionMatrix);
            _litOpaqueFunc();
            CbBatchForceSubmit();
            CbRenderStateReset();
        }
        
        if (_litAlphaBlendFunc != undefined)
        {
            matrix_set(matrix_view, _viewMatrix);
            matrix_set(matrix_projection, _projectionMatrix);
            
            CbRenderStateAlphaBlend(false, _viewMatrix, _projectionMatrix);
            _litAlphaBlendFunc();
            CbBatchForceSubmit();
            CbRenderStateReset();
        }
        
        CbRenderDrawDeferredLights(_viewMatrix, _projectionMatrix);
    }
    
    if (_unlitOpaqueFunc != undefined)
    {
        matrix_set(matrix_view, _viewMatrix);
        matrix_set(matrix_projection, _projectionMatrix);
        
        CbRenderStateOpaque(true);
        _unlitOpaqueFunc();
        CbBatchForceSubmit();
        CbRenderStateReset();
    }
    
    if (_unlitAlphaBlendFunc != undefined)
    {
        matrix_set(matrix_view, _viewMatrix);
        matrix_set(matrix_projection, _projectionMatrix);
        
        CbRenderStateAlphaBlend(true);
        _unlitAlphaBlendFunc();
        CbBatchForceSubmit();
        CbRenderStateReset();
    }
}