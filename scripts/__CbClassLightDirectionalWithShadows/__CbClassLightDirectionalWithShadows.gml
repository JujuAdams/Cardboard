/// @param dX
/// @param dY
/// @param dZ
/// @param color
/// @param near
/// @param far

function __CbClassLightDirectionalWithShadows(_dx, _dy, _dz, _color, _near, _far) constructor
{
    __CB_GLOBAL_RENDER
    array_push(_global.__lighting.__array, weak_ref_create(self));
    static __hasShadows = true;
    
    
    
    visible = true;
    dx      = _dx;
    dy      = _dy;
    dz      = _dz;
    xTo     = 0;
    yTo     = 0;
    zTo     = 0;
    color   = _color;
    
    near = _near;
    far  = _far;
    
    depthFunction = undefined;
    
    
    
    __width  = CB_DEFAULT_DEFERRED_LIGHT_WIDTH;
    __height = CB_DEFAULT_DEFERRED_LIGHT_HEIGHT;
    
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
    
    static DrawDebug = function(_x, _y, _grayscale = false)
    {
        __Tick();
        
        if (_grayscale) shader_set(__shdCbDepthTest);
        draw_surface(__depthSurface, _x, _y);
        if (_grayscale) shader_reset();
    }
    
    static __RenderDepth = function()
    {
        if (__destroyed) return;
        
        __Tick();
        __BuildMatrices();
        
        surface_set_target(__depthSurface);
        draw_clear(c_gray);
        
        var _function = depthFunction ?? _global.__lighting.__defaultDepthFunction;
        if (_function != undefined)
        {
            matrix_set(matrix_view,       __matrixView);
            matrix_set(matrix_projection, __matrixProj);
            _function();
        }
        
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
        __matrixView = matrix_build_lookat(xTo - dx, yTo - dy, zTo - dz,
                                           xTo, yTo, zTo,
                                           0, 0, 1);
        
        __matrixProj = matrix_build_projection_ortho(__width, __height, near, far);
        
        __matrixViewProj = matrix_multiply(__matrixView, __matrixProj);
    }
    
    static __SetDeferredUniforms = function()
    {
        if (__destroyed) return;
        
        static _u_mLightViewProj = shader_get_uniform(__shdCbDeferredShadowed, "u_mLightViewProj");
        static _u_vLightPos      = shader_get_uniform(__shdCbDeferredShadowed, "u_vLightPos");
        static _u_vLightColor    = shader_get_uniform(__shdCbDeferredShadowed, "u_vLightColor");
        static _u_sLightDepth    = shader_get_sampler_index(__shdCbDeferredShadowed, "u_sLightDepth");
        
        __Tick();
        __BuildMatrices();
        
        shader_set_uniform_matrix_array(_u_mLightViewProj, __matrixViewProj);
        shader_set_uniform_f(_u_vLightPos, -dx, -dy, -dz, 0);
        shader_set_uniform_f(_u_vLightColor, color_get_red(  color)/255,
                                             color_get_green(color)/255,
                                             color_get_blue( color)/255);
        texture_set_stage(_u_sLightDepth, surface_get_texture(__depthSurface));
    }
    
    static __SetDeferredUniformsForOneShadowMap = function()
    {
        if (__destroyed) return;
        
        static _u_mLightViewProj = shader_get_uniform(__shdCbOneShadowMap, "u_mLightViewProj");
        static _u_vLightPos      = shader_get_uniform(__shdCbOneShadowMap, "u_vLightPos");
        static _u_vLightColor    = shader_get_uniform(__shdCbOneShadowMap, "u_vLightColor");
        static _u_sLightDepth    = shader_get_sampler_index(__shdCbOneShadowMap, "u_sLightDepth");
        
        __Tick();
        __BuildMatrices();
        
        shader_set_uniform_matrix_array(_u_mLightViewProj, __matrixViewProj);
        shader_set_uniform_f(_u_vLightPos, -dx, -dy, -dz, 0);
        shader_set_uniform_f(_u_vLightColor, color_get_red(  color)/255,
                                             color_get_green(color)/255,
                                             color_get_blue( color)/255);
        texture_set_stage(_u_sLightDepth, surface_get_texture(__depthSurface));
    }
}