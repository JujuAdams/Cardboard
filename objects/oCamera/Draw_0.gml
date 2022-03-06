gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_cullmode(cull_noculling);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(254);

var _oldWorld      = matrix_get(matrix_world); 
var _oldView       = matrix_get(matrix_view); 
var _oldProjection = matrix_get(matrix_projection);

CardboardViewMatrixSet(camFromX, camFromY, camFromZ,    camToX, camToY, camToZ);
matrix_set(matrix_projection, matrix_build_projection_ortho(room_width, room_height, -3000, 3000));

CardboardModelSubmit(model);

CardboardSpriteBillboard(sprTest, 0,    320, 0, 32);
CardboardSpriteBillboardExt(sprTest, 0,    160, 0, 80,    2.5, 2.5, 0,    c_white, 1);
CardboardSpriteBillboardExt(sprTest, 0,    0, 160, 80,    2.5, 2.5, 0,    c_white, 1);
CardboardSpriteBillboard(sprCrosshair, 0,    camToX, camToY, camToZ);
CardboardBatchSubmit();

CardboardBatchSubmit();

matrix_set(matrix_world, _oldWorld);
matrix_set(matrix_view, _oldView);
matrix_set(matrix_projection, _oldProjection);
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_cullmode(cull_noculling);
gpu_set_alphatestenable(false);