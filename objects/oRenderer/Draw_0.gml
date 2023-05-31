if (not surface_exists(surfaceDepth))
{
    surfaceDepth = surface_create(1366, 768);
}

var _i = 0;
repeat(2)
{
    switch(_i)
    {
        case 0:
            CbDeferredLight(0, c_yellow, 300, 450, 300, -150, 150, 0, 45, 10, 1000);
            CbDeferredLight(1, c_yellow, 0, 0, 600, 0, -250, 0, 50, 10, 1000);
            
            CbDeferredLightStart(0);
            oScene.Draw();
            CbSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
            CbDeferredLightEnd();
            
            CbDeferredLightStart(1);
            oScene.Draw();
            CbSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
            CbDeferredLightEnd();
        break;
        
        case 1:
            //Start Cb's quick start renderer
            //You don't have to use this function but it does make things a lot easier
            CbRenderStateSet(1366, 768,
                                    oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                                    oCamera.camToX, oCamera.camToY, oCamera.camToZ,
                                    axonometric);
            
            if (CB_WRITE_NORMALS)
            {
                CbLightAmbience(c_dkgray);
                //CbLightDirectional(0, 1, 1, -2, c_gray);
                //CbLightPoint(0, -240,  400, 300, 2200, c_yellow);
                //CbLightPoint(1,  240,  400, 300, 2200, c_white);
                //CbLightPoint(2,    0, -400, 300, 2200, c_red);
                CbLightShaderSet();
            }
            
            //Draw the scene object
            oScene.Draw();
            
            //Draw a lil triangle at the camera's "to" position
            CbSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
            
            if (CB_WRITE_NORMALS)
            {
                shader_reset();
            }
            
            //Reset render state
            CbRenderStateReset();
        break;
    }
    
    ++_i;
}

if (keyboard_check(ord("L")))
{
    CbDeferredLightDrawDebug(0, 0, 0);
}

if (keyboard_check(ord("O")))
{
    shader_set(__shdCbDepthTest);
    CbDeferredLightDrawDebug(1, 0, 0);
    shader_reset();
}