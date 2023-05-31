/// Sets the color of ambient lighting
/// 
/// @param color   Color of the ambient lighting

function CbLightAmbience(_color)
{
    __CB_GLOBAL
    
    with(_global)
    {
        __lightingAmbience = _color;
    }
}