precision highp float;

attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

void main()
{
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*vec4(in_Position, 1.0);
    
    v_vNormal   = 0.5 + 0.5*normalize((gm_Matrices[MATRIX_WORLD]*vec4(in_Normal, 0.0)).xyz);
    v_vColour   = in_Colour;
    v_vTexcoord = in_TextureCoord;
}