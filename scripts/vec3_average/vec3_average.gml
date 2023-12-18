/// @param vec3
/// @param [vec3...]
function vec3_average() {

	var _result = argument[0];
	for( var _i = 1; _i < argument_count; _i++ ) _result = vec3_add( _result, argument[_i] );
	return vec3_scale( _result, 1/argument_count );


}
