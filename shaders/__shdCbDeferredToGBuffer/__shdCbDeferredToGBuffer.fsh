precision highp float;

varying vec3 v_vNormal;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

void main()
{
    vec4 diffuse = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    if (gm_AlphaRefValue >= diffuse.a) discard;
    
    //This dumb way of packing values into a 16-bit float limits our range of possible values.
    //Reducing the accuracy of the normals ends up being acceptable. It's possible to pack more
    //data in (not least to store the normal's z-sign only and then increase the available bits
    //for the x/y axis) but I haven't done the maths to figure that out yet.
    //
    //TODO - Increase normal accuracy
    gl_FragColor.rgb = diffuse.rgb + 2.0*floor(31.0*v_vNormal.xyz);
    
    //The alpha channel isn't used. This could be repurposed for extra per-pixel information.
    gl_FragColor.a = 1.0;
}