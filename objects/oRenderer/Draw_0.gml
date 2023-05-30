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
            CardboardLightShadow(0, c_yellow, 300, 450, 300, -150, 150, 0, 45, 10, 1000);
            CardboardLightShadow(1, c_yellow, 0, 0, 600, 0, -150, 0, 45, 10, 1000);
            
            CardboardLightShadowStart(0);
            oScene.Draw();
            CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
            CardboardLightShadowEnd();
            
            CardboardLightShadowStart(1);
            oScene.Draw();
            CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
            CardboardLightShadowEnd();
        break;
        
        case 1:
            //Start Cardboard's quick start renderer
            //You don't have to use this function but it does make things a lot easier
            CardboardRenderStateSet(1366, 768,
                                    oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                                    oCamera.camToX, oCamera.camToY, oCamera.camToZ,
                                    axonometric);
            
            if (CARDBOARD_WRITE_NORMALS)
            {
                CardboardLightAmbience(c_dkgray);
                //CardboardLightDirectional(0, 1, 1, -2, c_gray);
                //CardboardLightPoint(0, -240,  400, 300, 2200, c_yellow);
                //CardboardLightPoint(1,  240,  400, 300, 2200, c_white);
                //CardboardLightPoint(2,    0, -400, 300, 2200, c_red);
                CardboardLightShaderSet();
            }
            
            //Draw the scene object
            oScene.Draw();
            
            //Draw a lil triangle at the camera's "to" position
            CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
            
            if (CARDBOARD_WRITE_NORMALS)
            {
                shader_reset();
            }
            
            //Reset render state
            CardboardRenderStateReset();
        break;
    }
    
    ++_i;
}

if (keyboard_check(ord("L")))
{
    CardboardLightShadowDrawDebug(0, 0, 0);
}

if (keyboard_check(ord("O")))
{
    shader_set(__shdCardboardDepthTest);
    CardboardLightShadowDrawDebug(1, 0, 0);
    shader_reset();
}