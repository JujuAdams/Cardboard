precision highp float;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
      
void main()
{
    gl_FragColor.rgb = floor(texture2D(gm_BaseTexture, v_vTexcoord).rgb/2.0) / 255.0;
    gl_FragColor.a = 1.0;
    gl_FragColor *= v_vColour;
}