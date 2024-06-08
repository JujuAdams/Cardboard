function CbLightDepthMapsNeeded()
{
    var _lightMode = CbLightModeGet();
    return ((_lightMode == CB_LIGHT_MODE.ONE_SHADOWED_LIGHT) || (_lightMode == CB_LIGHT_MODE.DEFERRED));
}