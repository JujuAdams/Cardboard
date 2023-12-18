/// @param vec2
function vec2_minor_axis(argument0) {

	var _x = abs( argument0[0] );
	var _y = abs( argument0[1] );

	if ( _x < _y ) return [ _x, 0 ];
	               return [ 0, _y ];


}
