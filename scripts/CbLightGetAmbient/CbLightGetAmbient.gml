// Feather disable all

/// Returns the ambient light colour

function CbLightGetAmbient()
{
    __CB_GLOBAL_RENDER
    
    return _global.__lighting.__ambient;
}