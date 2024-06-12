CbLightModeSet(CB_LIGHT_MODE.DEFERRED);
CbLightAmbientSet(c_dkgray);

CbLightDefaultDepthFunctionSet(function()
{
    CbModelSubmit(oTest.model);
});

drawFunc = function()
{
    CbModelSubmit(oTest.model);
    CbSpriteBillboard(sprGuy, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
};

light = CbLightConeWithShadows(c_white, 300, 450, 90, -150, 0, 0, 80, 300);