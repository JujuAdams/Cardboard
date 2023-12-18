/// @param a{vec3}
/// @param b{vec3}
/// @param thickness
/// @param texture
function b3d_draw_line_ab(argument0, argument1, argument2, argument3) {

	var _pos0      = argument0;
	var _pos1      = argument1;
	var _thickness = argument2;
	var _texture   = argument3;

	b3d_draw_line( vec3_distance( _pos0, _pos1 ), _thickness, _pos0, vec3_normalise( vec3_subtract( _pos1, _pos0 ) ), _texture );


}
