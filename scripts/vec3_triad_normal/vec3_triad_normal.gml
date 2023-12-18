/// @param vertex0
/// @param vertex1
/// @param vertex2
/// @param flip
function vec3_triad_normal(argument0, argument1, argument2, argument3) {

	var _vertex0 = argument0;
	var _vertex1 = argument1;
	var _vertex2 = argument2;
	var _flip    = argument3;

	if ( _flip )
	{  
	    return vec3_cross_normalised( vec3_subtract( _vertex2, _vertex1 ),
	                                  vec3_subtract( _vertex0, _vertex1 ) );
	}
	else
	{
	    return vec3_cross_normalised( vec3_subtract( _vertex0, _vertex1 ),
	                                  vec3_subtract( _vertex2, _vertex1 ) );
	}


}
