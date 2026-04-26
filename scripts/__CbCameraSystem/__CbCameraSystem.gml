// Feather disable all

__CbCameraSystem();
function __CbCameraSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    show_debug_message("CbCamera: Welcome to Cardboard Camera by Juju Adams! This is version " + CB_CAMERA_VERSION + ", " + CB_CAMERA_DATE);
    
    _system = {};
    with(_system)
    {
        
    }
    
    return _system;
}