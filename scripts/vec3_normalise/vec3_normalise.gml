/// @param vec3
function vec3_normalise(argument0) {

	var _length = argument0[0]*argument0[0] +
	              argument0[1]*argument0[1] +
	              argument0[2]*argument0[2];

	if ( _length == 0 ) return [ 0, 0, 0 ];
	_length = 1/sqrt( _length );

	return [ argument0[0] * _length,
	         argument0[1] * _length,
	         argument0[2] * _length ];


}
