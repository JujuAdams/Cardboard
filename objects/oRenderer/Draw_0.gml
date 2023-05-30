if (not surface_exists(surfaceDepth))
{
    surfaceDepth = surface_create(1366, 768);
}

var _i = 0;
repeat(2)
{
    if (_i == 1)
    {
        surface_set_target(surfaceDepth);
        draw_clear(c_white);
        shader_set(__shdCardboardDepth);
    }
    
    //Start Cardboard's quick start renderer
    //You don't have to use this function but it does make things a lot easier
    CardboardRenderStateSet(1366, 768,
                            oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                            oCamera.camToX, oCamera.camToY, oCamera.camToZ,
                            axonometric);
    
    if (CARDBOARD_WRITE_NORMALS && (_i == 0))
    {
        CardboardLightingAmbienceSet(c_dkgray);
        CardboardLightingPointSet(0, -240,  400, 300, 2200, c_yellow);
        CardboardLightingPointSet(1,  240,  400, 300, 2200, c_white);
        CardboardLightingPointSet(2,    0, -400, 300, 2200, c_red);
        CardboardLightingStart();
    }
    
    //Draw the scene object
    oScene.Draw();
    
    //Draw a lil triangle at the camera's "to" position
    CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
    
    if (CARDBOARD_WRITE_NORMALS && (_i == 0)) CardboardLightingEnd();
    
    //Reset render state
    CardboardRenderStateReset();
    
    if (_i == 1)
    {
        shader_reset();
        surface_reset_target();
    }
    
    ++_i;
}

draw_surface(surfaceDepth, 0, 0);