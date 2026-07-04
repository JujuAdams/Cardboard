precision highp float;

varying vec2 v_vTexcoord;

uniform sampler2D u_sDepth;
uniform mat4      u_mCameraInverse;

uniform sampler2D u_sLightDepth;
uniform vec4      u_vLightPos;
uniform vec3      u_vLightColor;
uniform mat4      u_mLightViewProj;
uniform vec3      u_vShadowMapBias;

vec3 AccumulateShadowedLight(vec3 position, vec3 normal, mat4 lightMatrix, sampler2D lightDepthTexture, vec3 lightPosition, float radius, vec3 lightColor)
{
    vec4 lightSpacePos = lightMatrix*vec4(position, 1.0);
    
    #if defined(_YY_HLSL11_) || defined(_YY_PSSL_)
        vec2 texCoord = 0.5 + 0.5*vec2(lightSpacePos.x, -lightSpacePos.y) / lightSpacePos.w;
    #else
        vec2 texCoord = 0.5 + 0.5*lightSpacePos.xy / lightSpacePos.w;
    #endif
    
    float foundDepth = texture2D(lightDepthTexture, texCoord).r;
    
    #if !defined(_YY_HLSL11_) && !defined(_YY_PSSL_)
        foundDepth = 2.0*foundDepth - 1.0;
    #endif
    
    float calcDepth = lightSpacePos.z / lightSpacePos.w;
    
    //Choose the lighting vector
    vec3 dir;
    if (radius > 0.0)
    {
        dir = lightPosition - position;
    }
    else
    {
        dir = lightPosition;
    }
    
    //Adjust for normals
    float dotProduct = max(dot(normalize(normal), normalize(dir)), 0.0);
    
    //Perform the depth comparison
    float depthBias = clamp(u_vShadowMapBias.z*dotProduct, u_vShadowMapBias.x, u_vShadowMapBias.y);
    float factor = step(max(0.0, calcDepth), foundDepth + depthBias);
    
    //Adjust for normals
    factor *= dotProduct;
    
    //Clip the limits of the surface
    factor *= step(0.0, texCoord.x);
    factor *= step(texCoord.x, 1.0);
    factor *= step(0.0, texCoord.y);
    factor *= step(texCoord.y, 1.0);
    
    if (radius > 0.0)
    {
        //Adjust for distance from the light source
        factor *= max(0.0, 1.0 - (length(dir) / radius));
        
        //FIXME - Placeholder circular light
        factor *= step(2.0*length(texCoord.xy - 0.5), 1.0);
    }
    
    return factor*lightColor;
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
        vec4 nsCoord = vec4(2.0*v_vTexcoord.x - 1.0,
                            1.0 - 2.0*v_vTexcoord.y,
                            2.0*texture2D(u_sDepth, v_vTexcoord).r - 1.0, 
                            1.0);
    #endif
    
    //Work backwards from the NDSpace coordinate to world space
    vec4 position = u_mCameraInverse*nsCoord;
    
    gl_FragColor = vec4(AccumulateShadowedLight(position.xyz / position.w, normal, u_mLightViewProj, u_sLightDepth, u_vLightPos.xyz, u_vLightPos.w, u_vLightColor), 1.0);
}