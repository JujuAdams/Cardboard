/// @param from{vec3}
/// @param to{vec3}
/// @param up{vec3}
function vec3_matrix_build_lookat(argument0, argument1, argument2) {

    return matrix_build_lookat( argument0[0], argument0[1], argument0[2],
                                argument1[0], argument1[1], argument1[2],
                                argument2[0], argument2[1], argument2[2] );


}
