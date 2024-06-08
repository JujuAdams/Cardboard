function CbRenderStoreMatrices()
{
    __CB_GLOBAL_RENDER
    
    with(_global.__old)
    {
        if (not __set)
        {
            __set              = true;
            __worldMatrix      = matrix_get(matrix_world); 
            __viewMatrix       = matrix_get(matrix_view); 
            __projectionMatrix = matrix_get(matrix_projection);
        }
    }
}