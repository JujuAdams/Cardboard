attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;
varying vec4 v_vLightPos0;
varying vec4 v_vLightPos1;

uniform mat4 u_mLightViewProj0;
uniform mat4 u_mLightViewProj1;

void main()
{
    vec4 worldPos = gm_Matrices[MATRIX_WORLD]*vec4(in_Position, 1.0);
    
    gl_Position = gm_Matrices[MATRIX_PROJECTION]*gm_Matrices[MATRIX_VIEW]*worldPos;
    
    v_vPosition  = worldPos.xyz;
    v_vNormal    = in_Normal;
    v_vColour    = in_Colour;
    v_vTexcoord  = in_TextureCoord;
    v_vLightPos0 = u_mLightViewProj0*worldPos;
    v_vLightPos1 = u_mLightViewProj1*worldPos;
}
