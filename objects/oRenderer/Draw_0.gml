//Track matrices that are being used
var _oldWorld      = matrix_get(matrix_world); 
var _oldView       = matrix_get(matrix_view); 
var _oldProjection = matrix_get(matrix_projection);

//Set up GPU state
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_cullmode(cull_noculling);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(254);

//Set new matrices: the view matrix is a special one that Cardboard creates
CardboardViewMatrixSet(oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                       oCamera.camToX, oCamera.camToY, oCamera.camToZ);
matrix_set(matrix_projection, matrix_build_projection_ortho(room_width, room_height, -3000, 3000));

//Draw the scene object
oScene.Draw();

//Draw a lil triangle at the camera's "to" position
CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
CardboardBatchSubmit();

//Reset GPU state
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_cullmode(cull_noculling);
gpu_set_alphatestenable(false);

//Restore the old matrices we've been using
matrix_set(matrix_world, _oldWorld);
matrix_set(matrix_view, _oldView);
matrix_set(matrix_projection, _oldProjection);