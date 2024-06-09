b3d_init();

function b3d_init() {
    global.b3d_primitive = pr_trianglelist;

    vertex_format_begin();
    vertex_format_add_position_3d(); //12
    vertex_format_add_texcoord();    // 8
    vertex_format_add_colour();      // 4
    vertex_format_add_normal();      //12 = 36 bytes
    global.b3d_format = vertex_format_end();

    global.b3d_uvs = sprite_get_uvs( B3D_DEFAULT_SPRITE, 0 );
    var _uvs = global.b3d_uvs;

    global.b3d_sphere = b3d_vertex_buffer_sphere( -1, -1, -1,
                                                   1,  1,  1,
                                                   24,
                                                   _uvs[0], _uvs[1],
                                                   _uvs[2], _uvs[3] );

    global.b3d_cone = b3d_vertex_buffer_cone( -1, -1, -1,
                                               1,  1,  1,
                                               true, 24,
                                               _uvs[0], _uvs[1],
                                               _uvs[2], _uvs[3],
                                               c_white );

    global.b3d_cube = b3d_vertex_buffer_cube( -0.5, -0.5, -0.5,
                                               0.5,  0.5,  0.5,
                                               _uvs[0], _uvs[1],
                                               _uvs[2], _uvs[3] );

    global.b3d_cylinder = b3d_vertex_buffer_cylinder( -1, -1, -0.5,
                                                       1,  1,  0.5,
                                                       true, 24 );

    global.b3d_cylinder_no_cap = b3d_vertex_buffer_cylinder( -1, -1, -0.5,
                                                              1,  1,  0.5,
                                                              false, 24 );

    global.b3d_line = b3d_vertex_buffer_cylinder( -0.5, -0.5, 0,
                                                   0.5,  0.5, 1,
                                                   true, 4 );

    global.b3d_arrow = b3d_vertex_buffer_cone( -0.5, -0.5, 0,
                                                0.5,  0.5, 1,
                                                true, 3,
                                                _uvs[0], _uvs[1],
                                                _uvs[2], _uvs[3],
                                                c_white );


}
