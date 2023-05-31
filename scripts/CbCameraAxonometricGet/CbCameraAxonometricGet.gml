/// Returns whether Cardboard's camera is in axonometric mode

function CbCameraAxonometricGet()
{
    __CB_GLOBAL
    
    return _global.__camera.__axonometric;
}