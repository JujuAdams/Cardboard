/// @param color
/// @param xFrom
/// @param yFrom
/// @param zFrom
/// @param xTo
/// @param yTo
/// @param zTo
/// @param FoV
/// @param radius
/// @param [near=1]
/// @param [far=2*radius]

function CbLightWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _radius, _near = 1, _far = 2*_radius)
{
    return new __CbClassLightWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _radius, _near, _far);
}