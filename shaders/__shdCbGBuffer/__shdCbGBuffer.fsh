precision highp float;

varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

void main()
{
    vec4 diffuse = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (gm_AlphaRefValue >= diffuse.a) discard;
    
    gl_FragColor.rgb = diffuse.rgb + 2.0*floor(255.0*v_vNormal.xyz);
    gl_FragColor.a = 1.0;
}