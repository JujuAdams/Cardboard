/// @param x1
/// @param y1
/// @param z1
/// @param x2
/// @param y2
/// @param z2
/// @param UV_l
/// @param UV_t
/// @param UV_r
/// @param UV_b
function b3d_vertex_buffer_cube(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9) {

	var _x1   = argument0;
	var _y1   = argument1;
	var _z1   = argument2;
	var _x2   = argument3;
	var _y2   = argument4;
	var _z2   = argument5;
	var _uv_l = argument6;
	var _uv_t = argument7;
	var _uv_r = argument8;
	var _uv_b = argument9;

	var _colour = c_white,
	var _alpha  = 1;

	var _vbuff = vertex_create_buffer();
	vertex_begin( _vbuff, B3D_DEFAULT_FORMAT );


	//Below
	b3d_vertex_add( _vbuff,   _x1, _y1, _z1,   _uv_l, _uv_t,   _colour, _alpha,    0,  0, -1 );
	b3d_vertex_add( _vbuff,   _x1, _y2, _z1,   _uv_l, _uv_b,   _colour, _alpha,    0,  0, -1 );
	b3d_vertex_add( _vbuff,   _x2, _y2, _z1,   _uv_r, _uv_b,   _colour, _alpha,    0,  0, -1 );

	b3d_vertex_add( _vbuff,   _x2, _y2, _z1,   _uv_r, _uv_b,   _colour, _alpha,    0,  0, -1 );
	b3d_vertex_add( _vbuff,   _x2, _y1, _z1,   _uv_r, _uv_t,   _colour, _alpha,    0,  0, -1 );
	b3d_vertex_add( _vbuff,   _x1, _y1, _z1,   _uv_l, _uv_t,   _colour, _alpha,    0,  0, -1 );


	//Above
	b3d_vertex_add( _vbuff,   _x1, _y1, _z2,   _uv_l, _uv_t,   _colour, _alpha,    0,  0,  1 );
	b3d_vertex_add( _vbuff,   _x2, _y1, _z2,   _uv_r, _uv_t,   _colour, _alpha,    0,  0,  1 );
	b3d_vertex_add( _vbuff,   _x2, _y2, _z2,   _uv_r, _uv_b,   _colour, _alpha,    0,  0,  1 );

	b3d_vertex_add( _vbuff,   _x2, _y2, _z2,   _uv_r, _uv_b,   _colour, _alpha,    0,  0,  1 );
	b3d_vertex_add( _vbuff,   _x1, _y2, _z2,   _uv_l, _uv_b,   _colour, _alpha,    0,  0,  1 );
	b3d_vertex_add( _vbuff,   _x1, _y1, _z2,   _uv_l, _uv_t,   _colour, _alpha,    0,  0,  1 );


	//Down
	b3d_vertex_add( _vbuff,   _x1, _y2, _z1,   _uv_l, _uv_t,   _colour, _alpha,    0,  1,  0 );
	b3d_vertex_add( _vbuff,   _x1, _y2, _z2,   _uv_l, _uv_b,   _colour, _alpha,    0,  1,  0 );
	b3d_vertex_add( _vbuff,   _x2, _y2, _z2,   _uv_r, _uv_b,   _colour, _alpha,    0,  1,  0 );

	b3d_vertex_add( _vbuff,   _x2, _y2, _z2,   _uv_r, _uv_b,   _colour, _alpha,    0,  1,  0 );
	b3d_vertex_add( _vbuff,   _x2, _y2, _z1,   _uv_r, _uv_t,   _colour, _alpha,    0,  1,  0 );
	b3d_vertex_add( _vbuff,   _x1, _y2, _z1,   _uv_l, _uv_t,   _colour, _alpha,    0,  1,  0 );


	//Right
	b3d_vertex_add( _vbuff,   _x2, _y2, _z1,   _uv_l, _uv_t,   _colour, _alpha,    1,  0,  0 );
	b3d_vertex_add( _vbuff,   _x2, _y2, _z2,   _uv_l, _uv_b,   _colour, _alpha,    1,  0,  0 );
	b3d_vertex_add( _vbuff,   _x2, _y1, _z2,   _uv_r, _uv_b,   _colour, _alpha,    1,  0,  0 );

	b3d_vertex_add( _vbuff,   _x2, _y1, _z2,   _uv_r, _uv_b,   _colour, _alpha,    1,  0,  0 );
	b3d_vertex_add( _vbuff,   _x2, _y1, _z1,   _uv_r, _uv_t,   _colour, _alpha,    1,  0,  0 );
	b3d_vertex_add( _vbuff,   _x2, _y2, _z1,   _uv_l, _uv_t,   _colour, _alpha,    1,  0,  0 );


	//Up
	b3d_vertex_add( _vbuff,   _x2, _y1, _z1,   _uv_l, _uv_t,   _colour, _alpha,    0, -1,  0 );
	b3d_vertex_add( _vbuff,   _x2, _y1, _z2,   _uv_l, _uv_b,   _colour, _alpha,    0, -1,  0 );
	b3d_vertex_add( _vbuff,   _x1, _y1, _z2,   _uv_r, _uv_b,   _colour, _alpha,    0, -1,  0 );

	b3d_vertex_add( _vbuff,   _x1, _y1, _z2,   _uv_r, _uv_b,   _colour, _alpha,    0, -1,  0 );
	b3d_vertex_add( _vbuff,   _x1, _y1, _z1,   _uv_r, _uv_t,   _colour, _alpha,    0, -1,  0 );
	b3d_vertex_add( _vbuff,   _x2, _y1, _z1,   _uv_l, _uv_t,   _colour, _alpha,    0, -1,  0 );


	//Left
	b3d_vertex_add( _vbuff,   _x1, _y1, _z1,   _uv_l, _uv_t,   _colour, _alpha,   -1,  0,  0 );
	b3d_vertex_add( _vbuff,   _x1, _y1, _z2,   _uv_l, _uv_b,   _colour, _alpha,   -1,  0,  0 );
	b3d_vertex_add( _vbuff,   _x1, _y2, _z2,   _uv_r, _uv_b,   _colour, _alpha,   -1,  0,  0 );

	b3d_vertex_add( _vbuff,   _x1, _y2, _z2,   _uv_r, _uv_b,   _colour, _alpha,   -1,  0,  0 );
	b3d_vertex_add( _vbuff,   _x1, _y2, _z1,   _uv_r, _uv_t,   _colour, _alpha,   -1,  0,  0 );
	b3d_vertex_add( _vbuff,   _x1, _y1, _z1,   _uv_l, _uv_t,   _colour, _alpha,   -1,  0,  0 );



	vertex_end( _vbuff );
	vertex_freeze( _vbuff );
	return _vbuff;


}
