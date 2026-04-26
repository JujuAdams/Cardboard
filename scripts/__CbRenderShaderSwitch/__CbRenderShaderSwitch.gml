// Feather disable all

function __CbRenderShaderSwitch(_lightMode, _viewMatrix, _projectionMatrix)
{
    switch(_lightMode)
    {
        case CB_LIGHTING_DISABLE_LIGHTING:
            __CbRenderShaderNoLights();
        break;
        
        case CB_LIGHTING_NO_SHADOWED_LIGHTS:
            __CbRenderShaderSimple();
        break;
        
        case CB_LIGHTING_ONE_SHADOWED_LIGHT:
            __CbRenderShaderOneShadowedLight(_viewMatrix, _projectionMatrix);
        break;
        
        case CB_LIGHTING_DEFERRED:
            __CbRenderShaderDeferred(_viewMatrix, _projectionMatrix);
        break;
    }
}