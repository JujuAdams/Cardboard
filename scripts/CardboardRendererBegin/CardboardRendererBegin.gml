/// @param width
/// @param height
/// @param fromX
/// @param fromY
/// @param fromZ
/// @param toX
/// @param toY
/// @param toZ
/// @param [axonometrix=true]

function CardboardRendererBegin(_width, _height, _fromX, _fromY, _fromZ, _toX, _toY, _toZ, _axonometric = undefined)
{
    //Track matrices that are being used
    global.__cardboardOldWorld      = matrix_get(matrix_world); 
    global.__cardboardOldView       = matrix_get(matrix_view); 
    global.__cardboardOldProjection = matrix_get(matrix_projection);
    
    //Set up GPU state
    gpu_set_ztestenable(true);
    gpu_set_zwriteenable(true);
    gpu_set_cullmode(cull_noculling);
    gpu_set_alphatestenable(true);
    gpu_set_alphatestref(254);
    
    CardboardViewMatrixSet(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _axonometric);
    matrix_set(matrix_projection, matrix_build_projection_ortho(_width, _height, -3000, 3000));
}