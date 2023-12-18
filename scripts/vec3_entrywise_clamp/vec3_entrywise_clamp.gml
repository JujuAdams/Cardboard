/// @param value{vec3}
/// @param min{vec3}
/// @param max{vec3}
function vec3_entrywise_clamp(argument0, argument1, argument2) {

	return [ clamp( argument0[0], argument1[0], argument2[0] ),
	         clamp( argument0[1], argument1[1], argument2[1] ),
	         clamp( argument0[2], argument1[2], argument2[2] ) ];


}
