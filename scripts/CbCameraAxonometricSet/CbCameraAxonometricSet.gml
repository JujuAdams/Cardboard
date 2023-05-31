/// Sets whether Cardboard's camera is in axonometric mode
/// 
/// @param state

function CbCameraAxonometricSet(_axonometric)
{
    __CB_GLOBAL
    
    _global.__camera.__axonometric = _axonometric;
}