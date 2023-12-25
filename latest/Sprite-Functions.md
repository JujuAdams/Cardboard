# Sprite Functions

&nbsp;

## `CbSprite(sprite, image, x, y, z)`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                            |
|--------|--------|-------------------------------------------------------------------|
|`sprite`|sprite  |Sprite to draw                                                     |
|`image` |number  |Image of the sprite to draw. Must be greather than or equal to zero|
|`x`     |number  |x-coordinate to draw the sprite at                                 |
|`y`     |number  |y-coordinate to draw the sprite at                                 |
|`z`     |number  |z-coordinate to draw the sprite at                                 |

&nbsp;

## `CbSpriteExt(sprite, image, x, y, z, xScale, zScale, yAngle, zAngle, color, alpha)`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                                      |
|--------|--------|-----------------------------------------------------------------------------|
|`sprite`|sprite  |Sprite to draw                                                               |
|`image` |number  |Image of the sprite to draw. Must be greather than or equal to zero          |
|`x`     |number  |x-coordinate to draw the sprite at                                           |
|`y`     |number  |y-coordinate to draw the sprite at                                           |
|`z`     |number  |z-coordinate to draw the sprite at                                           |
|`xScale`|number  |Scale of the sprite on the x-axis                                            |
|`zScale`|number  |Scale of the sprite on the z-axis                                            |
|`yAngle`|number  |Rotation of the sprite around the y-axis                                     |
|`zAngle`|number  |Rotation of the sprite around the z-axis                                     |
|`color` |number  |Blend color for the sprite (`c_white` is "no blending")                      |
|`alpha` |number  |Blend alpha for the sprite (`0` being transparent and `1` being 100% opacity)|

&nbsp;

## `CbSpriteFloor(sprite, image, x, y, z)`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                            |
|--------|--------|-------------------------------------------------------------------|
|`sprite`|sprite  |Sprite to draw                                                     |
|`image` |number  |Image of the sprite to draw. Must be greather than or equal to zero|
|`x`     |number  |x-coordinate to draw the sprite at                                 |
|`y`     |number  |y-coordinate to draw the sprite at                                 |
|`z`     |number  |z-coordinate to draw the sprite at                                 |

&nbsp;

## `CbSpriteFloorExt(sprite, image, x, y, z, xScale, yScale, zAngle, color, alpha)`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                                      |
|--------|--------|-----------------------------------------------------------------------------|
|`sprite`|sprite  |Sprite to draw                                                               |
|`image` |number  |Image of the sprite to draw. Must be greather than or equal to zero          |
|`x`     |number  |x-coordinate to draw the sprite at                                           |
|`y`     |number  |y-coordinate to draw the sprite at                                           |
|`z`     |number  |z-coordinate to draw the sprite at                                           |
|`xScale`|number  |Scale of the sprite on the x-axis                                            |
|`yScale`|number  |Scale of the sprite on the y-axis                                            |
|`zAngle`|number  |Rotation of the sprite around the z-axis                                     |
|`color` |number  |Blend color for the sprite (`c_white` is "no blending")                      |
|`alpha` |number  |Blend alpha for the sprite (`0` being transparent and `1` being 100% opacity)|

&nbsp;

## `CbSpriteBillboard(sprite, image, x, y, z)`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                            |
|--------|--------|-------------------------------------------------------------------|
|`sprite`|sprite  |Sprite to draw                                                     |
|`image` |number  |Image of the sprite to draw. Must be greather than or equal to zero|
|`x`     |number  |x-coordinate to draw the sprite at                                 |
|`y`     |number  |y-coordinate to draw the sprite at                                 |
|`z`     |number  |z-coordinate to draw the sprite at                                 |

&nbsp;

## `CbSpriteBillboardExt(sprite, image, x, y, z, xScale, zScale, yAngle, color, alpha)`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                                      |
|--------|--------|-----------------------------------------------------------------------------|
|`sprite`|sprite  |Sprite to draw                                                               |
|`image` |number  |Image of the sprite to draw. Must be greather than or equal to zero          |
|`x`     |number  |x-coordinate to draw the sprite at                                           |
|`y`     |number  |y-coordinate to draw the sprite at                                           |
|`z`     |number  |z-coordinate to draw the sprite at                                           |
|`xScale`|number  |Scale of the sprite on the x-axis                                            |
|`zScale`|number  |Scale of the sprite on the z-axis                                            |
|`yAngle`|number  |Rotation of the sprite around the y-axis                                     |
|`color` |number  |Blend color for the sprite (`c_white` is "no blending")                      |
|`alpha` |number  |Blend alpha for the sprite (`0` being transparent and `1` being 100% opacity)|

