function CbRenderRecallMatrices()
{
    static _system = __CbCameraSystem();
    with(_system)
    {
        __set = false;
        matrix_set(matrix_world,      __worldMatrix);
        matrix_set(matrix_view,       __viewMatrix);
        matrix_set(matrix_projection, __projectionMatrix);
    }
}