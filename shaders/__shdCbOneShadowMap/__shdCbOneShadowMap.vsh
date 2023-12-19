precision highp float;

attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec3  v_vWorldPos;
varying float v_fViewZ;
varying vec3  v_vNormal;
varying vec4  v_vColour;
varying vec2  v_vTexcoord;

void main()
{
    vec4 worldPos = gm_Matrices[MATRIX_WORLD]*vec4(in_Position, 1.0);
    vec4 viewPos  = gm_Matrices[MATRIX_VIEW]*worldPos;
    gl_Position = gm_Matrices[MATRIX_PROJECTION]*viewPos;
    
    v_vWorldPos  = worldPos.xyz;
    v_fViewZ     = viewPos.z;
    v_vNormal    = in_Normal;
    v_vColour    = in_Colour;
    v_vTexcoord  = in_TextureCoord;
}