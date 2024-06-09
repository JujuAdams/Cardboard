/// @param vertex0
/// @param vertex1
/// @param vertex2
/// @param colour
/// @param normal
function b3d_draw_triangle_ext(argument0, argument1, argument2, argument3, argument4) {

    var _vertex_list  = [ argument0, argument1, argument2 ];
    var _colour       = argument3;
    var _normal       = argument4;

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

    vertex_submit( _vbuff, pr_trianglelist, B3D_DEFAULT_TEXTURE );
    vertex_delete_buffer( _vbuff );


}
