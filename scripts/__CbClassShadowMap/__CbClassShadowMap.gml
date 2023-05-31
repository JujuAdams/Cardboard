function __CbClassShadowMap() constructor
{
    __state   = false;
    __surface = -1;
    
    __width   = 1366;
    __height  = 768;
    
    __color   = c_white;
    
    __xFrom   = 0;
    __yFrom   = 1;
    __zFrom   = 0;
    
    __xTo     = 0;
    __yTo     = 0;
    __zTo     = 0;
    
    __near    = 0;
    __far     = 0;
    __fov     = 90;
    
    __xUp     = 0;
    __yUp     = 0;
    __zUp     = 1;
    
    __BuildMatrix();
    __oldViewMatrix = matrix_get(matrix_view);
    __oldProjMatrix = matrix_get(matrix_projection);
    
    
    
    static __Tick = function()
    {
        if (__state)
        {
            if (not surface_exists(__surface))
            {
                __surface = surface_create(__width, __height);
            }
        }
        else
        {
            if (surface_exists(__surface))
            {
                surface_free(__surface);
                __surface = -1;
            }
        }
    }
    
    static __BuildMatrix = function()
    {
        __matrixView = matrix_build_lookat(__xFrom, __yFrom,__zFrom,
                                           __xTo,   __yTo,  __zTo,
                                           __xUp,   __yUp,  __zUp);
        
        __matrixProj = matrix_build_projection_perspective_fov(__fov, __width/__height, __near, __far);
        
        __matrixViewProj = matrix_multiply(__matrixView, __matrixProj);
    }
}