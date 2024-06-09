/// @param position{vec3}
/// @param direction{vec3}
/// @param scale
function vec3_extend(argument0, argument1, argument2) {

    return vec3_add( argument0, vec3_scale( argument1, argument2 ) );


}
