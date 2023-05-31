/// @param index
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

function CbLightShadow(_index, _color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _near, _far, _xUp = 0, _yUp = 0, _zUp = 1)
{
    __CB_GLOBAL
    
    if (_index > __CB_SHADOW_COUNT)
    {
        __CbError("Cannot set shadow mapping for light ", _index, " (shadow mapping can only be applied to light 0 and light 1)");
    }
    
    with(_global.__lightingShadowArray[_index])
    {
        __state = (_color > c_black);
        __color = _color;
        
        __xFrom = _xFrom;
        __yFrom = _yFrom;
        __zFrom = _zFrom;
        
        __xTo   = _xTo;
        __yTo   = _yTo;
        __zTo   = _zTo;
        
        __fov   = _fov;
        __near  = _near;
        __far   = _far;
        
        __xUp   = _xUp;
        __yUp   = _yUp;
        __zUp   = _zUp;
    }
}