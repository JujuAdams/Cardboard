/// Draws a particle system perpendicular to the floor ("standing up")
/// 
/// This function treats a z angle of 0 degrees as facing a camera pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// Particle system drawing cannot be baked into models, and this function draws the particle system immediately
/// 
/// @param ps      Particle system to draw
/// @param x       x-coordinate to draw the particle system at
/// @param y       y-coordinate to draw the particle system at
/// @param z       z-coordinate to draw the particle system at
/// @param xScale  Scale of the particle system on the x-axis
/// @param zScale  Scale of the particle system on the z-axis
/// @param yAngle  Rotation of the particle system around the y-axis
/// @param zAngle  Rotation of the particle system around the z-axis

function CardboardPartSysExt(_pSystem, _x, _y, _z, _xScale, _zScale, _yAngle, _zAngle)
{
    __CARDBOARD_GLOBAL
    __CARDBOARD_PARTICLE_SYSTEM_COMMON_TEXTURE
    
    var _oldWorldMatrix = matrix_get(matrix_world);
    
    var _matrix = matrix_build(0, 0, 0,   90, 0, 0,   1, 1, 1);
    _matrix = matrix_multiply(_matrix, matrix_build(0, 0, 0,   0, _yAngle, _zAngle,   1, 1, 1));
    _matrix = matrix_multiply(_matrix, matrix_build(_x, _y, _z,   0, 0, 0,   _xScale, _zScale, 1));
    _matrix = matrix_multiply(_oldWorldMatrix, _matrix);
    
    matrix_set(matrix_world, _matrix);
    part_system_drawit(_pSystem);
    matrix_set(matrix_world, _oldWorldMatrix);
}