/// @param pitch
/// @param yaw
function vec3_pitch_yaw(argument0, argument1) {

    return [  dcos(argument0)*dcos(argument1),
             -dcos(argument0)*dsin(argument1),
             -dsin(argument0) ];


}
