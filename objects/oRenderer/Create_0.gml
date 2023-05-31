CbCameraSizeSet(1366, 768);

CbSystemLightModeSet(CB_LIGHT_MODE.SIMPLE);

CbLightAmbientSet(c_dkgray);
CbLightDirectional(0, 1, -2, -3, make_color_rgb(0.2*255, 0.3*255, 0.4*255));
CbLightPoint(1, -320,    0, 160,  320, c_red);
CbLightPoint(2,  200,  200, 160,  400, c_white);
CbLightPoint(3,    0, -640, 320, 1000, c_fuchsia);

CbPassFunctionSet(CB_PASS.OPAQUE, function()
{
    //Draw the scene object
    oScene.Draw();
    
    //Draw a lil triangle at the camera's "to" position
    CbSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
});