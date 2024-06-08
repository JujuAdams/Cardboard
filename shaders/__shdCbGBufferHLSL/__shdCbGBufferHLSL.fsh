struct PS
{
    float4 Position: SV_Position;
    float3 Normal:   NORMAL0;
    float4 Colour:   COLOR0;
    float2 Texcoord: TEXCOORD0;
};

struct OUTPUT
{
    float4 Colour0: SV_Target0;
    float4 Colour1: SV_Target1;
};

OUTPUT main(PS In)
{
    OUTPUT Out;
    
    Out.Colour0 = In.Colour*gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord);
    if (gm_AlphaRefValue.r >= Out.Colour0.a) discard;
    Out.Colour1 = float4(0.5 + 0.5*In.Normal, 1.0);
    
    return Out;
}