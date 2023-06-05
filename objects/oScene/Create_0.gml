//Pre-build "terrain"
CbModelBegin();

var _ruleset = CbTilemapsToModelRuleset();
_ruleset.AddTileset(tsTiles).RemapEdgeAbove(1,0,   0,1, 1,0).RemapEdgeAbove(1,0,   0,1, 1,0);

var _array = ["Tiles_1", "Tiles_2", "Tiles_3"];

CbSpriteFloorExt(sprHi, 0, 0, 0, 0, 100, 100, 0, c_white, 1);
CbTilemapsToModel(_ruleset, _array, 0, 0, 0, 100, 100, 100);
CbLayerArrayHide(_array);

//CbSpriteFloorExt(sprHi, 0,  320,    0,   0, 5, 5, 0, c_red,    1);
//CbSpriteFloorExt(sprHi, 0,    0, -320,   0, 5, 5, 0, c_aqua,   1);
//CbSpriteFloorExt(sprHi, 0, -320,    0,   0, 5, 5, 0, c_yellow, 1);
//CbSpriteFloorExt(sprHi, 0,    0,  320,   0, 5, 5, 0, c_lime,   1);
//CbSpriteFloorExt(sprHi, 0,    0,    0, 320, 5, 5, 0, c_blue,   1);
//
//CbSpriteExt(sprHi, 1,  160,    0, 160, 5, 5, 0,  90, c_white, 1, false);
//CbSpriteExt(sprHi, 1,    0,  160, 160, 5, 5, 0,   0, c_white, 1, false);
//CbSpriteExt(sprHi, 1, -160,    0, 160, 5, 5, 0, -90, c_white, 1, false);
//CbSpriteExt(sprHi, 1,    0, -160, 160, 5, 5, 0, 180, c_white, 1, false);
//
//CbSpriteQuad(sprHi, 0,
//                    -160, -800, 160,
//                     160, -800, 160,
//                    -160, -480,   0,
//                     160, -480,   0,
//                    c_aqua, 1);
//
//CbSpriteTriangle(sprHi, 0,
//                        160, -800, 160,    0, 0,
//                        480, -800, 160,    1, 0,
//                        160, -480,   0,    0, 1,
//                        c_aqua, 1);
//
//CbSpriteTriangle(sprHi, 0,
//                        480, -800, 160,    1, 0,
//                        160, -480,   0,    0, 1,
//                        480, -480, 160,    1, 1,
//                        c_aqua, 1);
//
//CbSpriteQuad(sprHi, 0,
//                    480, -480, 160,
//                    480, -160, 160,
//                    160, -480,   0,
//                    160, -160,   0,
//                    c_aqua, 1);

model = CbModelEnd();

//Define a handy draw function that we can call from oRenderer later
Draw = function()
{
    CbModelSubmit(model);
    
    CbSpriteLayerBillboard("Assets_1", 0, 0, 0);
    CbLayerArrayHide(["Assets_1"]);
    
    CbSpriteExt(sprTest, 0,   -320,   0, 0,    2, 2, 0, 90,    c_white, 1, false);
    CbSpriteExt(sprTest, 0,    320,   0, 0,    2, 2, 0, current_time/15,    c_white, 1, true );
    CbSpriteExt(sprTest, 0,      0, 320, 0,    2, 2, 0,  0,    c_white, 1, false);
    
    CbBatchForceSubmit();
}