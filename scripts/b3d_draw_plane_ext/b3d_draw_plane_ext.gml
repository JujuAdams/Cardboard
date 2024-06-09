/// @param offset{vec3}
/// @param plane{vec4}
/// @param size
/// @param texture
function b3d_draw_plane_ext(argument0, argument1, argument2, argument3) {

    var _offset  = argument0;
    var _plane   = argument1;
    var _size    = argument2;
    var _texture = argument3;

    var _position = vec3_scale( _plane, _plane[3] );
    if ( _offset != undefined ) _position = vec3_add( _offset, _position );

    var _vertex_buffer = b3d_vertex_buffer_plane( _position[0], _position[1], _position[2],
                                                  _plane[0], _plane[1], _plane[2],
                                                  _size,
                                                  global.b3d_uvs[0], global.b3d_uvs[1],
                                                  global.b3d_uvs[2], global.b3d_uvs[3] );
    if ( _vertex_buffer == undefined ) exit;
    vertex_submit( _vertex_buffer, pr_trianglelist, b3d_check_texture( _texture ) );
    vertex_delete_buffer( _vertex_buffer );


}
