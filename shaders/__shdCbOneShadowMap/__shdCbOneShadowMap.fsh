precision highp float;

#define LIGHT_COUNT  6

varying vec3  v_vWorldPos;
varying float v_fViewZ;
varying vec3  v_vNormal;
varying vec4  v_vColour;
varying vec2  v_vTexcoord;

uniform float u_fAlphaTestRef;

uniform vec3  u_vAmbient;
uniform vec4  u_vPosRadArray[LIGHT_COUNT];
uniform vec3  u_vColorArray[LIGHT_COUNT];

uniform sampler2D u_sLightDepth;
uniform vec4      u_vLightPos;
uniform vec3      u_vLightColor;
uniform mat4      u_mLightViewProj;
uniform vec3      u_vShadowMapBias;

uniform vec2 u_vFogParams;
uniform vec3 u_vFogColor;

vec3 ApplyFog(vec3 color, float viewZ, vec3 fogColor, vec2 fogParams)
{
    return mix(color, fogColor, clamp((viewZ - fogParams.x) / (fogParams.y - fogParams.x), 0.0, 1.0));
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
    vec3 lightFinal = vec3(0.0);
    
    for(int i = 0; i < LIGHT_COUNT; i++)
    {
        lightFinal += u_vColorArray[i]*AccumulateUnshadowedLight(position, normal, u_vPosRadArray[i].xyz, u_vPosRadArray[i].w);
    }
    
    return lightFinal;
}

vec3 AccumulateShadowedLight(vec3 position, vec3 normal, mat4 lightMatrix, sampler2D lightDepthTexture, vec3 lightPosition, float radius, vec3 lightColor)
{
    vec4  lightSpacePos = lightMatrix*vec4(position, 1.0);
    vec2  texCoord      = 0.5 + 0.5*vec2(lightSpacePos.x, -lightSpacePos.y) / lightSpacePos.w;
    float calcDepth     = lightSpacePos.z / lightSpacePos.w;
    
    float foundDepth = texture2D(lightDepthTexture, texCoord).r;
    
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
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > gl_FragColor.a) discard;
    
    gl_FragColor.rgb *= u_vAmbient
                      + AccumulateUnshadowedLights(v_vWorldPos, v_vNormal)
                      + AccumulateShadowedLight(v_vWorldPos, v_vNormal, u_mLightViewProj, u_sLightDepth, u_vLightPos.xyz, u_vLightPos.w, u_vLightColor);
    
    gl_FragColor.rgb = ApplyFog(gl_FragColor.rgb, v_fViewZ, u_vFogColor, u_vFogParams);
}