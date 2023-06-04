CbCameraSizeSet(1366, 768);

CbSystemLightModeSet(CB_LIGHT_MODE.DEFERRED);
CbLightAmbientSet(c_dkgray);
dir    = CbLightDirectional(1, -2, -3, make_color_rgb(0.2*255, 0.3*255, 0.4*255));
light1 = CbLightPoint(0, 0, 50, 200, c_red);
light2 = CbLightWithShadows(c_black, 300, 450, 90, -150, 90, 0, 140, 1, 300);

CbPassFunctionSet([CB_PASS.LIGHT_DEPTH, CB_PASS.OPAQUE], function()
{
    //Draw the scene object
    oScene.Draw();
});

CbPassFunctionSet(CB_PASS.UNLIT, function()
{
    CbSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
});