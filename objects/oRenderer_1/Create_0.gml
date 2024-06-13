layer_set_visible("Assets_1", false);

CbLightModeSet(CB_LIGHT_MODE.ONE_SHADOWED_LIGHT);
CbLightAmbientSet(c_dkgray);

CbLightDefaultDepthFunctionSet(function()
{
    CbSpriteLayer("Assets_1", 0, 0, 0, 0);
    CbModelSubmit(oTest.model);
});

drawFunc = function()
{
    CbSpriteLayer("Assets_1", 0, 0, 0, 0);
    CbModelSubmit(oTest.model);
    CbSpriteBillboard(sprGuy, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
};

dir = CbLightDirectional(1, -2, -3, make_color_rgb(0.2*255, 0.3*255, 0.4*255));
light = CbLightConeWithShadows(c_white, 300, 450, 90, -150, 0, 0, 80, 300);