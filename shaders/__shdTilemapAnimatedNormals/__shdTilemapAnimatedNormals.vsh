attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

uniform float u_fAnimFrame;

varying vec3 v_vNormal;
varying vec2 v_vTexcoord;

void main()
{
    vec3 wsPos = vec3(0.0);
    
    //Only show this tile if we're on this frame of animation
    if (abs(255.0*in_Colour.r - mod(u_fAnimFrame, (1.0 + 255.0*in_Colour.g))) < 0.5)
    {
        wsPos = in_Position.xyz;
    }
    
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*vec4(wsPos, 1.0);
    v_vNormal   = in_Normal;
    v_vTexcoord = in_TextureCoord;
}
