precision highp float;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_sLighting;

vec4 unpackFloat(float value)
{
    value *= (256.0*256.0*256.0 - 1.0) / (256.0*256.0*256.0);
    vec4 encode = fract( value * vec4(1.0, 256.0, 256.0*256.0, 256.0*256.0*256.0) );
    return vec4( encode.xyz - encode.yzw / 256.0, encode.w ) + 1.0/512.0;
}

void main()
{
    gl_FragColor = unpackFloat(texture2D(gm_BaseTexture, v_vTexcoord).r);
    gl_FragColor.rgb *= texture2D(u_sLighting, v_vTexcoord).rgb;
    gl_FragColor.a = 1.0;
}
