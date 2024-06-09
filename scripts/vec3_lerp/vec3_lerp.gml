/// @param a{vec3}
/// @param b{vec3}
/// @param t
function vec3_lerp(argument0, argument1, argument2) {

    return [ lerp( argument0[0], argument1[0], argument2 ),
             lerp( argument0[1], argument1[1], argument2 ),
             lerp( argument0[2], argument1[2], argument2 ) ];


}
