/// @param vec3
/// @param min
/// @param max
function vec3_clamp(argument0, argument1, argument2) {

	return [ clamp( argument0[0], argument1, argument2 ),
	         clamp( argument0[1], argument1, argument2 ),
	         clamp( argument0[2], argument1, argument2 ) ];


}
