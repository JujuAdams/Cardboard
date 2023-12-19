precision highp float;

varying vec2 v_vTexcoord;

uniform sampler2D u_sDepth;
uniform sampler2D u_sNormal;
uniform mat4      u_mCameraInverse;

uniform sampler2D u_sLightDepth;
uniform vec4      u_vLightPos;
uniform vec3      u_vLightColor;
uniform mat4      u_mLightViewProj;
uniform vec3      u_vShadowMapBias;

float RGBToDepth(vec3 color)
{
	color /= vec3(1.0, 255.0, 255.0*255.0);
    return color.r + color.g + color.b;
}

vec3 AccumulateShadowedLight(vec3 position, vec3 normal, mat4 lightMatrix, sampler2D lightDepthTexture, vec3 lightPosition, float radius, vec3 lightColor)
{
    vec4  lightSpacePos = lightMatrix*vec4(position, 1.0);
    vec2  texCoord      = 0.5 + 0.5*vec2(lightSpacePos.x, -lightSpacePos.y) / lightSpacePos.w;
    float calcDepth     = lightSpacePos.z / lightSpacePos.w;
    
    float foundDepth = RGBToDepth(texture2D(lightDepthTexture, texCoord).rgb);
    vec3  dir        = lightPosition - position;
    
    //Adjust for normals
    float dotProduct = max(dot(normalize(normal), normalize(dir)), 0.0);
    
    //Perform the depth comparison
    float depthBias = clamp(u_vShadowMapBias.z*dotProduct, u_vShadowMapBias.x, u_vShadowMapBias.y);
    float factor = step(max(0.0, calcDepth), foundDepth + depthBias);
    
    //Adjust for normals
    factor *= dotProduct;
    
    //Adjust for distance from the light source
    factor *= max(0.0, 1.0 - (length(dir) / radius));
    
    //Clip the limits of the surface
    factor *= step(0.0, texCoord.x);
    factor *= step(texCoord.x, 1.0);
    factor *= step(0.0, texCoord.y);
    factor *= step(texCoord.y, 1.0);
    
    //FIXME - Placeholder circular light
    factor *= step(2.0*length(texCoord.xy - 0.5), 1.0);
    
    return factor*lightColor;
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
    
    gl_FragColor = vec4(AccumulateShadowedLight(position, normal, u_mLightViewProj, u_sLightDepth, u_vLightPos.xyz, u_vLightPos.w, u_vLightColor), 1.0);
}