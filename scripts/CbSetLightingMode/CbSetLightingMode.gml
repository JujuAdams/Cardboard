// Feather disable all

/// Sets the current lighting mode for Cardboard.
/// 
/// The light mode should be specified using the `CB_LIGHTING` constants:
/// 
/// `CB_LIGHTING_DISABLE_LIGHTING`
///     No lighting is applied
/// 
/// `CB_LIGHTING_DISABLE_NO_SHADOWED_LIGHTS`
///     Forward rendering
///     Up to 8 point lights and directional lights will be rendered
///     Shadow mapping is disabled
/// 
/// `CB_LIGHTING_DISABLE_ONE_SHADOWED_LIGHT`
///     Forward rendering with one shadow mapped light
///     Up to 6 point lights and directional lights will be rendered
///     A single shadow mapped light can be rendered
/// 
/// `CB_LIGHTING_DISABLE_DEFERRED`
///     Deferred rendering
///     An unlimited number of lights of all types can be rendered
/// 
/// @param mode

function CbSetLightingMode(_mode)
{
    __CB_GLOBAL_RENDER
    
    _global.__lighting.__lightMode = _mode;
}