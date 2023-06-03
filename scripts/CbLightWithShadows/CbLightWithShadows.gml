/// @param color
/// @param xFrom
/// @param yFrom
/// @param zFrom
/// @param xTo
/// @param yTo
/// @param zTo
/// @param FoV
/// @param near
/// @param far

function CbLightWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _near, _far)
{
    return new __CbClassLightWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _near, _far);
}