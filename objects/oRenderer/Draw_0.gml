CardboardRendererBegin(1366, 768,
                       oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                       oCamera.camToX, oCamera.camToY, oCamera.camToZ,
                       axonometric);

//Draw the scene object
oScene.Draw();

//Draw a lil triangle at the camera's "to" position
CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);

CardboardRendererEnd();