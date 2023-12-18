/// @param vec2
/// @param [vec2...]
function vec2_average() {

	var _result = argument[0];
	for( var _i = 1; _i < argument_count; _i++ ) _result = vec2_add( _result, argument[_i] );
	return vec2_scale( _result, 1/argument_count );


}
