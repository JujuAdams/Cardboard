// Feather disable all

/// Sets a function to execute when rendering the depth buffer for shadow-mapped lights. This
/// function can be overriden on a per-light basis by setting the `.depthFunction` variable on the
/// light struct.
/// 
/// @param function

function CbLightSetDefaultDepthFunction(_function)
{
    __CB_GLOBAL_RENDER
    
    _global.__lighting.__defaultDepthFunction = _function;
}