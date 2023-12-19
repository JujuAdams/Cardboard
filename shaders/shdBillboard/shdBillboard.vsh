attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    mat4 worldView = gm_Matrices[MATRIX_WORLD_VIEW];
    worldView[0][0] = 1.0;
    worldView[1][0] = 0.0;
    worldView[2][0] = 0.0;
    
    worldView[0][1] = 0.0;
    worldView[1][1] = -1.0;
    worldView[2][1] = 0.0;
    
    worldView[0][2] = 0.0;
    worldView[1][2] = 0.0;
    worldView[2][2] = 1.0;
    
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * worldView * vec4(in_Position.xyz, 1.0);
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}