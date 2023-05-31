/// @param color
/// @param xFrom
/// @param yFrom
/// @param zFrom
/// @param xTo
/// @param yTo
/// @param zTo
/// @param FoV
/// @param near
/// @param far
/// @param [xUp=0]
/// @param [yUp=0]
/// @param [zUp=1]

function __CbClassLightWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _near, _far, _xUp = 0, _yUp = 0, _zUp = 1) constructor
{
    __CB_GLOBAL
    array_push(_global.__lighting.__array, weak_ref_create(self));
    static __hasShadows = true;
    
    
    
    color = _color;
    
    xFrom = _xFrom;
    yFrom = _yFrom;
    zFrom = _zFrom;
    
    xTo   = _xTo;
    yTo   = _yTo;
    zTo   = _zTo;
    
    fov   = _fov;
    near  = _near;
    far   = _far;
    
    xUp   = _xUp;
    yUp   = _yUp;
    zUp   = _zUp;
    
    visible = true;
    color   = _color;
    
    __width  = 1366;
    __height =  768;
    
    __depthSurface = -1;
    
    __destroyed = false;
    
    __BuildMatrices();
    
    
    
    static Destroy = function()
    {
        __destroyed = true;
        
        if (surface_exists(__depthSurface))
        {
            surface_free(__depthSurface);
            __depthSurface = -1;
        }
    }
    
    static __RenderDepth = function(_function)
    {
        if (__destroyed) return;
        
        __Tick();
        __BuildMatrices();
        
        shader_set_uniform_f(shader_get_uniform(__shdCbDepth, "u_vZ"), near, far);
        
        surface_set_target(__depthSurface);
        draw_clear(c_gray);
        matrix_set(matrix_view,       __matrixView);
        matrix_set(matrix_projection, __matrixProj);
        _function();
        surface_reset_target();
    }
    
    static __Tick = function()
    {
        if (__destroyed) return;
        
        if (not surface_exists(__depthSurface))
        {
            __depthSurface = surface_create(__width, __height);
        }
    }
    
    static __AddToGlobalArrays = function(_posRadArray, _posRadIndex, _colorArray, _colorIndex)
    {
        //Do nothing!
    }
    
    static __BuildMatrices = function()
    {
        __matrixView = matrix_build_lookat(xFrom, yFrom, zFrom,
                                           xTo,   yTo,   zTo,
                                           xUp,   yUp,   zUp);
        
        __matrixProj = matrix_build_projection_perspective_fov(fov, __width/__height, near, far);
        
        __matrixViewProj = matrix_multiply(__matrixView, __matrixProj);
    }
    
    static __SetDeferredUniforms = function()
    {
        if (__destroyed) return;
        
        static _u_mLightViewProj = shader_get_uniform(__shdCbDeferredShadowed, "u_mLightViewProj");
        static _u_vLightPos      = shader_get_uniform(__shdCbDeferredShadowed, "u_vLightPos");
        static _u_vLightColor    = shader_get_uniform(__shdCbDeferredShadowed, "u_vLightColor");
        static _u_vLightZ        = shader_get_uniform(__shdCbDeferredShadowed, "u_vLightZ");
        static _u_sLightDepth    = shader_get_sampler_index(__shdCbDeferredShadowed, "u_sLightDepth");
        
        __Tick();
        __BuildMatrices();
        
        shader_set_uniform_matrix_array(_u_mLightViewProj, __matrixViewProj);
        shader_set_uniform_f(_u_vLightPos, xFrom, yFrom, zFrom, far);
        shader_set_uniform_f(_u_vLightColor, color_get_red(  color)/255,
                                             color_get_green(color)/255,
                                             color_get_blue( color)/255);
        shader_set_uniform_f(_u_vLightZ, near, far);
        texture_set_stage(_u_sLightDepth, surface_get_texture(__depthSurface));
    }
}