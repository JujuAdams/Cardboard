/// Draws a native GameMaker particle system perpendicular to the floor ("standing up")
/// 
/// This function presumes that the camera is pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// Particle system drawing cannot be baked into models, and this function draws the particle system immediately
/// 
/// @param ps  Particle system to draw
/// @param x   x-coordinate to draw the particle system at
/// @param y   y-coordinate to draw the particle system at
/// @param z   z-coordinate to draw the particle system at

function CardboardPartSys(_pSystem, _x, _y, _z)
{
    __CARDBOARD_GLOBAL
    __CARDBOARD_PARTICLE_SYSTEM_COMMON_TEXTURE
    
    var _oldWorldMatrix = matrix_get(matrix_world);
    matrix_set(matrix_world, matrix_multiply(_oldWorldMatrix, matrix_build(_x, _y, _z,   90, 0, 0,   1, 1, 1)));
    part_system_drawit(_pSystem);
    matrix_set(matrix_world, _oldWorldMatrix);
}