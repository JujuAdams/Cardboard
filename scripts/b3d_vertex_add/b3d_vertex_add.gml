/// @param vertexBuffer
/// @param x
/// @param y
/// @param z
/// @param u
/// @param v
/// @param colour
/// @param alpha
/// @param normalX
/// @param normalY
/// @param normalZ
function b3d_vertex_add(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10) {

    vertex_position_3d( argument0, argument1, argument2, argument3  );
    vertex_texcoord(    argument0, argument4, argument5             );
    vertex_colour(      argument0, argument6, argument7             );
    vertex_normal(      argument0, argument8, argument9, argument10 );


}
