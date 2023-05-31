/// Draws a particle system perpendicular to the floor ("standing up") and facing the camera
/// 
/// This function treats a z angle of 0 degrees as facing a camera pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
///
/// N.B. Particle system drawing cannot be baked into models, and this function draws the particle system immediately
///      Drawing particles is not compatible with lighting, nor does it write normals
/// 
/// @param ps      Particle system to draw
/// @param x       x-coordinate to draw the particle system at
/// @param y       y-coordinate to draw the particle system at
/// @param z       z-coordinate to draw the particle system at
/// @param xScale  Scale of the particle system on the x-axis
/// @param zScale  Scale of the particle system on the z-axis
/// @param yAngle  Rotation of the particle system around the y-axis

function CbPartSysBillboardExt(_pSystem, _x, _y, _z, _xScale, _zScale, _yAngle)
{
    __CB_GLOBAL
    
    return CbPartSysExt(_pSystem, _x, _y, _z, _xScale, _zScale, _yAngle, _global.__billboardYaw);
}