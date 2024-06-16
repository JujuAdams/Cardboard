#macro __CB_CAMERA_VERSION  "3.0.0"
#macro __CB_CAMERA_DATE     "2024-06-16"

#macro __CB_CAMERA_OPENGL  (((os_type != os_windows) && (os_type != os_xboxone) && (os_type != os_xboxseriesxs)) || (os_browser != browser_not_a_browser))

__CbCameraSystem();
function __CbCameraSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    show_debug_message("CbCamera: Welcome to Cardboard Camera by Juju Adams! This is version " + __CB_CAMERA_VERSION + ", " + __CB_CAMERA_DATE);
    
    _system = {};
    with(_system)
    {
        
    }
    
    return _system;
}