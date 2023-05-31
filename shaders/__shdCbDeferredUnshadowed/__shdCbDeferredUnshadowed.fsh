#define LIGHT_COUNT  6

varying vec2 v_vTexcoord;

uniform vec2      u_vZ;
uniform sampler2D u_sDepth;
uniform sampler2D u_sNormal;
uniform mat4      u_mCameraInverse;

uniform vec4      u_vPosRadArray[LIGHT_COUNT];
uniform vec3      u_vColorArray[LIGHT_COUNT];

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

vec3 AccumulateUnshadowedLights(vec3 position, vec3 normal)
{
    vec3 lightFinal;
    
    for(int i = 0; i < LIGHT_COUNT; i++)
    {
        lightFinal += u_vColorArray[i]*AccumulateUnshadowedLight(position, normal, u_vPosRadArray[i].xyz, u_vPosRadArray[i].w);
    }
    
    return lightFinal;
}

void main()
{
    //Unpack the normal
    vec3 normal = 2.0*texture2D(u_sNormal, v_vTexcoord).rgb - 1.0;
    
    //Unpack the texture coordinates and the sampled depth into a normalized device space coordinate
    vec4 nsCoord = vec4(2.0*v_vTexcoord.x - 1.0,
                        1.0 - 2.0*v_vTexcoord.y,
                        RGBToDepth(texture2D(u_sDepth, v_vTexcoord).rgb), 
                        1.0);
    
    //Work backwards from the NDSpace coordinate to world space
    vec3 position = (u_mCameraInverse*nsCoord).xyz;
    
    gl_FragColor = vec4(AccumulateUnshadowedLights(position, normal), 1.0);
}
