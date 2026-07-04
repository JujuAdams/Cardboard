precision highp float;

#define LIGHT_COUNT  6

varying vec2 v_vTexcoord;

uniform sampler2D u_sDepth;
uniform mat4      u_mCameraInverse;
uniform vec4      u_vPosRadArray[LIGHT_COUNT];
uniform vec3      u_vColorArray[LIGHT_COUNT];

float AccumulateUnshadowedLight(vec3 position, vec3 normal, vec3 lightVector, float radius)
{
    if (radius > 0.0)
    {
        //Point light
        vec3 lightDir = lightVector - position;
        return max(dot(normal, normalize(lightDir)), 0.0) * max(0.0, 1.0 - (length(lightDir) / radius));
    }
    else
    {
        //Directional light
        return max(dot(normal, -normalize(lightVector)), 0.0);
    }
}

vec3 AccumulateUnshadowedLights(vec3 position, vec3 normal)
{
    vec3 lightFinal = vec3(0.0);
    
    for(int i = 0; i < LIGHT_COUNT; i++)
    {
        lightFinal += u_vColorArray[i]*AccumulateUnshadowedLight(position, normal, u_vPosRadArray[i].xyz, u_vPosRadArray[i].w);
    }
    
    return lightFinal;
}

void main()
{
    //Unpack the normal
    vec3 normal = floor(texture2D(gm_BaseTexture, v_vTexcoord).rgb/2.0) / 31.0;
    normal = 2.0*normal - 1.0;
    
    //Unpack the texture coordinates and the sampled depth into a normalized device space coordinate
    #if defined(_YY_HLSL11_) || defined(_YY_PSSL_)
        vec4 nsCoord = vec4(2.0*v_vTexcoord.x - 1.0,
                            1.0 - 2.0*v_vTexcoord.y,
                            texture2D(u_sDepth, v_vTexcoord).r, 
                            1.0);
    #else
        vec4 nsCoord = vec4(2.0*v_vTexcoord - 1.0,
                            2.0*texture2D(u_sDepth, v_vTexcoord).r - 1.0, 
                            1.0);
    #endif
    
    //Work backwards from the NDSpace coordinate to world space
    vec4 position = u_mCameraInverse*nsCoord;
    
    gl_FragColor = vec4(AccumulateUnshadowedLights(position.xyz / position.w, normal), 1.0);
}
