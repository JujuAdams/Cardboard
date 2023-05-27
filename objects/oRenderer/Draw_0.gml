//Start Cardboard's quick start renderer
//You don't have to use this function but it does make things a lot easier
CardboardRenderStateSet(1366, 768,
                        oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                        oCamera.camToX, oCamera.camToY, oCamera.camToZ,
                        axonometric);

if (CARDBOARD_WRITE_NORMALS)
{
    CardboardLightingSet(0, 300, 200, 1000, c_yellow);
    CardboardLightingStart();
}

//Draw the scene object

oScene.Draw();
//Draw a lil triangle at the camera's "to" position
CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);

if (CARDBOARD_WRITE_NORMALS) CardboardLightingEnd();


//Reset render state
CardboardRenderStateReset();