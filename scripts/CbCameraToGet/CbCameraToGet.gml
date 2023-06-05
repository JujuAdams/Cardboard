/// Returns a struct that contains the "to" position of Cardboard's camera

function CbCameraToGet()
{
    __CB_GLOBAL_BUILD
    
    with(_global.__camera)
    {
        return {
            x: __xTo,
            y: __yTo,
            z: __zTo,
        };
    }
}