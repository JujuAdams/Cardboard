/// @param position{vec3}
/// @param radius
/// @param texture
function b3d_draw_sphere(argument0, argument1, argument2) {

	if ( argument1 == 0 ) return false;

	matrix_chain_begin();
	matrix_chain_scale_xyz( argument1 );
	matrix_chain_translate( argument0[0], argument0[1], argument0[2] );
	matrix_chain_push();
	b3d_submit_sphere( argument2 );
	matrix_chain_pop();

	return true;


}
