varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform float u_fAlphaTestRef;
uniform vec4  u_vPositionRadius;
uniform vec3  u_vColor;

void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > gl_FragColor.a) discard;
    
    vec3 lightDir = u_vPositionRadius.xyz - v_vPosition;
    
    float light = max(dot(normalize(v_vNormal), normalize(lightDir)), 0.0);
    light *= max(0.0, 1.0 - (length(lightDir) / u_vPositionRadius.w));
    
    gl_FragColor.rgb *= u_vColor*light;
}
