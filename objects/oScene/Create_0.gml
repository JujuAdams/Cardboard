//Pre-build "terrain"
CardboardModelBegin();

CardboardSpriteFloorExt(sprHi, 0,  320,    0,   0, 5, 5, 0, c_red,    1);
CardboardSpriteFloorExt(sprHi, 0,    0, -320,   0, 5, 5, 0, c_aqua,   1);
CardboardSpriteFloorExt(sprHi, 0, -320,    0,   0, 5, 5, 0, c_yellow, 1);
CardboardSpriteFloorExt(sprHi, 0,    0,  320,   0, 5, 5, 0, c_lime,   1);
CardboardSpriteFloorExt(sprHi, 0,    0,    0, 320, 5, 5, 0, c_blue,   1);

CardboardSpriteExt(sprHi, 1,  160,    0, 160, 5, 5, 0,  90, c_white, 1, false);
CardboardSpriteExt(sprHi, 1,    0,  160, 160, 5, 5, 0,   0, c_white, 1, false);
CardboardSpriteExt(sprHi, 1, -160,    0, 160, 5, 5, 0, -90, c_white, 1, false);
CardboardSpriteExt(sprHi, 1,    0, -160, 160, 5, 5, 0, 180, c_white, 1, false);

CardboardSpriteQuad(sprHi, 0,
                    -160, -800, 160,
                     160, -800, 160,
                    -160, -480,   0,
                     160, -480,   0,
                    c_aqua, 1);

CardboardSpriteTriangle(sprHi, 0,
                        160, -800, 160,    0, 0,
                        480, -800, 160,    1, 0,
                        160, -480,   0,    0, 1,
                        c_aqua, 1);

CardboardSpriteTriangle(sprHi, 0,
                        480, -800, 160,    1, 0,
                        160, -480,   0,    0, 1,
                        480, -480, 160,    1, 1,
                        c_aqua, 1);

CardboardSpriteQuad(sprHi, 0,
                    480, -480, 160,
                    480, -160, 160,
                    160, -480,   0,
                    160, -160,   0,
                    c_aqua, 1);

model = CardboardModelEnd();

//Define a handy draw function that we can call from oRenderer later
Draw = function()
{
    CardboardModelSubmit(model);
    
    CardboardSpriteExt(sprTest, 0,   -320,   0, 0,    2, 2, 0, 90,    c_white, 1, false);
    CardboardSpriteExt(sprTest, 0,    320,   0, 0,    2, 2, 0, current_time/15,    c_white, 1, true );
    CardboardSpriteExt(sprTest, 0,      0, 320, 0,    2, 2, 0,  0,    c_white, 1, false);
    
    CardboardBatchForceSubmit();
}