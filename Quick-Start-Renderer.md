# Function Index

&nbsp;

## `CardboardRenderStateSet(x, y, string)`

|Name            |Datatype|Purpose                                                                                                                                            |
|----------------|--------|---------------------------------------------------------------------------------------------------------------------------------------------------|
|`width`         |number  |Width of the orthographic projection                                                                                                               |
|`height`        |number  |Height of the orthographic projection                                                                                                              |
|`fromX`         |number  |x-coordinate of the camera                                                                                                                         |
|`fromY`         |number  |y-coordinate of the camera                                                                                                                         |
|`fromZ`         |number  |z-coordinate of the camera                                                                                                                         |
|`toX`           |number  |x-coordinate of the camera's focal point                                                                                                           |
|`toY`           |number  |y-coordinate of the camera's focal point                                                                                                           |
|`toZ`           |number  |z-coordinate of the camera's focal point                                                                                                           |
|`[axonometric]` |boolean |Optional, defaults to `true`. Whether to use axonometric projection. This ensures sprites are never "squashed" regardless of the camera pitch angle|
|`[alphaTestRef]`|integer |Optional, defaults to `128`, the alpha test threshold. Pixels with alpha values below this threshold will be discarded                             |

&nbsp;

## `CardboardRenderStateReset()`

**Returns:** N/A (`undefined`)

|Name|Datatype|Purpose|
|----|--------|-------|
|None|        |       |