&nbsp;

## `CbSpriteQuad(sprite, image, x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4, color, alpha)`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                                      |
|--------|--------|-----------------------------------------------------------------------------|
|`sprite`|sprite  |Sprite to draw                                                               |
|`image` |number  |Image of the sprite to draw. Must be greather than or equal to zero          |
|`x1`    |number  |x-coordinate for the top-left corner of the texture                          |
|`y1`    |number  |y-coordinate for the top-left corner of the texture                          |
|`z1`    |number  |z-coordinate for the top-left corner of the texture                          |
|`x2`    |number  |x-coordinate for the top-right corner of the texture                         |
|`y2`    |number  |y-coordinate for the top-right corner of the texture                         |
|`z2`    |number  |z-coordinate for the top-right corner of the texture                         |
|`x3`    |number  |x-coordinate for the bottom-left corner of the texture                       |
|`y3`    |number  |y-coordinate for the bottom-left corner of the texture                       |
|`z3`    |number  |z-coordinate for the bottom-left corner of the texture                       |
|`x4`    |number  |x-coordinate for the bottom-right corner of the texture                      |
|`y4`    |number  |y-coordinate for the bottom-right corner of the texture                      |
|`z4`    |number  |z-coordinate for the bottom-right corner of the texture                      |
|`color` |number  |Blend color for the sprite (`c_white` is "no blending")                      |
|`alpha` |number  |Blend alpha for the sprite (`0` being transparent and `1` being 100% opacity)|

&nbsp;

## `CbSpriteTriangle(sprite, image, x1, y1, z1, u1, v1, x2, y2, z2, u2, v2, x3, y3, z3, u3, v3, color, alpha)`

**Returns:** N/A (`undefined`)

|Name    |Datatype|Purpose                                                                      |
|--------|--------|-----------------------------------------------------------------------------|
|`sprite`|sprite  |Sprite to draw                                                               |
|`image` |number  |Image of the sprite to draw. Must be greather than or equal to zero          |
|`x1`    |number  |x-coordinate for the top-left corner of the texture                          |
|`y1`    |number  |y-coordinate for the top-left corner of the texture                          |
|`z1`    |number  |z-coordinate for the top-left corner of the texture                          |
|`u1`    |number  |U-coordinate, normalised to the size of the sprite's texture                 |
|`v1`    |number  |V-coordinate, normalised to the size of the sprite's texture                 |
|`x2`    |number  |x-coordinate for the top-right corner of the texture                         |
|`y2`    |number  |y-coordinate for the top-right corner of the texture                         |
|`z2`    |number  |z-coordinate for the top-right corner of the texture                         |
|`u2`    |number  |U-coordinate, normalised to the size of the sprite's texture                 |
|`v2`    |number  |V-coordinate, normalised to the size of the sprite's texture                 |
|`x3`    |number  |x-coordinate for the bottom-left corner of the texture                       |
|`y3`    |number  |y-coordinate for the bottom-left corner of the texture                       |
|`z3`    |number  |z-coordinate for the bottom-left corner of the texture                       |
|`u3`    |number  |U-coordinate, normalised to the size of the sprite's texture                 |
|`v3`    |number  |V-coordinate, normalised to the size of the sprite's texture                 |
|`color` |number  |Blend color for the sprite (`c_white` is "no blending")                      |
|`alpha` |number  |Blend alpha for the sprite (`0` being transparent and `1` being 100% opacity)|

&nbsp;

## `CbBillboardYawSet(fromX, fromY, toX, toY)`

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                 |
|---------------|--------|----------------------------------------|
|`fromX`        |number  |x-coordinate of the camera              |
|`fromY`        |number  |y-coordinate of the camera              |
|`toX`          |number  |x-coordinate of the camera's focal point|
|`toY`          |number  |y-coordinate of the camera's focal point|

&nbsp;

## `CbBillboardYawReset()`

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |