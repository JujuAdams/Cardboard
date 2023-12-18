/// @param vertexBuffer
/// @param vertexA{vec3}
/// @param vertexB{vec3}
/// @param vertexC{vec3}
/// @param uvA{vec2}
/// @param uvD{vec2}
/// @param colour
/// @param alpha
/// @param normal
function b3d_vertex_add_quad(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9) {

	var _vbuff  = argument0;
	var _vec_a  = argument1;
	var _vec_b  = argument2;
	var _vec_c  = argument3;
	var _vec_d  = argument4;
	var _uv_a   = argument5;
	var _uv_d   = argument6;
	var _colour = argument7;
	var _alpha  = argument8;
	var _normal = argument9;

	var _vec_d = [ _vec_c[0] + _vec_b[0] - _vec_a[0],
	               _vec_c[1] + _vec_b[1] - _vec_a[1],
	               _vec_c[2] + _vec_b[2] - _vec_a[2] ];

	b3d_vertex_add( _vbuff,    _vec_a[0], _vec_a[1], _vec_a[2],    _uv_a[0], _uv_a[1],    _colour, _alpha,    _normal[0], _normal[1], _normal[2] ); // A top-left
	b3d_vertex_add( _vbuff,    _vec_b[0], _vec_b[1], _vec_b[2],    _uv_d[0], _uv_a[1],    _colour, _alpha,    _normal[0], _normal[1], _normal[2] ); // B top-right
	b3d_vertex_add( _vbuff,    _vec_c[0], _vec_c[1], _vec_c[2],    _uv_a[0], _uv_d[1],    _colour, _alpha,    _normal[0], _normal[1], _normal[2] ); // C bottom-left

	b3d_vertex_add( _vbuff,    _vec_b[0], _vec_b[1], _vec_b[2],    _uv_d[0], _uv_a[1],    _colour, _alpha,    _normal[0], _normal[1], _normal[2] ); // B top-right
	b3d_vertex_add( _vbuff,    _vec_d[0], _vec_d[1], _vec_d[2],    _uv_d[0], _uv_d[1],    _colour, _alpha,    _normal[0], _normal[1], _normal[2] ); // D bottom-right
	b3d_vertex_add( _vbuff,    _vec_c[0], _vec_c[1], _vec_c[2],    _uv_a[0], _uv_d[1],    _colour, _alpha,    _normal[0], _normal[1], _normal[2] ); // C bottom-left


}
