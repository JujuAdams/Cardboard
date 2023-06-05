varying vec3 v_vWorldPos;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform float u_fAlphaTestRef;

uniform vec2 u_vFogParams;
uniform vec3 u_vFogColor;

vec3 ApplyFog(vec3 color, float viewZ, vec3 fogColor, vec2 fogParams)
{
    return mix(color, fogColor, clamp((viewZ - fogParams.x) / (fogParams.y - fogParams.x), 0.0, 1.0));
}

vec3 DepthToRGB(float depth)
{
    return fract(floor(255.0*depth*vec3(1.0, 255.0, 65025.0)) / 255.0);
}

void main()
{
    gl_FragColor[0] = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > (gl_FragColor[0]).a) discard;
    gl_FragColor[1] = vec4(DepthToRGB(v_vWorldPos.z / v_vWorldPos.w), 1.0);
    gl_FragColor[2] = vec4(0.5 + 0.5*v_vNormal, 1.0);
    
    gl_FragColor.rgb = ApplyFog(gl_FragColor.rgb, v_fViewZ, u_vFogColor, u_vFogParams);
}s