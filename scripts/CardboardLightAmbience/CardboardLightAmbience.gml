/// Sets the color of ambient lighting
/// 
/// @param color   Color of the ambient lighting

function CardboardLightAmbience(_color)
{
    __CARDBOARD_GLOBAL
    
    with(_global)
    {
        __lightingAmbience = _color;
    }
}