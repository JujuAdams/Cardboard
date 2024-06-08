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