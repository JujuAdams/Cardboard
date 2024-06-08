function CbRenderRecallMatrices()
{
    __CB_GLOBAL_RENDER
    
    with(_global.__old)
    {
        __set = false;
        matrix_set(matrix_world,      __worldMatrix);
        matrix_set(matrix_view,       __viewMatrix);
        matrix_set(matrix_projection, __projectionMatrix);
    }
}