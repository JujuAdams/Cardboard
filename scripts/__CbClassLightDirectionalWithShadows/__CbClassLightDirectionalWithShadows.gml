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
    color   = _color;
    
    near = _near;
    far  = _far;
    
    depthFunction = undefined;
    
    
    
    __width  = CB_DEFAULT_DEFERRED_LIGHT_WIDTH;
    __height = CB_DEFAULT_DEFERRED_LIGHT_HEIGHT;
    
    __depthSurface = -1;
    
    __destroyed = false;
    
    __BuildMatrices();
    
    
    
    
    static TrackCamera = function()
    {
        var _d = 1 / sqrt(dx*dx + dy*dy + dz*dz);
        var _dx = _d*dx;
        var _dy = _d*dy;
        var _dz = _d*dz;
        
        __matrixView = matrix_build_lookat(_dx, _dy, _dz,   0,0,0,   0,0,1);
        
        var _matrixView = __matrixView;
        var _inverseView = __CbMatrixInvert(_matrixView);
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
        
        var _minX =  infinity;
        var _minY =  infinity;
        var _minZ =  infinity;
        var _maxX = -infinity;
        var _maxY = -infinity;
        var _maxZ = -infinity;
        
        var _i = 0;
        repeat(8)
        {
            var _position = _frustrumArray[_i];
            var _x = _position[0];
            var _y = _position[1];
            var _z = _position[2];
            
            _minX = min(_minX, _x);
            _minY = min(_minY, _y);
            _minZ = min(_minZ, _z);
            
            _maxX = max(_maxX, _x);
            _maxY = max(_maxY, _y);
            _maxZ = max(_maxZ, _z);
            
            ++_i;
        }
        
        var _left   =  _minX;
        var _right  =  _maxX;
        var _top    =  _maxY;
        var _bottom =  _minY;
        var _near   =  _minZ;
        var _far    =  _maxZ;
        
        var _tlNear = matrix_transform_vertex(_inverseView, _left,  _top,    _near);
        var _trNear = matrix_transform_vertex(_inverseView, _right, _top,    _near);
        var _blNear = matrix_transform_vertex(_inverseView, _left,  _bottom, _near);
        var _brNear = matrix_transform_vertex(_inverseView, _right, _bottom, _near);
        var _tlFar  = matrix_transform_vertex(_inverseView, _left,  _top,    _far);
        var _trFar  = matrix_transform_vertex(_inverseView, _right, _top,    _far);
        var _blFar  = matrix_transform_vertex(_inverseView, _left,  _bottom, _far);
        var _brFar  = matrix_transform_vertex(_inverseView, _right, _bottom, _far);
        
        var _native = matrix_build_projection_ortho(_right - _left, _bottom - _top, _near, _far);
        __matrixProj = [2 / (_right - _left), 0, 0, 0,
                        0, 2 / (_top - _bottom), 0, 0,
                        0, 0, 1 / (_far - _near), 0,
                        (_right + _left) / (_left - _right), (_bottom + _top) / (_bottom - _top), _near / (_near - _far), 1];
        
        if (keyboard_check_pressed(ord("K")))
        {
            instance_create_depth(0, 0, 0, oDebugLine, { a: _tlNear, b: _trNear, }).sprite = s3dLime;
            instance_create_depth(0, 0, 0, oDebugLine, { a: _tlNear, b: _blNear, }).sprite = s3dLime;
            instance_create_depth(0, 0, 0, oDebugLine, { a: _blNear, b: _brNear, }).sprite = s3dLime;
            instance_create_depth(0, 0, 0, oDebugLine, { a: _trNear, b: _brNear, }).sprite = s3dLime;
            
            instance_create_depth(0, 0, 0, oDebugLine, { a: _tlFar, b: _trFar, }).sprite = s3dGreen;
            instance_create_depth(0, 0, 0, oDebugLine, { a: _tlFar, b: _blFar, }).sprite = s3dGreen;
            instance_create_depth(0, 0, 0, oDebugLine, { a: _blFar, b: _brFar, }).sprite = s3dGreen;
            instance_create_depth(0, 0, 0, oDebugLine, { a: _trFar, b: _brFar, }).sprite = s3dGreen;
            
            instance_create_depth(0, 0, 0, oDebugLine, { a: _tlNear, b: _tlFar,  }).sprite = s3dLime;
            instance_create_depth(0, 0, 0, oDebugLine, { a: _trNear, b: _trFar,  }).sprite = s3dLime;
            instance_create_depth(0, 0, 0, oDebugLine, { a: _blNear, b: _blFar,  }).sprite = s3dLime;
            instance_create_depth(0, 0, 0, oDebugLine, { a: _brNear, b: _brFar,  }).sprite = s3dLime;
            CbCameraPerpsectiveSet(90);
        }
        
        if (keyboard_check_pressed(ord("K")))
        {
            CbCameraPerpsectiveSet(90);
            TurnFrustrumIntoWireframe(CbFrustrumCoordsGet(__matrixView, __matrixProj), s3dRed);
        }
        
        __matrixViewProj = matrix_multiply(__matrixView, __matrixProj);
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
        __matrixView = matrix_build_lookat(-dx, -dy, -dz,
                                           0, 0, 0,
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
        //__BuildMatrices();
        
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
        //__BuildMatrices();
        
        shader_set_uniform_matrix_array(_u_mLightViewProj, __matrixViewProj);
        shader_set_uniform_f(_u_vLightPos, -dx, -dy, -dz, 0);
        shader_set_uniform_f(_u_vLightColor, color_get_red(  color)/255,
                                             color_get_green(color)/255,
                                             color_get_blue( color)/255);
        texture_set_stage(_u_sLightDepth, surface_get_texture(__depthSurface));
    }
}