/// @param vertex0
/// @param vertex1
/// @param vertex2
/// @param colour
/// @param flip_normal
/// @param [primitive]
function b3d_draw_triangle() {

    var _vertex_list  = [ argument[0], argument[1], argument[2] ];
    var _colour       = argument[3];
    var _flip_normals = argument[4];
    var _primitive    = (argument_count > 5)? argument[5] : global.b3d_primitive;

    var _normal = vec3_triad_normal( _vertex_list[0], _vertex_list[1], _vertex_list[2], _flip_normals );

    var _vbuff = vertex_create_buffer();
    vertex_begin( _vbuff, B3D_DEFAULT_FORMAT );
    for( var _i = 0; _i < 3; _i++ )
    {
        var _vertex = _vertex_list[_i];
        b3d_vertex_add( _vbuff,
                        _vertex[0], _vertex[1], _vertex[2],
                        0.5, 0.5,
                        _colour, 1,
                        _normal[0], _normal[1], _normal[2] );
    }
    vertex_end( _vbuff );

    vertex_submit( _vbuff, _primitive, B3D_DEFAULT_TEXTURE );
    vertex_delete_buffer( _vbuff );


}
