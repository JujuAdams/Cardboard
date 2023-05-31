varying vec2 v_vTexcoord;
varying vec4 v_vColour;

float RGBToDepth(vec3 color)
{
	color /= vec3(1.0, 255.0, 255.0*255.0);
    return color.r + color.g + color.b;
}

void main()
{
    vec4  sample = texture2D(gm_BaseTexture, v_vTexcoord);
    float depth  = 1.0 - RGBToDepth(texture2D(gm_BaseTexture, v_vTexcoord).rgb);
    
    gl_FragColor = vec4(depth, depth, depth, 1.0);
}
