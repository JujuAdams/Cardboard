//Pre-build terrain
CardboardModelBegin();

CardboardSpriteFloorExt(sprHi, 0,  320,    0,   0, 5, 5, 0, c_red,    1);
CardboardSpriteFloorExt(sprHi, 0,    0, -320,   0, 5, 5, 0, c_aqua,   1);
CardboardSpriteFloorExt(sprHi, 0, -320,    0,   0, 5, 5, 0, c_yellow, 1);
CardboardSpriteFloorExt(sprHi, 0,    0,  320,   0, 5, 5, 0, c_lime,   1);
CardboardSpriteFloorExt(sprHi, 0,    0,    0, 320, 5, 5, 0, c_blue,   1);

CardboardSpriteExt(sprHi, 1,  160,    0, 160, 5, 5, 0,  90, c_white, 1);
CardboardSpriteExt(sprHi, 1,    0,  160, 160, 5, 5, 0,   0, c_white, 1);
CardboardSpriteExt(sprHi, 1, -160,    0, 160, 5, 5, 0, -90, c_white, 1);
CardboardSpriteExt(sprHi, 1,    0, -160, 160, 5, 5, 0, 180, c_white, 1);

model = CardboardModelEnd();

//Define a handy draw function that we can call from oRenderer later
Draw = function()
{
    CardboardModelSubmit(model);
    
    CardboardSpriteExt(sprTest, 0,    161,   0, 64,    2, 2, 0, 90,    c_white, 1);
    CardboardSpriteExt(sprTest, 0,      0, 161, 64,    2, 2, 0,  0,    c_white, 1);
    
    CardboardBatchSubmit();
}