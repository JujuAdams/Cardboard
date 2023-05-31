/// Returns a struct that contains the "up" position of Cardboard's camera

function CbCameraUpGet()
{
    __CB_GLOBAL
    
    with(_global.__camera)
    {
        return {
            x: __xUp,
            y: __yUp,
            z: __zUp,
        };
    }
}