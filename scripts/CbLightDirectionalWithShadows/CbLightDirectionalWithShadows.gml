// Feather disable all

/// @param dX
/// @param dY
/// @param dZ
/// @param color
/// @param [near=1]
/// @param [far=1024]

function CbLightDirectionalWithShadows(_dx, _dy, _dz, _color, _near = 1, _far = 1024)
{
    return new __CbClassLightDirectionalWithShadows(_dx, _dy, _dz, _color, _near, _far);
}