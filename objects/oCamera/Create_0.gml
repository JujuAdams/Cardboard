camFromX = 0;
camFromY = 200;
camFromZ = 200;

camToX = 0;
camToY = 0;
camToZ = 0;

CardboardModelBegin();
CardboardSpriteFloorExt(sprHi, 0, 320,   0,   0, 5, 5, 0, c_red,   1);
CardboardSpriteFloorExt(sprHi, 0, -320,   0,   0, 5, 5, 0, c_yellow,   1);
CardboardSpriteFloorExt(sprHi, 0,   0, 320,   0, 5, 5, 0, c_lime,  1);
CardboardSpriteFloorExt(sprHi, 0,   0,   0, 320, 5, 5, 0, c_blue,  1);
CardboardSpriteExt(sprHi, 1, 0, 160, 160, 5, 5, 0, 0, c_white, 1);
CardboardSpriteExt(sprHi, 1, 160, 0, 160, 5, 5, 0, 90, c_white, 1);
CardboardSpriteExt(sprHi, 1, -160, 0, 160, 5, 5, 0, -90, c_white, 1);
model = CardboardModelEnd();