varying vec2 v_vTexcoord;
varying vec4 v_vPosition;

uniform float u_fAlphaTestRef;
uniform vec2  u_vZ;

vec3 DepthToRGB(float depth)
{
    depth = (depth - u_vZ.x) / (u_vZ.y - u_vZ.x);
    return fract(floor(255.0*depth*vec3(1.0, 255.0, 65025.0)) / 255.0);
}

void main()
{
    if (u_fAlphaTestRef > texture2D(gm_BaseTexture, v_vTexcoord).a) discard;
    gl_FragColor = vec4(DepthToRGB(v_vPosition.z), 1.0);
}