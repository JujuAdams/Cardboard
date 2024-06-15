layer_set_visible("Assets_1", false);

CbLightModeSet(CB_LIGHT_MODE.DEFERRED);
CbLightAmbientSet(c_dkgray);

modelA = CbModelBegin();
CbSpriteExt(sprHi, 0,   0,  32, 32, 1, 1, 0,   0, c_white, 1, false);
CbSpriteExt(sprHi, 0,  32,   0, 32, 1, 1, 0,  90, c_white, 1, false);
CbSpriteExt(sprHi, 0,   0, -32, 32, 1, 1, 0, 180, c_white, 1, false);
CbSpriteExt(sprHi, 0, -32,   0, 32, 1, 1, 0, 270, c_white, 1, false);
CbSpriteFloor(sprHi, 0, 0, 0, 64);
CbModelEnd();

modelB = CbModelBegin();
CbModelEnd();

//CbModelCopyWithTransform(modelA, modelB);

var _converter = CbSpriteLayerToModel();
_converter.Add(sprHi, 0, modelA);
_converter.Convert("ConvertTest", modelB);
CbLayerArrayHide("ConvertTest");

CbLightDefaultDepthFunctionSet(function()
{
    CbModelSubmit(oRenderer_1.modelB);
    CbSpriteLayer("Assets_1", 0, 0, 0, 0);
    CbModelSubmit(oTest.model);
});

drawFunc = function()
{
    CbModelSubmit(oRenderer_1.modelB);
    CbSpriteLayer("Assets_1", 0, 0, 0, 0);
    CbModelSubmit(oTest.model);
    CbSpriteBillboard(sprGuy, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
};

dir = CbLightDirectional(1, -2, -3, make_color_rgb(0.2*255, 0.3*255, 0.4*255));
light = CbLightConeWithShadows(c_white, 300, 450, 90, -150, 0, 0, 80, 300);