// Feather disable all

/// Convenience function that executes all Cardboard render passes, including lighting.
/// 
/// @param [litOpaqueFunc]
/// @param [litAlphaBlendFunc]
/// @param [unlitOpaqueFunc]
/// @param [unlitAlphaBlendFunc]
/// @param [viewMatrix]
/// @param [projectionMatrix]

function CbRenderConvenience(_litOpaqueFunc, _litAlphaBlendFunc, _unlitOpaqueFunc, _unlitAlphaBlendFunc, _viewMatrix = undefined, _projMatrix = undefined)
{
    static _staticViewMatrix = matrix_build_identity();
    static _staticProjMatrix = matrix_build_identity();
    
    if (_viewMatrix == undefined)
    {
        matrix_get(matrix_view, _staticViewMatrix);
        _viewMatrix = _staticViewMatrix;
    }
    
    if (_projMatrix == undefined)
    {
        __CbGetProjectionMatrix(_staticProjMatrix);
        _projMatrix = _staticProjMatrix;
    }
    
    if ((_litOpaqueFunc != undefined) || (_litAlphaBlendFunc != undefined))
    {
        CbRenderPreDrawLighting();
        
        if (_litOpaqueFunc != undefined)
        {
            matrix_set(matrix_view, _viewMatrix);
            __CbSetProjectionMatrix(_projMatrix);
            
            CbRenderStateOpaque(false, true, _viewMatrix, _projMatrix);
            _litOpaqueFunc();
            CbBatchForceSubmit();
            CbRenderStateReset();
        }
        
        if (_litAlphaBlendFunc != undefined)
        {
            matrix_set(matrix_view, _viewMatrix);
            __CbSetProjectionMatrix(_projMatrix);
            
            CbRenderStateAlphaBlend(false, _viewMatrix, _projMatrix);
            _litAlphaBlendFunc();
            CbBatchForceSubmit();
            CbRenderStateReset();
        }
        
        CbRenderDrawDeferredLights(_viewMatrix, _projMatrix);
    }
    
    if (_unlitOpaqueFunc != undefined)
    {
        matrix_set(matrix_view, _viewMatrix);
        __CbSetProjectionMatrix(_projMatrix);
        
        CbRenderStateOpaque(true);
        _unlitOpaqueFunc();
        CbBatchForceSubmit();
        CbRenderStateReset();
    }
    
    if (_unlitAlphaBlendFunc != undefined)
    {
        matrix_set(matrix_view, _viewMatrix);
        __CbSetProjectionMatrix(_projMatrix);
        
        CbRenderStateAlphaBlend(true);
        _unlitAlphaBlendFunc();
        CbBatchForceSubmit();
        CbRenderStateReset();
    }
}