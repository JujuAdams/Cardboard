CbDoubleSidedSet(true);

CbLightModeSet(CB_LIGHT_MODE.DEFERRED);
CbLightAmbientSet(c_dkgray);
dir    = CbLightDirectional(1, -2, -3, make_color_rgb(0.2*255, 0.3*255, 0.4*255));
light1 = CbLightPoint(-10, -10, 50, 200, c_white);

//light2 = CbLightConeWithShadows(c_yellow, 300, 450, 90, -150, 0, 0, 140, 300);
light3 = CbLightConeWithShadows(c_white, 300, 450, 90, -150, 0, 0, 80, 300);
light4 = CbLightDirectionalWithShadows(-1, -1, -1, c_navy, -1024);

CbLightDefaultDepthFunctionSet(function()
{
    //Draw the scene object
    oScene.Draw();
});

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
};

var _tileset = tileset_get_info(tsTiles);
show_debug_message(json_stringify(_tileset, true));