varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform float u_fAlphaTestRef;
uniform vec2  u_vZ;

vec3 DepthToRGB(float depth)
{
    return fract(floor(255.0*depth*vec3(1.0, 255.0, 65025.0)) / 255.0);
}

void main()
{
    gl_FragColor[0] = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > (gl_FragColor[0]).a) discard;
    gl_FragColor[1] = vec4(DepthToRGB(v_vPosition.z / v_vPosition.w), 1.0);
    gl_FragColor[2] = vec4(0.5 + 0.5*v_vNormal, 1.0);
}s