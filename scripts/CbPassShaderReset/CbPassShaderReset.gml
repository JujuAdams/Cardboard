/// Resets the Cardboard shader

function CbPassShaderReset()
{
    __CB_GLOBAL
    
    shader_reset();
    
    if (_global.__renderStateResetSurface)
    {
        _global.__renderStateResetSurface = false;
        surface_reset_target();
        if (__CB_SURFACE_SET_TARGET_EXT_WORKAROUND) surface_reset_target();
    }
}