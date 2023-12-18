/// @param a
/// @param b
function vec3_cross(argument0, argument1) {

	var _a = argument0;
	var _b = argument1;

	return [ _a[2]*_b[1] - _a[1]*_b[2],
	         _a[0]*_b[2] - _a[2]*_b[0],
	         _a[1]*_b[0] - _a[0]*_b[1] ];


}
