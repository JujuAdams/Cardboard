enum __CARDBOARD_CAMERA_MODE
{
    AT,
    FROM,
    DELTA,
}

function CardboardCamera()
{
    prev1Call = __CARDBOARD_CAMERA_MODE.DELTA;
    prev0Call = __CARDBOARD_CAMERA_MODE.DELTA;
    
    __atX = 0;
    __atY = 0;
    __atZ = 0;
    
    __fromX = 0;
    __fromY = 1;
    __fromZ = 0;
    
    __dX = 0;
    __dY = 1;
    __dZ = 0;
    
    __axonometric = true;
    
    __upX = undefined;
    __upY = undefined;
    __upZ = undefined;
    
    __viewWidth  = window_get_width();
    __viewHeight = window_get_height();
    
    __surfaceWidth  = window_get_width();
    __surfaceHeight = window_get_height();
    
    __surfaceClear  = true;
    __surfaceColour = c_black;
    __surfaceAlpha  = 0;
    
    static Dimensions = function(_viewWidth, _viewHeight, _surfaceWidth, _surfaceHeight)
    {
        __viewWidth     = _viewWidth;
        __viewHeight    = _viewHeight;
        
        __surfaceWidth  = _surfaceWidth;
        __surfaceHeight = _surfaceHeight;
        
        return self;
    }
    
    static EnableSurfaceClear = function(_colour, _alpha)
    {
        __surfaceClear  = true;
        __surfaceColour = _colour;
        __surfaceAlpha  = _alpha;
        
        return self;
    }
    
    static DisableSurfaceClear = function(_colour, _alpha)
    {
        __surfaceClear = false;
        
        return self;
    }
    
    static Axonometric = function(_state)
    {
        __axonometric = _state;
        
        return self;
    }
    
    static LookAt = function(_x, _y, _z)
    {
        if (prev1Call != __CARDBOARD_CAMERA_MODE.AT)
        {
            prev1Call = prev0Call;
            prev0Call = __CARDBOARD_CAMERA_MODE.AT;
        }
        
        __atX = _x;
        __atY = _y;
        __atZ = _z;
        
        if (prev1Call == __CARDBOARD_CAMERA_MODE.FROM)
        {
            //Most recently defined LookAt and LookFrom
            __dX = __fromX - __atX;
            __dY = __fromX - __atY;
            __dZ = __fromX - __atZ;
        }
        else
        {
            //Most recently defined LookAt and LookDelta
            __fromX = __atX - __dX;
            __fromY = __atX - __dY;
            __fromZ = __atX - __dZ;
        }
        
        return self;
    }
    
    static LookFrom = function(_x, _y, _z)
    {
        if (prev1Call != __CARDBOARD_CAMERA_MODE.FROM)
        {
            prev1Call = prev0Call;
            prev0Call = __CARDBOARD_CAMERA_MODE.FROM;
        }
        
        __fromX = _x;
        __fromY = _y;
        __fromZ = _z;
        
        if (prev1Call == __CARDBOARD_CAMERA_MODE.AT)
        {
            //Most recently defined LookAt and LookFrom
            __dX = __fromX - __atX;
            __dY = __fromX - __atY;
            __dZ = __fromX - __atZ;
        }
        else
        {
            //Most recently defined LookFrom and LookDelta
            __atX = __fromX + __dX;
            __atY = __fromX + __dY;
            __atZ = __fromX + __dZ;
        }
        
        return self;
    }
    
    static LookDelta = function(_dx, _dy, _dz)
    {
        if (prev1Call != __CARDBOARD_CAMERA_MODE.DELTA)
        {
            prev1Call = prev0Call;
            prev0Call = __CARDBOARD_CAMERA_MODE.DELTA;
        }
        
        __dX = _x;
        __dY = _y;
        __dZ = _z;
        
        if (prev1Call == __CARDBOARD_CAMERA_MODE.AT)
        {
            //Most recently defined LookAt and LookDelta
            __fromX = __atX - __dX;
            __fromY = __atX - __dY;
            __fromZ = __atX - __dZ;
        }
        else
        {
            //Most recently defined LookFrom and LookDelta
            __atX = __fromX + __dX;
            __atY = __fromX + __dY;
            __atZ = __fromX + __dZ;
        }
        
        return self;
    }
    
    static GetProperties = function()
    {
        return {
            atX: __atX,
            atY: __atY,
            atZ: __atZ,
            
            fromX: __fromX,
            fromY: __fromY,
            fromZ: __fromZ,
            
            dX: __dX,
            dY: __dY,
            dZ: __dZ,
            
            axonometric: __axonometric,
            
            upX: __upX,
            upY: __upY,
            upZ: __upZ,
        };
    }
    
    static Set = function()
    {
        if ((__surface == undefined) || !surface_exists(__surface))
        {
            __surface = surface_create(__surfaceWidth, __surfaceHeight);
        }
        
        surface_set_target(__surface);
        if (__surfaceClear) draw_clear_alpha(__surfaceColour, __surfaceAlpha);
        
        __oldViewMatrix = matrix_get(matrix_view);
        global.__cardboardBillboardYaw = point_direction(__fromX, __fromY, __atX, __atY) - 90;
        matrix_set(matrix_view, CardboardViewMatrixBuild(__fromX, __fromY, __fromZ, __atX, __atY, __atZ, __axonometric, __upX, __upY, __upZ));
        
        return self;
    }
    
    static Reset = function()
    {
        surface_reset_target();
        
        global.__cardboardBillboardYaw = undefined;
        matrix_set(matrix_view, __oldViewMatrix);
        __oldViewMatrix = undefined;
        
        return self;
    }
}