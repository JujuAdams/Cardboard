/// @param point{vec3}
/// @param lineOrigin{vec3}
/// @param lineDirection{vec3}
function b3d_closest_point_on_ray(argument0, argument1, argument2) {

    var _point          = argument0;
    var _line_origin    = argument1;
    var _line_direction = argument2;

    _line_direction = vec3_normalise( _line_direction );

    var _t = clamp( vec3_dot( vec3_subtract( _point, _line_origin ), _line_direction ), 0, 1 );
    return vec3_extend( _line_origin, _line_direction, _t );


}
