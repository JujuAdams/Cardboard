varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform float u_fAlphaTestRef;

void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > gl_FragColor.a) discard;
    
    float light = max(dot(v_vNormal, -normalize(vec3(-0.2, -0.4, -0.6))), 0.0);
    gl_FragColor.rgb *= 0.5 + 0.5*light;
}
