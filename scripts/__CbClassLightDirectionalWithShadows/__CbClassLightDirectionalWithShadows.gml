/// @param dX
/// @param dY
/// @param dZ
/// @param color
/// @param nearOffset
/// @param farOffset

function __CbClassLightDirectionalWithShadows(_dx, _dy, _dz, _color, _nearOffset, _farOffset) constructor
{
    __CB_GLOBAL_RENDER
    array_push(_global.__lighting.__array, weak_ref_create(self));
    static __hasShadows = true;
    
    
    
    visible = true;
    dx      = _dx;
    dy      = _dy;
    dz      = _dz;
    color   = _color;
    
    nearOffset = _nearOffset;
    farOffset  = _farOffset;
    
    depthFunction = undefined;
    
    shadowMapBiasMin   = 0.00001;
    shadowMapBiasMax   = 0.002;
    shadowMapBiasCoeff = 1;
    
    
    
    __width  = CB_DEFAULT_DIRECTIONAL_LIGHT_WIDTH;
    __height = CB_DEFAULT_DIRECTIONAL_LIGHT_HEIGHT;
    
    __depthSurface = -1;
    
    __destroyed = false;
    
    __BuildMatrices();
    
    
    
    static TrackCamera = function()
    {
        var _matrixView = matrix_build_lookat(-dx, -dy, -dz,   0,0,0,   0,0,-1);
        var _frustrumArray = array_create(8, undefined);
        with(CbCameraFrustrumCoordsGet())
        {
            _frustrumArray[0] = matrix_transform_vertex(_matrixView, tlNear[0], tlNear[1], tlNear[2]);
            _frustrumArray[1] = matrix_transform_vertex(_matrixView, trNear[0], trNear[1], trNear[2]);
            _frustrumArray[2] = matrix_transform_vertex(_matrixView, blNear[0], blNear[1], blNear[2]);
            _frustrumArray[3] = matrix_transform_vertex(_matrixView, brNear[0], brNear[1], brNear[2]);
            _frustrumArray[4] = matrix_transform_vertex(_matrixView,  tlFar[0],  tlFar[1],  tlFar[2]);
            _frustrumArray[5] = matrix_transform_vertex(_matrixView,  trFar[0],  trFar[1],  trFar[2]);
            _frustrumArray[6] = matrix_transform_vertex(_matrixView,  blFar[0],  blFar[1],  blFar[2]);
            _frustrumArray[7] = matrix_transform_vertex(_matrixView,  brFar[0],  brFar[1],  brFar[2]);
        }
        
        var _left   =  infinity;
        var _top    =  infinity;
        var _near   =  infinity;
        var _right  = -infinity;
        var _bottom = -infinity;
        var _far    = -infinity;
        
        var _i = 0;
        repeat(8)
        {
            var _position = _frustrumArray[_i];
            var _x = _position[0];
            var _y = _position[1];
            var _z = _position[2];
            
            _left = min(_left, _x);
            _top  = min(_top,  _y);
            _near = min(_near, _z);
            
            _right  = max(_right,  _x);
            _bottom = max(_bottom, _y);
            _far    = max(_far,    _z);
            
            ++_i;
        }
        
        __matrixView = _matrixView;
        __matrixProj = matrix_build_projection_ortho_ext(_left, _top, _right, _bottom, _near + nearOffset, _far + farOffset);
        __matrixViewProj = matrix_multiply(__matrixView, __matrixProj);
    }
    
    static GetFrustrumCoords = function()
    {
        return CbFrustrumCoordsGet(__matrixView, __matrixProj);
    }
    
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
        //__BuildMatrices();
        
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
        __matrixView = matrix_build_lookat(-dx, -dy, -dz,
                                           0, 0, 0,
                                           0, 0, 1);
        
        __matrixProj = matrix_build_projection_ortho(__width, __height, nearOffset + 1, farOffset + 1024);
        
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
        //__BuildMatrices();
        
        shader_set_uniform_matrix_array(_u_mLightViewProj, __matrixViewProj);
        shader_set_uniform_f(_u_vLightPos, -dx, -dy, -dz, 0);
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
        //__BuildMatrices();
        
        shader_set_uniform_matrix_array(_u_mLightViewProj, __matrixViewProj);
        shader_set_uniform_f(_u_vLightPos, -dx, -dy, -dz, 0);
        shader_set_uniform_f(_u_vLightColor, color_get_red(  color)/255,
                                             color_get_green(color)/255,
                                             color_get_blue( color)/255);
        shader_set_uniform_f(_u_vShadowMapBias, shadowMapBiasMin, shadowMapBiasMax, shadowMapBiasCoeff);
        texture_set_stage(_u_sLightDepth, surface_get_texture(__depthSurface));
    }
}