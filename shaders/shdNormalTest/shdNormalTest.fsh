varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

void main()
{
    //gl_FragColor = vec4(0.5 + 0.5*v_vNormal, texture2D(gm_BaseTexture, v_vTexcoord).a);
    
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    
    float light = max(dot(v_vNormal, -normalize(vec3(-0.2, -0.4, -0.6))), 0.0);
    gl_FragColor.rgb *= 0.5 + 0.5*light;
}
