/// @param vector{vec2}
/// @param normal{vec2}
function vec2_reflect(argument0, argument1) {

	return vec2_subtract( argument0, vec2_scale( argument1, 2*vec2_dot( argument0, argument1 ) ) );


}
