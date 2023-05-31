/// Returns the current lighting mode

function CbSystemLightModeGet()
{
    __CB_GLOBAL
    
    return _global.__lightMode;
}