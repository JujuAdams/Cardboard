// Feather disable all

/// Returns the current lighting mode

function CbGetLightingMode()
{
    __CB_GLOBAL_RENDER
    
    return _global.__lighting.__lightMode;
}