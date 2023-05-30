#define LIGHT_COUNT  4
#define BIAS_MAX     0.01
#define BIAS_COEFF   0.002

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;
varying vec4 v_vLightPos0;
varying vec4 v_vLightPos1;

uniform vec3      u_vAmbient;
uniform float     u_fAlphaTestRef;
uniform vec4      u_vPosRadArray[LIGHT_COUNT];
uniform vec3      u_vColorArray[LIGHT_COUNT];

uniform sampler2D u_sLightDepth0;
uniform vec4      u_vLightPos0;
uniform vec3      u_vLightColor0;
uniform vec2      u_vLightZ0;

uniform sampler2D u_sLightDepth1;
uniform vec4      u_vLightPos1;
uniform vec2      u_vLightZ1;
uniform vec3      u_vLightColor1;

float RGBToDepth(vec3 color)
{
	color /= vec3(1.0, 255.0, 255.0*255.0);
    return color.r + color.g + color.b;
}

vec3 AccumulateUnshadowedLights()
{
    vec3 lightFinal;
    vec3 lightDir;
    float lightFactor;
    
    for(int i = 0; i < LIGHT_COUNT; i++)
    {
        if (u_vPosRadArray[i].w > 0.0)
        {
            lightDir = u_vPosRadArray[i].xyz - v_vPosition;
            
            lightFactor = max(dot(normalize(v_vNormal), normalize(lightDir)), 0.0);
            lightFactor *= max(0.0, 1.0 - (length(lightDir) / u_vPosRadArray[i].w));
            
            lightFinal += u_vColorArray[i]*lightFactor;
        }
        else
        {
            lightFactor = max(dot(normalize(v_vNormal), -normalize(u_vPosRadArray[i].xyz)), 0.0);
            lightFinal += u_vColorArray[i]*lightFactor;
        }
    }
    
    return lightFinal;
}

vec3 AccumulateShadowMappedLights()
{
    vec3  final;
    vec2  texCoord;
    float calcDepth;
    vec4  depthColor;
    float foundDepth;
    vec3  dir;
    float dotProduct;
    float depthBias;
    float factor;
    
    
    
    //Light 0
    texCoord   = 0.5 + 0.5*vec2(v_vLightPos0.x, -v_vLightPos0.y) / v_vLightPos0.w;
    calcDepth  = (v_vLightPos0.z - u_vLightZ0.x) / (u_vLightZ0.y - u_vLightZ0.x);
    foundDepth = RGBToDepth(texture2D(u_sLightDepth0, texCoord).rgb);
    dir        = u_vLightPos0.xyz - v_vPosition;
    
    //Adjust for normals
    dotProduct = max(dot(normalize(v_vNormal), normalize(dir)), 0.0);
    
    //Perform the depth comparison
    depthBias = clamp(BIAS_COEFF*tan(acos(dotProduct)), 0.0, BIAS_MAX);
    factor = step(calcDepth, foundDepth + depthBias);
    
    //Adjust for normals
    //factor *= dotProduct;
    factor *= step(0.01, dotProduct);
    
    //Adjust for distance from the light source
    factor *= max(0.0, 1.0 - (length(dir) / u_vLightPos0.w));
    
    //Clip the limits of the surface
    factor *= step(0.0, texCoord.x);
    factor *= step(texCoord.x, 1.0);
    factor *= step(0.0, texCoord.y);
    factor *= step(texCoord.y, 1.0);
    
    //FIXME - Placeholder circular light
    factor *= step(2.0*length(texCoord.xy - 0.5), 1.0);
    
    final += factor*u_vLightColor0;
    
    
    
    //Light 1
    texCoord   = 0.5 + 0.5*vec2(v_vLightPos1.x, -v_vLightPos1.y) / v_vLightPos1.w;
    calcDepth  = (v_vLightPos1.z - u_vLightZ1.x) / (u_vLightZ1.y - u_vLightZ1.x);
    foundDepth = RGBToDepth(texture2D(u_sLightDepth1, texCoord).rgb);
    dir        = u_vLightPos1.xyz - v_vPosition;
    
    //Adjust for normals
    dotProduct = max(dot(normalize(v_vNormal), normalize(dir)), 0.0);
    
    //Perform the depth comparison
    depthBias = clamp(BIAS_COEFF*tan(acos(dotProduct)), 0.0, BIAS_MAX);
    factor = step(calcDepth, foundDepth + depthBias);
    
    //Adjust for normals
    //factor *= dotProduct;
    factor *= step(0.01, dotProduct);
    
    //Adjust for distance from the light source
    factor *= max(0.0, 1.0 - (length(dir) / u_vLightPos1.w));
    
    //Clip the limits of the surface
    factor *= step(0.0, texCoord.x);
    factor *= step(texCoord.x, 1.0);
    factor *= step(0.0, texCoord.y);
    factor *= step(texCoord.y, 1.0);
    
    //FIXME - Placeholder circular light
    factor *= step(2.0*length(texCoord.xy - 0.5), 1.0);
    
    final += factor*u_vLightColor1;
    
    
    
    return final;
}

void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > gl_FragColor.a) discard;
    
    vec3 lightFinal  = u_vAmbient;
         lightFinal += AccumulateUnshadowedLights();
         lightFinal += AccumulateShadowMappedLights();
    
    gl_FragColor.rgb *= lightFinal;
}