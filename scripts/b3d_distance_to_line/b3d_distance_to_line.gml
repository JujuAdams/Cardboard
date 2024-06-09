/// @param point{vec3}
/// @param lineOrigin{vec3}
/// @param lineDirection{vec3}
function b3d_distance_to_line(argument0, argument1, argument2) {

    return vec3_distance( argument0, b3d_closest_point_on_line( argument0, argument1, argument2 ) );


}
