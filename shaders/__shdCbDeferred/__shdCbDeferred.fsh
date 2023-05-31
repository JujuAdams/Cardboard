varying vec2 v_vTexcoord;

uniform vec2      u_vZ;
uniform sampler2D u_sDepth;
uniform sampler2D u_sNormal;
uniform mat4      u_mInverse;

float RGBToDepth(vec3 color)
{
	color /= vec3(1.0, 255.0, 255.0*255.0);
    return u_vZ.x + (u_vZ.y - u_vZ.x)*(color.r + color.g + color.b);
}

float AccumulateUnshadowedLight(vec3 position, vec3 normal, vec3 lightVector, float radius)
{
    if (radius > 0.0)
    {
        //Point light
        vec3 lightDir = lightVector - position;
        return max(dot(normalize(normal), normalize(lightDir)), 0.0) * max(0.0, 1.0 - (length(lightDir) / radius));
    }
    else
    {
        //Directional light
        return max(dot(normalize(normal), -normalize(lightVector)), 0.0);
    }
}

void main()
{
    //Unpack the normal
    vec3 normal = 2.0*texture2D(u_sNormal, v_vTexcoord).rgb - 1.0;
    
    //Unpack the texture coordinates and the sampled depth into a normalized device space coordinate
    vec4 nsCoord = vec4(2.0*vec2(v_vTexcoord.x, -v_vTexcoord.y) - 1.0,
                        RGBToDepth(texture2D(u_sDepth, v_vTexcoord).rgb), 
                        1.0);
    
    //Work backwards from the NDSpace coordinate to world space
    vec3 position = (u_mInverse*nsCoord).xyz;
    
    vec3 lightFinal = vec3(0.0);
    lightFinal += vec3(0.5, 0.5, 0.5)*AccumulateUnshadowedLight(position, normal, vec3(   1.0,    1.0,  -2.0),    0.0);
    lightFinal += vec3(1.0, 1.0, 1.0)*AccumulateUnshadowedLight(position, normal, vec3(-320.0,    0.0, 100.0), 2200.0);
    lightFinal += vec3(1.0, 1.0, 1.0)*AccumulateUnshadowedLight(position, normal, vec3( 240.0,  400.0, 300.0), 2200.0);
    lightFinal += vec3(1.0, 0.0, 0.0)*AccumulateUnshadowedLight(position, normal, vec3(   0.0, -400.0, 300.0), 2000.0);
    
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor.rgb *= lightFinal;
}
