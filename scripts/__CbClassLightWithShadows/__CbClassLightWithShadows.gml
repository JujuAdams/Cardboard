/// @param color
/// @param xFrom
/// @param yFrom
/// @param zFrom
/// @param xTo
/// @param yTo
/// @param zTo
/// @param FoV
/// @param radius
/// @param near
/// @param far

function __CbClassLightWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _radius, _near, _far) constructor
{
    __CB_GLOBAL_RENDER
    array_push(_global.__lighting.__lightStructArray, weak_ref_create(self));
    static __hasShadows = true;
    
    
    
    color = _color;
    
    xFrom = _xFrom;
    yFrom = _yFrom;
    zFrom = _zFrom;
    
    xTo   = _xTo;
    yTo   = _yTo;
    zTo   = _zTo;
    
    xUp   = 0;
    yUp   = sqrt(2);
    zUp   = sqrt(2);
    
    fov    = _fov;
    radius = _radius;
    near   = _near;
    far    = _far;
    
    visible = true;
    color   = _color;
    
    depthFunction = undefined;
    
    shadowMapBiasMin   = 0.00001;
    shadowMapBiasMax   = 0.0003;
    shadowMapBiasCoeff = 1;
    
    
    
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
        static _u_vShadowMapBias = shader_get_uniform(__shdCbDeferredShadowed, "u_vShadowMapBias");
        static _u_sLightDepth    = shader_get_sampler_index(__shdCbDeferredShadowed, "u_sLightDepth");
        
        __Tick();
        __BuildMatrices();
        
        shader_set_uniform_matrix_array(_u_mLightViewProj, __matrixViewProj);
        shader_set_uniform_f(_u_vLightPos, xFrom, yFrom, zFrom, radius);
        shader_set_uniform_f(_u_vLightColor, color_get_red(  color)/255,
                                             color_get_green(color)/255,
                                             color_get_blue( color)/255);
        shader_set_uniform_f(_u_vShadowMapBias, shadowMapBiasMin, shadowMapBiasMax, shadowMapBiasCoeff);
        texture_set_stage(_u_sLightDepth, surface_get_texture(__depthSurface));
    }
    
    static __SetDeferredUniformsForOneShadowMap = function()
    {
        if (__destroyed) return;
        
        static _u_mLightViewProj = shader_get_uniform(__shdCbOneShadowMap, "u_mLightViewProj");
        static _u_vLightPos      = shader_get_uniform(__shdCbOneShadowMap, "u_vLightPos");
        static _u_vLightColor    = shader_get_uniform(__shdCbOneShadowMap, "u_vLightColor");
        static _u_vShadowMapBias = shader_get_uniform(__shdCbOneShadowMap, "u_vShadowMapBias");
        static _u_sLightDepth    = shader_get_sampler_index(__shdCbOneShadowMap, "u_sLightDepth");
        
        __Tick();
        __BuildMatrices();
        
        shader_set_uniform_matrix_array(_u_mLightViewProj, __matrixViewProj);
        shader_set_uniform_f(_u_vLightPos, xFrom, yFrom, zFrom, radius);
        shader_set_uniform_f(_u_vLightColor, color_get_red(  color)/255,
                                             color_get_green(color)/255,
                                             color_get_blue( color)/255);
        shader_set_uniform_f(_u_vShadowMapBias, shadowMapBiasMin, shadowMapBiasMax, shadowMapBiasCoeff);
        texture_set_stage(_u_sLightDepth, surface_get_texture(__depthSurface));
    }
}