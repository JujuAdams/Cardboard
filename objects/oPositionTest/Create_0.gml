z = 0;

drawFunc = function()
{
    matrix_set(matrix_world, matrix_build(x, y, z,   0, 0, image_angle,   1, 1, 1));
    CbModelSubmit(oRenderer_1.modelA);
    matrix_set(matrix_world, matrix_build_identity());
}