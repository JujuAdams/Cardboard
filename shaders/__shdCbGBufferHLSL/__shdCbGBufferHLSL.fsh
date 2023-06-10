struct PS
{
    float4 Position: SV_Position;
    float3 Normal:   NORMAL0;
    float4 Colour0:  COLOR0;
    float2 Texcoord: TEXCOORD0;
    float4 Colour1:  COLOR1;
};

struct OUTPUT
{
    float4 Colour0: SV_Target0;
    float4 Colour1: SV_Target1;
    float4 Colour2: SV_Target2;
};

uniform float u_fAlphaTestRef;

float3 DepthToRGB(float depth)
{
    return frac(floor(255.0*depth*float3(1.0, 255.0, 65025.0)) / 255.0);
}

OUTPUT main(PS In)
{
    OUTPUT Out;
    
    Out.Colour0 = In.Colour0*gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord);
    if (u_fAlphaTestRef > Out.Colour0.a) discard;
    
    Out.Colour1 = In.Colour1; //float4(DepthToRGB(In.Position.z / In.Position.w), 1.0);
    Out.Colour2 = float4(0.5 + 0.5*In.Normal, 1.0);
    
    return Out;
}