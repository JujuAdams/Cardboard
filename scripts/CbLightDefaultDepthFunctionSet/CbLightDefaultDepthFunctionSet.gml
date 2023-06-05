/// @param  function

function CbLightDefaultDepthFunctionSet(_function)
{
    __CB_GLOBAL_RENDER
    
    _global.__lighting.__defaultDepthFunction = _function;
}