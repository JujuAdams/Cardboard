CbCameraSizeSet(1366, 768);

CbSystemLightModeSet(CB_LIGHT_MODE.DEFERRED);

CbLightAmbientSet(c_gray);
CbLightDirectional(0, 1, 1, -2, c_gray);
CbLightPoint(0, -240,  400, 300, 2200, c_yellow);
CbLightPoint(1,  240,  400, 300, 2200, c_white);
CbLightPoint(2,    0, -400, 300, 2200, c_red);

CbPassFunctionSet(CB_PASS.OPAQUE, function()
{
    //Draw the scene object
    oScene.Draw();
    
    //Draw a lil triangle at the camera's "to" position
    CbSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
});