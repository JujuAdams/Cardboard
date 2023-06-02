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
/// @param [xUp=0]
/// @param [yUp=0]
/// @param [zUp=1]

function CbLightWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _near, _far, _xUp = 0, _yUp = 1, _zUp = 0)
{
    return new __CbClassLightWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _near, _far, _xUp, _yUp, _zUp);
}