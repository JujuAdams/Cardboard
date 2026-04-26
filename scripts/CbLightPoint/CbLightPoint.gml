// Feather disable all

/// Variables:
/// .x .y .z
/// 
/// .radius
/// 
/// .color
/// 
/// .visible
/// 
/// 
/// Methods:
/// .Destroy()
/// 
/// @param x
/// @param y
/// @param z
/// @param radius
/// @param color

function CbLightPoint(_x, _y, _z, _radius, _color)
{
    return new __CbClassLightPoint(_x, _y, _z, _radius, _color);
}