#define LIGHT_COUNT  6

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform vec3  u_vAmbient;
uniform float u_fAlphaTestRef;
uniform vec4  u_vPosRadArray[LIGHT_COUNT];
uniform vec3  u_vColorArray[LIGHT_COUNT];

vec3 AccumulateUnshadowedLights(vec3 position, vec3 normal)
{
    vec3 lightFinal;
    vec3 lightDir;
    float lightFactor;
    
    for(int i = 0; i < LIGHT_COUNT; i++)
    {
        if (u_vPosRadArray[i].w > 0.0)
        {
            lightDir = u_vPosRadArray[i].xyz - position;
            
            lightFactor = max(dot(normalize(normal), normalize(lightDir)), 0.0);
            lightFactor *= max(0.0, 1.0 - (length(lightDir) / u_vPosRadArray[i].w));
            
            lightFinal += u_vColorArray[i]*lightFactor;
        }
        else
        {
            lightFactor = max(dot(normalize(normal), -normalize(u_vPosRadArray[i].xyz)), 0.0);
            lightFinal += u_vColorArray[i]*lightFactor;
        }
    }
    
    return lightFinal;
}

void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > gl_FragColor.a) discard;
    
    gl_FragColor.rgb *= u_vAmbient + AccumulateUnshadowedLights(v_vPosition, v_vNormal);
}