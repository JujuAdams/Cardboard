precision highp float;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec4 unpackFloat(float value)
{
    value *= (256.0*256.0*256.0 - 1.0) / (256.0*256.0*256.0);
    vec4 encode = fract( value * vec4(1.0, 256.0, 256.0*256.0, 256.0*256.0*256.0) );
    return vec4( encode.xyz - encode.yzw / 256.0, encode.w ) + 1.0/512.0;
}
        
void main()
{
    gl_FragColor = v_vColour*unpackFloat(texture2D(gm_BaseTexture, v_vTexcoord).r);
    gl_FragColor.a = 1.0;
}