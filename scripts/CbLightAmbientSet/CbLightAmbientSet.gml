/// Sets the color of ambient lighting
/// 
/// @param color   Color of the ambient lighting

function CbLightAmbientSet(_color)
{
    __CB_GLOBAL
    
    _global.__lighting.__ambient = _color;
}