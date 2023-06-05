/// Returns a struct that contains the output width and height of the camera

function CbCameraSizeGet()
{
    __CB_GLOBAL_RENDER
    
    with(_global.__camera)
    {
        return {
            width:  __width,
            height: __height,
        };
    }
}