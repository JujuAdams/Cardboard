/// @param a{vec2}
/// @param b{vec2}
/// @param t
function vec2_lerp(argument0, argument1, argument2) {

    return [ lerp( argument0[0], argument1[0], argument2 ),
             lerp( argument0[1], argument1[1], argument2 ) ];


}
