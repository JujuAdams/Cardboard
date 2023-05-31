#define LIGHT_COUNT  6

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform float u_fAlphaTestRef;

uniform vec3  u_vAmbient;
uniform vec4  u_vPosRadArray[LIGHT_COUNT];
uniform vec3  u_vColorArray[LIGHT_COUNT];

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
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > gl_FragColor.a) discard;
    
    gl_FragColor.rgb *= u_vAmbient + AccumulateUnshadowedLights(v_vPosition, v_vNormal);
}