/// @param [near=-2048]
/// @param [far=2048]
/// @param [axonometric=true]

function CbCameraOrthographicSet(_near = -2048, _far = 2048, _axonometric = true)
{
    __CB_GLOBAL_RENDER
    
    with(_global.__camera)
    {
        __orthographic = true;
        
        __fieldOfView = undefined;
        __near        = _near;
        __far         = _far;
        
        __axonometric = _axonometric;
    }
}