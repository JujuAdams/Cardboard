function __CbClassLightDirectional(_dx, _dy, _dz, _color) constructor
{
    __CB_GLOBAL
    array_push(_global.__lighting.__array, weak_ref_create(self));
    
    visible = true;
    dx      = _dx;
    dy      = _dy;
    dz      = _dz;
    color   = _color;
    
    __destroyed = false;
    
    static Destroy = function()
    {
        __destroyed = true;
    }
    
    static RenderDepth = function()
    {
        //Do nothing!
    }
    
    static __AddToGlobalArrays = function(_posRadArray, _posRadIndex, _colorArray, _colorIndex)
    {
        _posRadArray[@ _posRadIndex  ] = dx;
        _posRadArray[@ _posRadIndex+1] = dy;
        _posRadArray[@ _posRadIndex+2] = dz;
        _posRadArray[@ _posRadIndex+3] = 0;
        
        _colorArray[@ _colorIndex  ] = color_get_red(  color)/255;
        _colorArray[@ _colorIndex+1] = color_get_green(color)/255;
        _colorArray[@ _colorIndex+2] = color_get_blue( color)/255;
    }
}