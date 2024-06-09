/// @param length
/// @param thickness
/// @param position{vec3}
/// @param direction{vec3}
/// @param texture
function b3d_draw_line(argument0, argument1, argument2, argument3, argument4) {

    var _length    = argument0;
    var _thickness = argument1;
    var _position  = argument2;
    var _direction = argument3;
    var _texture   = argument4;

    if ( _length == 0 ) return false;

    var _plane_length = sqrt( _direction[0]*_direction[0] + _direction[1]*_direction[1] );
    var _z_angle = point_direction( 0, 0, _plane_length, _direction[2] );
    var _p_angle = point_direction( 0, 0, _direction[0], _direction[1] );

    if ( _length == undefined )
    {
        _position[0] -= _direction[0]*B3D_INFINITE_SCALE;
        _position[1] -= _direction[1]*B3D_INFINITE_SCALE;
        _position[2] -= _direction[2]*B3D_INFINITE_SCALE;
        _length = 2*B3D_INFINITE_SCALE;
    }

    matrix_chain_begin();
    matrix_chain_scale( _thickness, _thickness, _length );
    matrix_chain_rotate_y( -90 - _z_angle );
    matrix_chain_rotate_z( _p_angle );
    matrix_chain_translate( _position[0], _position[1], _position[2] );
    matrix_chain_push();
    vertex_submit( global.b3d_line, pr_trianglelist, b3d_check_texture( _texture ) );
    matrix_chain_pop();

    return true;


}
