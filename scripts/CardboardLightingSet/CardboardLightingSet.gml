function CardboardLightingSet(_x, _y, _z, _radius, _color)
{
    __CARDBOARD_GLOBAL
    
    with(_global)
    {
        if (__lightingStarted)
        {
            __CardboardError("Cannot set lights after calling CardboardLightingStart()");
        }
        
        __lightingX      = _x;
        __lightingY      = _y;
        __lightingZ      = _z;
        __lightingRadius = _radius;
        __lightingColor  = _color;
    }
}