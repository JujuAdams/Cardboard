varying vec3 v_vPosition;

vec3 depthToRGB(float depth)
{
    return vec3(floor(depth*255.0) / 255.0,
	            fract(depth*255.0),
				fract(depth*255.0*255.0));
}

void main()
{
    gl_FragColor = vec4(depthToRGB(v_vPosition.z), 1.0);
}
