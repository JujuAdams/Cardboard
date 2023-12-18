/// @param texture
/// @param [primitive]
function b3d_submit_sphere() {

	var _primitive = (argument_count > 1)? argument[1] : global.b3d_primitive;

	vertex_submit( global.b3d_sphere, _primitive, b3d_check_texture( argument[0] ) );


}
