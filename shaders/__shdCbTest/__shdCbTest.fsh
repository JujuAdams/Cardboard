varying vec3 v_vPosition;
varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;
varying vec4 v_vLightPos;

uniform float     u_fAlphaTestRef;
uniform sampler2D u_sLightDepth;
uniform vec4      u_vLightPos;
uniform vec2      u_vZ;

float RGBToDepth(vec3 color)
{
	color /= vec3(1.0, 255.0, 255.0*255.0);
    return color.r + color.g + color.b;
}

void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    
    if (u_fAlphaTestRef > gl_FragColor.a) discard;
    
    vec2  lightTexCoord   = 0.5 + 0.5*vec2(v_vLightPos.x, -v_vLightPos.y) / v_vLightPos.w;
    float lightCalcDepth  = (v_vLightPos.z - u_vZ.x) / (u_vZ.y - u_vZ.x);
    vec4  lightDepthColor = texture2D(u_sLightDepth, lightTexCoord);
    float lightFoundDepth = RGBToDepth(lightDepthColor.rgb);
    
    vec3 lightDir = u_vLightPos.xyz - v_vPosition;
    
    float lightFactor = max(dot(normalize(v_vNormal), normalize(lightDir)), 0.0);
    
    float bias = 0.005*tan(acos(lightFactor));
    bias = clamp(bias, 0.0, 0.01);
    
    lightFactor *= max(0.0, 1.0 - (length(lightDir) / u_vLightPos.w));
    
    vec3 lightFinal = vec3(0.5, 0.5, 0.5);
    
    if ((lightTexCoord.x >= 0.0)
    &&  (lightTexCoord.x <= 1.0)
    &&  (lightTexCoord.y >= 0.0)
    &&  (lightTexCoord.y <= 1.0)
    &&  (lightCalcDepth  <  lightFoundDepth + bias)
    &&  (2.0*length(lightTexCoord.xy - 0.5) <= 1.0))
    {
        lightFinal += lightFactor*vec3(1.0, 1.0, 0.0);
    }
    
    gl_FragColor.rgb *= lightFinal;
}