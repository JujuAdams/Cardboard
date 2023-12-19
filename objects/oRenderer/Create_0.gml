CbCameraSizeSet(1280, 720);
CbDoubleSidedSet(true);
CbCameraPerpsectiveSet(90);

CbLightModeSet(CB_LIGHT_MODE.ONE_SHADOW_MAP);
CbLightAmbientSet(c_dkgray);
//dir    = CbLightDirectional(1, -2, -3, make_color_rgb(0.2*255, 0.3*255, 0.4*255));
//light1 = CbLightPoint(0, 0, 50, 200, c_red);

CbLightDefaultDepthFunctionSet(function()
{
    //Draw the scene object
    oScene.Draw();
});

//light2 = CbLightWithShadows(c_yellow, 300, 450, 90, -150, 0, 0, 140, 300);
//light3 = CbLightWithShadows(c_white, 300, 450, 90, -150, 0, 0, 80, 300);
light4 = CbLightDirectionalWithShadows(-1, -1, -1, c_white);

opaqueFunc = function()
{
    //Draw the scene object
    oScene.Draw();
    CbSpriteBillboard(sprGuy, 0,    oCamera.camToX, oCamera.camToY, oCamera.camToZ);
};

unlitFunc = function()
{
    gpu_set_cullmode(cull_noculling);
    
    with(oDebugLine)
    {
        b3d_draw_line_ab(a, b, 5, sprite);
    }
    
    with(oDebugQuad)
    {
        b3d_draw_triangle(a, b, c, image_blend, false);
        b3d_draw_triangle(b, c, d, image_blend, false);
    }
    
    shader_set(shdBillboard);
    matrix_set(matrix_world, matrix_build(300, 300, 64,   0,0,0,   1,1,1));
    vertex_submit(vertexBuffer, pr_trianglelist, sprite_get_texture(sprLazy, 0));
    matrix_set(matrix_world, matrix_build_identity());
    shader_reset();
};

vertexBuffer = vertex_create_buffer();
vertex_begin(vertexBuffer, __CbBuildGlobal().__batch.__vertexFormat);

vertex_position_3d(vertexBuffer, 0, 0, 0);
vertex_normal(vertexBuffer, 0, 0, 1);
vertex_color(vertexBuffer, c_white, 1);
vertex_texcoord(vertexBuffer, 0, 0);

vertex_position_3d(vertexBuffer, 64, 0, 0);
vertex_normal(vertexBuffer, 0, 0, 1);
vertex_color(vertexBuffer, c_white, 1);
vertex_texcoord(vertexBuffer, 1, 0);

vertex_position_3d(vertexBuffer, 64, 64, 0);
vertex_normal(vertexBuffer, 0, 0, 1);
vertex_color(vertexBuffer, c_white, 1);
vertex_texcoord(vertexBuffer, 1, 1);

vertex_position_3d(vertexBuffer, 0, 0, 0);
vertex_normal(vertexBuffer, 0, 0, 1);
vertex_color(vertexBuffer, c_white, 1);
vertex_texcoord(vertexBuffer, 0, 0);

vertex_position_3d(vertexBuffer, 64, 64, 0);
vertex_normal(vertexBuffer, 0, 0, 1);
vertex_color(vertexBuffer, c_white, 1);
vertex_texcoord(vertexBuffer, 1, 1);

vertex_position_3d(vertexBuffer, 0, 64, 0);
vertex_normal(vertexBuffer, 0, 0, 1);
vertex_color(vertexBuffer, c_white, 1);
vertex_texcoord(vertexBuffer, 0, 1);

vertex_end(vertexBuffer);