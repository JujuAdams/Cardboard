// Feather disable all

function CbCameraParamsGet()
{
    __CB_GLOBAL_RENDER
    
    static _result = {
        fov:         undefined,
        near:        undefined,
        far:         undefined,
        axonometric: undefined,
    };
    
    with(_global.__camera)
    {
        _result.orthographic = __orthographic;
        _result.fov          = __fieldOfView;
        _result.near         = __near;
        _result.far          = __far;
        _result.axonometric  = __axonometric;
    }
    
    return _result;
}