/// Returns the current lighting mode

function CbLightModeGet()
{
    __CB_GLOBAL_RENDER
    
    return _global.__lighting.__lightMode;
}