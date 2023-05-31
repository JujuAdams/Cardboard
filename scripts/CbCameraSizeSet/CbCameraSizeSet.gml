/// Sets the output size of Cardboard's camera
/// 
/// @param width
/// @param height

function CbCameraSizeSet(_width, _height)
{
    __CB_GLOBAL
    
    with(_global.__camera)
    {
        __width  = _width;
        __height = _height;
    }
}