/// @param vertexBuffer
/// @param vertex0{vec3}
/// @param vertex1{vec3}
/// @param vertex2{vec3}
/// @param u
/// @param v
/// @param colour
/// @param alpha
/// @param normal{vec3}
function b3d_vertex_add_triangle(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8) {

    b3d_vertex_add( argument0,   argument1[0], argument1[1], argument1[2],   argument4, argument5,   argument6, argument7,   argument8[0], argument8[1], argument8[2] );
    b3d_vertex_add( argument0,   argument2[0], argument2[1], argument2[2],   argument4, argument5,   argument6, argument7,   argument8[0], argument8[1], argument8[2] );
    b3d_vertex_add( argument0,   argument3[0], argument3[1], argument3[2],   argument4, argument5,   argument6, argument7,   argument8[0], argument8[1], argument8[2] );


}
