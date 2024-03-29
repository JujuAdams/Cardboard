//Start Cardboard's quick start renderer
//You don't have to use this function but it does make things a lot easier
CardboardRenderStateSet(1366, 768,
                        oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                        oCamera.camToX, oCamera.camToY, oCamera.camToZ,
                        axonometric);

//Draw the scene object
oScene.Draw();

//Draw a lil triangle at the camera's "to" position
CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);

//Reset render state
CardboardRenderStateReset();