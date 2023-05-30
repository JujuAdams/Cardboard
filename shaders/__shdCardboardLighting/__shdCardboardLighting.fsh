#define LIGHT_COUNT  4

varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

uniform vec3  u_vAmbient;
uniform float u_fAlphaTestRef;
uniform vec4  u_vPosRadArray[LIGHT_COUNT];
uniform vec3  u_vColorArray[LIGHT_COUNT];

void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (u_fAlphaTestRef > gl_FragColor.a) discard;
    
    vec3 lightFinal = u_vAmbient;
    
    vec3 lightDir;
    float lightFactor;
    for(int i = 0; i < LIGHT_COUNT; i++)
    {
        lightDir = u_vPosRadArray[i].xyz - v_vPosition;
        
        lightFactor = max(dot(normalize(v_vNormal), normalize(lightDir)), 0.0);
        lightFactor *= max(0.0, 1.0 - (length(lightDir) / u_vPosRadArray[i].w));
        
        lightFinal += u_vColorArray[i]*lightFactor;
    }
    
    gl_FragColor.rgb *= lightFinal;
}