/// @param vector
function vec3_minor_axes(argument0) {

    var _x = abs( argument0[0] );
    var _y = abs( argument0[1] );
    var _z = abs( argument0[2] );

    if ( _x >= _y ) && ( _x >= _z ) {
        return [ 0, _y, _z ];
    } else if ( _y >= _x ) && ( _y >= _z ) {
        return [ _x, 0, _z ];
    }
    return [ _x, _y, 0 ];


}
