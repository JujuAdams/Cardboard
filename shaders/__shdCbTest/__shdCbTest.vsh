attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;
varying vec4 v_vLightPos;

uniform mat4 u_mLightViewProj;

void main()
{
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*vec4(in_Position, 1.0);
    
    v_vPosition = (gm_Matrices[MATRIX_WORLD]*vec4(in_Position, 1.0)).xyz;
    v_vNormal   = in_Normal;
    v_vColour   = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vLightPos = u_mLightViewProj*gm_Matrices[MATRIX_WORLD]*vec4(in_Position, 1.0);
}