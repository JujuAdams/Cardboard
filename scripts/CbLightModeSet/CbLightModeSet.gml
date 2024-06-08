/// Sets the current lighting mode for Cardboard
/// 
/// The light mode should be specified using the CB_LIGHT_MODE enum
/// 
/// .DISABLE_LIGHTING
///     No lighting is applied
/// 
/// .NO_SHADOWED_LIGHTS
///     Forward rendering
///     Up to 8 point lights and directional lights will be rendered
///     Shadow mapping is disabled
/// 
/// .ONE_SHADOWED_LIGHT
///     Forward rendering with one shadow mapped light
///     Up to 6 point lights and directional lights will be rendered
///     A single shadow mapped light can be rendered
/// 
/// .DEFERRED
///     Deferred rendering
///     An unlimited number of lights of all types can be rendered
/// 
/// @param mode

function CbLightModeSet(_mode)
{
    __CB_GLOBAL_RENDER
    
    _global.__lightMode = _mode;
}