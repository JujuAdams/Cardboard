/// @param length
/// @param thickness
/// @param position{vec3}
/// @param direction{vec3}
/// @param texture
/// @param [colour]
function b3d_draw_arrow() {

    var _length    = argument[0];
    var _thickness = argument[1];
    var _position  = argument[2];
    var _direction = argument[3];
    var _texture   = argument[4];
    var _colour    = ((argument_count > 5) && (argument[5] != undefined))? argument[5] : c_white;

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

    if ( _colour == c_white )
    {
        vertex_submit( global.b3d_arrow, pr_trianglelist, b3d_check_texture( _texture ) );
    }
    else
    {
        var _vbuff = b3d_vertex_buffer_cone( -0.5, -0.5, 0,
                                              0.5,  0.5, 1,
                                              true, 3,
                                              global.b3d_uvs[0], global.b3d_uvs[1],
                                              global.b3d_uvs[2], global.b3d_uvs[3],
                                              _colour );
        vertex_submit( _vbuff, pr_trianglelist, b3d_check_texture( _texture ) );
        vertex_delete_buffer( _vbuff );
    }

    matrix_chain_pop();

    return true;


}
