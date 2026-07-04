precision highp float;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_sLighting;

void main()
{
    vec4 sample = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor.rgb = sample.rgb - 2.0*floor(sample.rgb/2.0);
    gl_FragColor.rgb *= texture2D(u_sLighting, v_vTexcoord).rgb;
    gl_FragColor.a = 1.0;
}
