/// @param [near=-2048]
/// @param [far=2048]

function CbCameraOrthographicSet(_near = -2048, _far = 2048)
{
    __CB_GLOBAL
    
    with(_global.__camera)
    {
        __orthographic = true;
        
        __near = _near;
        __far  = _far;
    }
}