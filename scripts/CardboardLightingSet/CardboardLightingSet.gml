/// Sets the location of a point light in Cardboard's native forward lighting shader
/// 
/// @param x       x-coordinate of the centre of the light
/// @param y       y-coordinate of the centre of the light
/// @param z       z-coordinate of the centre of the light
/// @param radius  Radius of the light
/// @param color   Color of the light

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