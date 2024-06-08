function CbCameraStoreMatrices()
{
    static _system = __CbCameraSystem();
    with(_system)
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