/// Sets the color of ambient lighting
/// 
/// @param color   Color of the ambient lighting

function CardboardLightingAmbienceSet(_color)
{
    __CARDBOARD_GLOBAL
    
    with(_global)
    {
        if (__lightingStarted)
        {
            __CardboardError("Cannot set ambient lighting after calling CardboardLightingStart()");
        }
        
        __lightingAmbience = _color;
    }
}