/// @param position{vec3}
/// @param normal{vec3}
/// @param size
/// @param texture
/// @param [primitive]
function b3d_draw_plane() {

    var _position  = argument[0];
    var _normal    = argument[1];
    var _size      = argument[2];
    var _texture   = argument[3];
    var _primitive = (argument_count > 4)? argument[4] : global.b3d_primitive;

    if ( is_ptr( _texture ) )
    {
        var _vertex_buffer = b3d_vertex_buffer_plane( _position[0], _position[1], _position[2],
                                                      _normal[0], _normal[1], _normal[2],
                                                      _size,
                                                      global.b3d_uvs[0], global.b3d_uvs[1],
                                                      global.b3d_uvs[2], global.b3d_uvs[3] );
    }
    else
    {
        _texture = B3D_DEFAULT_TEXTURE;
        var _vertex_buffer = b3d_vertex_buffer_plane( _position[0], _position[1], _position[2],
                                                      _normal[0], _normal[1], _normal[2],
                                                      _size,
                                                      global.b3d_uvs[0], global.b3d_uvs[1],
                                                      global.b3d_uvs[2], global.b3d_uvs[3] );
    }

    if ( _vertex_buffer == undefined ) exit;
    vertex_submit( _vertex_buffer, _primitive, b3d_check_texture( _texture ) );
    vertex_delete_buffer( _vertex_buffer );


}
