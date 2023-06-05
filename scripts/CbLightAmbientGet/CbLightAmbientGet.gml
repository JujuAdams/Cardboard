/// Returns the ambient light colour

function CbLightAmbientGet()
{
    __CB_GLOBAL_RENDER
    
    return _global.__lighting.__ambient;
}