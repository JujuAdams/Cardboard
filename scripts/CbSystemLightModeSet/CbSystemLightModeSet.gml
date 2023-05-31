/// Sets the current lighting mode for Cardboard
/// 
/// The light mode should be specified using the CB_LIGHT_MODE enum
/// 
/// .NONE
///     No lighting is applied
/// 
/// .SIMPLE
///     Forward rendering
///     Up to 8 point lights and directional lights will be rendered
///     Shadow mapping is disabled
/// 
/// .ONE_SHADOW_MAP
///     Forward rendering with one shadow mapped light
///     Up to 6 point lights and directional lights will be rendered
///     A single shadow mapped light can be rendered
/// 
/// .DEFERRED
///     Deferred rendering
///     An unlimited number of lights of all types can be rendered
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