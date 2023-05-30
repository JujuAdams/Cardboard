/// Sets a directional light in Cardboard's native forward lighting shader
/// 
/// @param index   Index of the light to adjust
/// @param x       x component of the light's direction vector
/// @param y       y component of the light's direction vector
/// @param z       z component of the light's direction vector
/// @param color   Color of the light

function CardboardLightDirectional(_index, _x, _y, _z, _color)
{
    __CARDBOARD_GLOBAL
    
    with(_global)
    {
        __lightingPosRadArray[@ 4*_index  ] = _x;
        __lightingPosRadArray[@ 4*_index+1] = _y;
        __lightingPosRadArray[@ 4*_index+2] = _z;
        __lightingPosRadArray[@ 4*_index+3] = 0;
        
        __lightingColorArray[@ 3*_index  ] = color_get_red(  _color)/255;
        __lightingColorArray[@ 3*_index+1] = color_get_green(_color)/255;
        __lightingColorArray[@ 3*_index+2] = color_get_blue( _color)/255;
    }
}