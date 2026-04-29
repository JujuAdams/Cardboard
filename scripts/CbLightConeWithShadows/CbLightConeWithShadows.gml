// Feather disable all

/// Variables:
/// .xFrom .yFrom .zFrom
/// 
/// .xTo .yTo .zTo
/// 
/// .xUp .yUp .zUp
/// 
/// .color
/// 
/// .visible
/// 
/// .fov
/// 
/// .radius
/// 
/// .near .far
/// 
/// .shadowMapBiasMin .shadowMapBiasMax .shadowMapBiasCoeff
/// 
/// .depthFunction
/// 
/// 
/// Methods:
/// .DrawDebug()
/// 
/// .Destroy()
/// 
/// 
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
/// @param [far=radius]

function CbLightConeWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _radius, _near = 1, _far = 2*_radius)
{
    return new __CbClassLightWithShadows(_color, _xFrom, _yFrom, _zFrom, _xTo, _yTo, _zTo, _fov, _radius, _near, _far);
}