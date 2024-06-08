#macro __CB_CAMERA_OPENGL  (((os_type != os_windows) && (os_type != os_xboxone) && (os_type != os_xboxseriesxs)) || (os_browser != browser_not_a_browser))

function __CbCameraSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __set              = false;
        __worldMatrix      = undefined;
        __viewMatrix       = undefined;
        __projectionMatrix = undefined;
    }
    
    return _system;
}