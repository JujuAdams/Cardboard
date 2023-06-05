/// @param enabled
/// @param [color]
/// @param [near]
/// @param [far]

function CbFogSet(_enabled, _color = undefined, _near = undefined, _far = undefined)
{
    __CB_GLOBAL
    
    if (_enabled)
    {
        with(_global.__fog)
        {
            __enabled = true;
            
            if (_color != undefined) __color = _color;
            if (_near  != undefined) __near  = _near;
            if (_far   != undefined) __far   = _far;
        }
    }
    else
    {
        _global.__fog.__enabled = false;
    }
}