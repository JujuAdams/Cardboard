varying vec2 v_vTexcoord;
varying vec4 v_vWorldPos;

uniform float u_fAlphaTestRef;

vec3 DepthToRGB(float depth)
{
    return fract(floor(255.0*depth*vec3(1.0, 255.0, 65025.0)) / 255.0);
}

void main()
{
    if (u_fAlphaTestRef > texture2D(gm_BaseTexture, v_vTexcoord).a) discard;
    gl_FragColor = vec4(DepthToRGB(v_vWorldPos.z / v_vWorldPos.w), 1.0);
}