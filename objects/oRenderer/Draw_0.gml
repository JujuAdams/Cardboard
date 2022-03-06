gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_cullmode(cull_noculling);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(254);

var _oldWorld      = matrix_get(matrix_world); 
var _oldView       = matrix_get(matrix_view); 
var _oldProjection = matrix_get(matrix_projection);

CardboardViewMatrixSet(oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ,
                       oCamera.camToX, oCamera.camToY, oCamera.camToZ);
matrix_set(matrix_projection, matrix_build_projection_ortho(room_width, room_height, -3000, 3000));

oScene.Draw();
CardboardSpriteBillboard(sprTest, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);

matrix_set(matrix_world, _oldWorld);
matrix_set(matrix_view, _oldView);
matrix_set(matrix_projection, _oldProjection);
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_cullmode(cull_noculling);
gpu_set_alphatestenable(false);