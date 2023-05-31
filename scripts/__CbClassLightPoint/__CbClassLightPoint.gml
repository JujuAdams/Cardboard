function __CbClassLightPoint(_x, _y, _z, _radius, _color) constructor
{
    __CB_GLOBAL
    array_push(_global.__lighting.__array, weak_ref_create(self));
    
    visible = true;
    x       = _x;
    y       = _y;
    z       = _z;
    radius  = _radius;
    color   = _color;
    
    __destroyed = false;
    
    static Destroy = function()
    {
        __destroyed = true;
    }
    
    static __AddToGlobalArrays = function(_posRadArray, _posRadIndex, _colorArray, _colorIndex)
    {
        _posRadArray[@ _posRadIndex  ] = x;
        _posRadArray[@ _posRadIndex+1] = y;
        _posRadArray[@ _posRadIndex+2] = z;
        _posRadArray[@ _posRadIndex+3] = max(1, radius);
        
        _colorArray[@ _colorIndex  ] = color_get_red(  color)/255;
        _colorArray[@ _colorIndex+1] = color_get_green(color)/255;
        _colorArray[@ _colorIndex+2] = color_get_blue( color)/255;
    }
}