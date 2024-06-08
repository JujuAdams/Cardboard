varying float v_fViewZ;
varying vec4  v_vColour;
varying vec2  v_vTexcoord;

uniform float u_fAlphaTestRef;

uniform vec2 u_vFogParams;
uniform vec3 u_vFogColor;

vec3 ApplyFog(vec3 color, float viewZ, vec3 fogColor, vec2 fogParams)
{
    return mix(color, fogColor, clamp((viewZ - fogParams.x) / (fogParams.y - fogParams.x), 0.0, 1.0));
}

void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > gl_FragColor.a) discard;
    
    gl_FragColor.rgb = ApplyFog(gl_FragColor.rgb, v_fViewZ, u_vFogColor, u_vFogParams);
}
