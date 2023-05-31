/// Sets the location of a point light in Cb's native forward lighting shader
/// 
/// @param index   Index of the light to adjust
/// @param x       x-coordinate of the centre of the light
/// @param y       y-coordinate of the centre of the light
/// @param z       z-coordinate of the centre of the light
/// @param radius  Radius of the light
/// @param color   Color of the light

function CbLightPoint(_index, _x, _y, _z, _radius, _color)
{
    __CB_GLOBAL
    
    with(_global.__lighting)
    {
        __posRadArray[@ 4*_index  ] = _x;
        __posRadArray[@ 4*_index+1] = _y;
        __posRadArray[@ 4*_index+2] = _z;
        __posRadArray[@ 4*_index+3] = max(1, _radius);
        
        __colorArray[@ 3*_index  ] = color_get_red(  _color)/255;
        __colorArray[@ 3*_index+1] = color_get_green(_color)/255;
        __colorArray[@ 3*_index+2] = color_get_blue( _color)/255;
    }
}