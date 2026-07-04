precision highp float;

varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

float packIntoFloat(vec4 pack)
{
    float value = dot( pack, 1.0 / vec4(1.0, 256.0, 256.0*256.0, 256.0*256.0*256.0) );
    return value * (256.0*256.0*256.0) / (256.0*256.0*256.0 - 1.0);
}

void main()
{
    vec4 diffuse = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (gm_AlphaRefValue >= diffuse.a) discard;
    
    gl_FragColor.r = packIntoFloat(vec4(diffuse.rgb, 0.0));
    gl_FragColor.g = packIntoFloat(vec4(0.5 + 0.5*normalize(v_vNormal), 0.0));
    gl_FragColor.b = 0.0;
    gl_FragColor.a = 1.0;
}