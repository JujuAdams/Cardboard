layer_set_visible("Assets_1", false);

CbLightModeSet(CB_LIGHT_MODE.DEFERRED);
CbLightAmbientSet(c_dkgray);

CbDoubleSidedSet(false);

modelTilemap = CbModelCreate();
CbModelOpen(modelTilemap);
zGrid = CbTilemapConstruct("Tiles_1");
CbModelClose();
CbLayerArrayHide("Tiles_1");

modelA = CbModelCreate();
CbModelOpen(modelA);
CbSpriteExt(sprHi, 0,   0,  32, 32, 1, 1, 0,   0, c_white, 1, false);
CbSpriteExt(sprHi, 0,  32,   0, 32, 1, 1, 0,  90, c_white, 1, false);
CbSpriteExt(sprHi, 0,   0, -32, 32, 1, 1, 0, 180, c_white, 1, false);
CbSpriteExt(sprHi, 0, -32,   0, 32, 1, 1, 0, 270, c_white, 1, false);
CbSpriteFloor(sprHi, 0, 0, 0, 64);
CbModelClose();

modelB = CbModelCreate();

//CbModelCopyWithTransform(modelA, modelB);

var _converter = CbSpriteLayerToModel();
_converter.SetZGrid(zGrid, 32, 32, 32);
_converter.Add(sprHi, 0, modelA);
_converter.Convert("ConvertTest", modelB);
CbLayerArrayHide("ConvertTest");

CbLightDefaultDepthFunctionSet(function()
{
    CbModelSubmit(modelB);
    CbSpriteLayer("Assets_1", 0, 0, 0, 0);
    CbModelSubmit(modelTilemap);
});

drawFunc = function()
{
    CbModelSubmit(modelB);
    CbSpriteLayer("Assets_1", 0, 0, 0, 0);
    CbModelSubmit(modelTilemap);
    CbSpriteBillboard(sprGuy, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
};

dir = CbLightDirectional(-1, 2, 3, make_color_rgb(0.2*255, 0.3*255, 0.4*255));
light = CbLightConeWithShadows(c_white, 300, 450, 90, -150, 0, 0, 80, 300);