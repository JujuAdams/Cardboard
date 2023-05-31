/// Returns a struct that contains the "from" position of Cardboard's camera

function CbCameraFromGet()
{
    __CB_GLOBAL
    
    with(_global.__camera)
    {
        return {
            x: __xFrom,
            y: __yFrom,
            z: __zFrom,
        };
    }
}