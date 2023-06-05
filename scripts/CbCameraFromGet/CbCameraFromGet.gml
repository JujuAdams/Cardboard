/// Returns a struct that contains the "from" position of Cardboard's camera

function CbCameraFromGet()
{
    __CB_GLOBAL_RENDER
    
    with(_global.__camera)
    {
        return {
            x: __xFrom,
            y: __yFrom,
            z: __zFrom,
        };
    }
}