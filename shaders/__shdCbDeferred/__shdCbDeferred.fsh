varying vec2 v_vTexcoord;

uniform sampler2D u_sDepth;
uniform sampler2D u_sNormal;

void main()
{
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
}
