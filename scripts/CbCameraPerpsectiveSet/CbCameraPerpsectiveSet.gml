/// @param FoV
/// @param [near=1]
/// @param [far=2048]

function CbCameraPerpsectiveSet(_FoV, _near = 1, _far = 2048)
{
    __CB_GLOBAL
    
    with(_global.__camera)
    {
        __orthographic = false;
        
        __perspectiveFoV = _FoV;
        __near           = _near;
        __far            = _far;
    }
}