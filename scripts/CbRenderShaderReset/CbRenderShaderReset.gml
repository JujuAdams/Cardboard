/// Resets the Cardboard shader

function CbRenderShaderReset()
{
    __CB_GLOBAL
    
    shader_reset();
    
    if (_global.__surfaceWorkaround)
    {
        _global.__surfaceWorkaround = false;
        surface_reset_target();
        if (__CB_SURFACE_SET_TARGET_EXT_WORKAROUND) surface_reset_target();
    }
}