attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour0;
attribute vec2 in_TextureCoord;
attribute vec4 in_Colour1;

varying vec2 v_vTexcoord;
varying vec4 v_vColour0; //We have use this extra varying otherwise the compiler over-optimises
varying vec3 v_vColour1;

void main()
{
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*vec4(in_Position.xyz, 1.0);
    
    v_vTexcoord = in_TextureCoord;
    v_vColour0  = in_Colour0;
    v_vColour1  = in_Colour1.rgb;
}