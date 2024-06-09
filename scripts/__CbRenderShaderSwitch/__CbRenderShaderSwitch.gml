function __CbRenderShaderSwitch(_lightMode, _viewMatrix, _projectionMatrix)
{
    switch(_lightMode)
    {
        case CB_LIGHT_MODE.DISABLE_LIGHTING:
            __CbRenderShaderNoLights();
        break;
        
        case CB_LIGHT_MODE.NO_SHADOWED_LIGHTS:
            __CbRenderShaderSimple();
        break;
        
        case CB_LIGHT_MODE.ONE_SHADOWED_LIGHT:
            __CbRenderShaderOneShadowedLight(_viewMatrix, _projectionMatrix);
        break;
        
        case CB_LIGHT_MODE.DEFERRED:
            __CbRenderShaderDeferred(_viewMatrix, _projectionMatrix);
        break;
    }
}