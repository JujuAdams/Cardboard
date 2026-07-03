// Feather disable all

/// .SetFrom(x, y, z)
/// 
/// .GetFrom()
/// 
/// .SetTo(x, y, z)
/// 
/// .GetTo()
/// 
/// .SetUp(x, y, z)
/// 
/// .GetUp()
/// 
/// .SetSize(width, height)
/// 
/// .GetSize()
/// 
/// .SetOrthographic(near, far)
/// 
/// .SetPerspective(fieldOfView, near, far)
/// 
/// .GetProjection()
/// 
/// .SetZTilt(state)
/// 
/// .GetZTilt()
/// 
/// .SetAxonometric(state)
/// 
/// .GetAxonometric()
/// 
/// .SetBillboardYawCallback(function)
/// 
/// .GetBillboardYawCallback()
/// 
/// .GetViewMatrix()
/// 
/// .GetProjectionMatrix()
/// 
/// .ApplyMatrices()
/// 
/// .Start([alphaTestRef=0.5], [backfaceCulling=cull_noculling])
/// 
/// .End()
/// 
/// .GetFrustrumCoords()
/// 
/// .GetFrustrumLine(xNormalized, yNormalized)

function CbCamera() constructor
{
    __xFrom = 0;
    __yFrom = 128;
    __zFrom = 128;
    
    __xTo = 0;
    __yTo = 128;
    __zTo = 128;
    
    __xUp = 0;
    __yUp = 0;
    __zUp = 1;
    
    __orthographic = true;
    __axonometric  = true;
    __zTilt        = true;
    
    __fieldOfView  = 90;
    __near         = -1024;
    __far          =  1024;
    
    __width  = surface_get_width( application_surface);
    __height = surface_get_height(application_surface);
    
    try
    {
        __billboardYawSetFunc = CbBillboardSetYaw;
    }
    catch(_error)
    {
        __billboardYawSetFunc = undefined;
    }
    
    __oldViewMatrix       = matrix_get(matrix_view);
    __oldProjectionMatrix = matrix_get(matrix_projection);
    
    
    
    
    
    static SetFrom = function(_x, _y, _z)
    {
        __xFrom = _x;
        __yFrom = _y;
        __zFrom = _z;
        
        if (__billboardYawSetFunc != undefined)
        {
            __billboardYawSetFunc(__xFrom, __yFrom, __xTo, __yTo);
        }
    }
    
    static GetFrom = function()
    {
        static _result = {};
        _result.x = __xFrom;
        _result.y = __yFrom;
        _result.z = __zFrom;
        return _result;
    }
    
    static SetTo = function(_x, _y, _z)
    {
        __xTo = _x;
        __yTo = _y;
        __zTo = _z;
        
        if (__billboardYawSetFunc != undefined)
        {
            __billboardYawSetFunc(__xFrom, __yFrom, __xTo, __yTo);
        }
    }
    
    static GetTo = function()
    {
        static _result = {};
        _result.x = __xTo;
        _result.y = __yTo;
        _result.z = __zTo;
        return _result;
    }
    
    static SetUp = function(_x, _y, _z)
    {
        __xUp = _x;
        __yUp = _y;
        __zUp = _z;
    }
    
    static GetUp = function()
    {
        static _result = {};
        _result.x = __xUp;
        _result.y = __yUp;
        _result.z = __zUp;
        return _result;
    }
    
    static SetSize = function(_width, _height)
    {
        __width  = _width;
        __height = _height;
    }
    
    static GetSize = function()
    {
        static _result = {};
        _result.width  = __width;
        _result.height = __height;
        return _result;
    }
    
    static SetOrthographic = function(_near = undefined, _far = undefined)
    {
        __orthographic = true;
        
        if (_near != undefined) __near = _near;
        if (_far  != undefined) __far  = _far;
    }
    
    static SetPerspective = function(_fieldOfView = undefined, _near = undefined, _far = undefined)
    {
        __orthographic = false;
        
        if (_fieldOfView != undefined) __fieldOfView = _fieldOfView;
        if (_near        != undefined) __near        = _near;
        if (_far         != undefined) __far         = _far;
    }
    
    static GetProjection = function()
    {
        static _result = {};
        _result.orthographic = __orthographic;
        _result.fieldOfView  = __fieldOfView;
        _result.near         = __near;
        _result.far          = __far;
        return _result;
    }
    
    static SetZTilt = function(_state)
    {
        __zTilt = _state;
    }
    
    static GetZTilt = function()
    {
        return __zTilt;
    }
    
    static SetAxonometric = function(_state)
    {
        __axonometric = _state;
    }
    
    static GetAxonometric = function()
    {
        return __axonometric;
    }
    
    static SetBillboardYawCallback = function(_function)
    {
        __billboardYawSetFunc = _function;
    }
    
    static GetBillboardYawCallback = function()
    {
        return __billboardYawSetFunc;
    }
    
    static GetViewMatrix = function()
    {
        if (__zTilt)
        {
            return CbCameraBuildZTiltViewMatrix(__xFrom, __yFrom, __zFrom, __xTo, __yTo, __zTo, __orthographic && __axonometric, __xUp, __yUp, __zUp);
        }
        else
        {
            return matrix_build_lookat(__xFrom, __yFrom, __zFrom, __xTo, __yTo, __zTo, __xUp, __yUp, __zUp);
        }
    }
    
    static GetProjectionMatrix = function()
    {
        if (__orthographic)
        {
            return matrix_build_projection_ortho(__width, __height, __near, __far);
        }
        else
        {
            return matrix_build_projection_perspective_fov(__fieldOfView, __width/__height, __near, __far);
        }
    }
    
    static ApplyMatrices = function()
    {
        matrix_set(matrix_view, GetViewMatrix());
        
        if ((os_type == os_xboxone) || (os_type == os_xboxseriesxs) || (os_type == os_ps5) || (os_type == os_windows))
        {
            matrix_set(matrix_projection, GetProjectionMatrix());
        }
        else
        {
            var _projectionMatrix = GetProjectionMatrix();
            
            _projectionMatrix[@  1] = -_projectionMatrix[ 1];
            _projectionMatrix[@  5] = -_projectionMatrix[ 5];
            _projectionMatrix[@  9] = -_projectionMatrix[ 9];
            _projectionMatrix[@ 13] = -_projectionMatrix[13];
            
            matrix_set(matrix_projection, _projectionMatrix);
        }
    }
    
    static Start = function(_alphaTestRef = 0.5, _backfaceCulling = cull_noculling)
    {
        __oldViewMatrix       = matrix_get(matrix_view);
        __oldProjectionMatrix = matrix_get(matrix_projection);
        
        ApplyMatrices();
        
        gpu_set_ztestenable(true);
        gpu_set_zwriteenable(true);
        gpu_set_cullmode(_backfaceCulling);
        
        if (_alphaTestRef >= 0)
        {
            gpu_set_alphatestenable(true);
            gpu_set_alphatestref(_alphaTestRef);
            gpu_set_blendenable(false);
        }
        else
        {
            gpu_set_alphatestenable(false);
            gpu_set_blendenable(true);
        }
    }
    
    static End = function()
    {
        matrix_set(matrix_view,       __oldViewMatrix);
        matrix_set(matrix_projection, __oldProjectionMatrix);
        
        gpu_set_ztestenable(false);
        gpu_set_zwriteenable(false);
        gpu_set_cullmode(cull_noculling);
        gpu_set_alphatestenable(false);
        gpu_set_blendenable(true);
    }
    
    static GetFrustrumCoords = function()
    {
        return CbCameraGetFrustrumCoords(GetViewMatrix(), GetProjectionMatrix());
    }
    
    static GetFrustrumLine = function(_xNorm = 0, _yNorm = 0)
    {
        static _result = {
            x1: 0,
            y1: 0,
            z1: 0,
            x2: 0,
            y2: 0,
            z2: 0,
        };
        
        //TODO - Optimise
        var _vpMatrixInverse = matrix_inverse(matrix_multiply(GetViewMatrix(), GetProjectionMatrix()));
        
        with(_result)
        {
            var _vector = matrix_transform_vertex(_vpMatrixInverse, _xNorm, -_yNorm, 0, 1);
            var _w = _vector[3];
            x1 = _vector[0] / _w;
            y1 = _vector[1] / _w;
            z1 = _vector[2] / _w;
            
            var _vector = matrix_transform_vertex(_vpMatrixInverse, _xNorm, -_yNorm, 1, 1);
            var _w = _vector[3];
            x2 = _vector[0] / _w;
            y2 = _vector[1] / _w;
            z2 = _vector[2] / _w;
        }
        
        return _result;
    }
}