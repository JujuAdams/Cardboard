/// Sets the current lighting mode for Cardboard
/// 
/// The light mode should be specified using the CB_LIGHT_MODE enum
/// 
/// .NONE           = No lighting is applied
/// .SIMPLE         = Forward rendering. Only point lights and directional lights will be rendered. Shadow mapping is disabled
/// .ONE_SHADOW_MAP = Forward rendering with one shadow mapped light. As above, but a single shadow mapped light can be rendered
/// .DEFERRED       = Deferred rendering. All Cardboard lights will be rendered. Unlimited shadow mapped lights supported
/// 
/// @param mode

function CbSystemLightModeSet(_mode)
{
    __CB_GLOBAL
    
    if (!CB_WRITE_NORMALS && (_mode != CB_LIGHT_MODE.NONE))
    {
        __CbError("Cannot set lighting mode when CB_WRITE_NORMALS is set to <false>");
    }
    
    _global.__lightMode = _mode;
}