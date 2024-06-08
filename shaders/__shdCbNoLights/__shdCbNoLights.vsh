attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying float v_fViewZ;
varying vec4  v_vColour;
varying vec2  v_vTexcoord;

void main()
{
    vec4 worldPos = gm_Matrices[MATRIX_WORLD]*vec4(in_Position, 1.0);
    vec4 viewPos  = gm_Matrices[MATRIX_VIEW]*worldPos;
    gl_Position = gm_Matrices[MATRIX_PROJECTION]*viewPos;
    
    v_fViewZ    = viewPos.z;
    v_vColour   = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
