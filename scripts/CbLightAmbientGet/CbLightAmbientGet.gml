/// Returns the ambient light colour

function CbLightAmbientGet()
{
    __CB_GLOBAL
    
    return _global.__lighting.__ambient;
}