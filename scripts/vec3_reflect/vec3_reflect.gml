/// @param vector{vec3}
/// @param normal{vec3}
function vec3_reflect(argument0, argument1) {

    return vec3_subtract( argument0, vec3_scale( argument1, 2*vec3_dot( argument0, argument1 ) ) );


}
