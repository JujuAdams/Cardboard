varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_fLinearize;
uniform float u_fZNear;
uniform float u_fZFar;

float LinearizeDepth(float depth, float znear, float zfar)
{
    return (2.0 * znear) / (zfar + znear - depth * (zfar - znear));
}

void main()
{
    float linearDepth = texture2D(gm_BaseTexture, v_vTexcoord).r;
    linearDepth = mix(linearDepth, LinearizeDepth(linearDepth, u_fZNear, u_fZFar), u_fLinearize);
    gl_FragColor = v_vColour * vec4(linearDepth, linearDepth, linearDepth, 1.0);
}