// Feather disable all

/// @param lightingMode
/// @param [viewMatrix]
/// @param [projectionMatrix]

function __CbRenderShaderSwitch(_lightingMode, _viewMatrix, _projectionMatrix)
{
    if (_lightingMode == CB_LIGHTING_DISABLED)
    {
        __CbRenderShaderNoLights();
    }
    else if (_lightingMode == CB_LIGHTING_NO_SHADOWED_LIGHTS)
    {
        __CbRenderShaderSimple();
    }
    else if (_lightingMode == CB_LIGHTING_ONE_SHADOWED_LIGHT)
    {
        __CbRenderShaderOneShadowedLight(_viewMatrix, _projectionMatrix);
    }
    else if (_lightingMode == CB_LIGHTING_DEFERRED)
    {
        __CbRenderShaderDeferred(_viewMatrix, _projectionMatrix);
    }
}