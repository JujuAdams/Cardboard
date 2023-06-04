function CbLightDepthMapsNeeded()
{
    var _lightMode = CbSystemLightModeGet();
    return ((_lightMode == CB_LIGHT_MODE.ONE_SHADOW_MAP) || (_lightMode == CB_LIGHT_MODE.DEFERRED));
}