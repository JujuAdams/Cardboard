struct VS
{
    float3 Position: POSITION0;
    float3 Normal:   NORMAL0;
    float4 Colour:   COLOR0;
    float2 Texcoord: TEXCOORD0;
};

struct PS
{
    float4 Position: SV_Position;
    float3 Normal:   NORMAL0;
    float4 Colour:   COLOR0;
    float2 Texcoord: TEXCOORD0;
};

PS main(VS In)
{
    PS Out;
    Out.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(In.Position, 1.0));
    Out.Normal   = normalize(mul(gm_Matrices[MATRIX_WORLD], float4(In.Normal, 0.0)).xyz);
    Out.Colour   = In.Colour;
    Out.Texcoord = In.Texcoord;
    return Out;
}