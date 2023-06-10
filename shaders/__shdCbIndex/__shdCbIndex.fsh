varying vec2 v_vTexcoord;
varying vec4 v_vColour0;
varying vec3 v_vColour1;

uniform float u_fAlphaTestRef;
uniform vec3  u_vIndexOffset;

void main()
{
    if (u_fAlphaTestRef > texture2D(gm_BaseTexture, v_vTexcoord).a) discard;
    gl_FragColor = vec4(v_vColour1 + u_vIndexOffset, 1.0);
}