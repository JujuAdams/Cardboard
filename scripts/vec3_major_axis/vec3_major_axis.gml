/// @param vec3
function vec3_major_axis(argument0) {

	var _x = abs( argument0[0] );
	var _y = abs( argument0[1] );
	var _z = abs( argument0[2] );

	if ( _x >= _y ) && ( _x >= _z )
	{
	    return [ argument0[0], 0, 0 ];
	}
	else if ( _y >= _x ) && ( _y >= _z )
	{
	    return [ 0, argument0[1], 0 ];
	}

	return [ 0, 0, argument0[2] ];


}
