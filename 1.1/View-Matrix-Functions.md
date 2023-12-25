# View Matrix Renderer

&nbsp;

## `CardboardViewMatrixBuild(fromX, fromY, fromZ, toX, toY, toZ, [axonometric], [upX], [upY], [upZ])`

**Returns:** 16-element 1D array, a 4x4 view matrix

|Name           |Datatype|Purpose                                                                                                                                            |
|---------------|--------|---------------------------------------------------------------------------------------------------------------------------------------------------|
|`fromX`        |number  |x-coordinate of the camera                                                                                                                         |
|`fromY`        |number  |y-coordinate of the camera                                                                                                                         |
|`fromZ`        |number  |z-coordinate of the camera                                                                                                                         |
|`toX`          |number  |x-coordinate of the camera's focal point                                                                                                           |
|`toY`          |number  |y-coordinate of the camera's focal point                                                                                                           |
|`toZ`          |number  |z-coordinate of the camera's focal point                                                                                                           |
|`[axonometric]`|boolean |Optional, defaults to `true`. Whether to use axonometric projection. This ensures sprites are never "squashed" regardless of the camera pitch angle|
|`[upX]`        |number  |Optional, defaults to `0`. x-component of the camera's up vector                                                                                   |
|`[upY]`        |number  |Optional, defaults to `0`. y-component of the camera's up vector                                                                                   |
|`[upZ]`        |number  |Optional, defaults to `1`. z-component of the camera's up vector                                                                                   |

&nbsp;

## `CardboardViewMatrixSet(fromX, fromY, fromZ, toX, toY, toZ, [axonometric], [upX], [upY], [upZ])`

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                                                            |
|---------------|--------|---------------------------------------------------------------------------------------------------------------------------------------------------|
|`fromX`        |number  |x-coordinate of the camera                                                                                                                         |
|`fromY`        |number  |y-coordinate of the camera                                                                                                                         |
|`fromZ`        |number  |z-coordinate of the camera                                                                                                                         |
|`toX`          |number  |x-coordinate of the camera's focal point                                                                                                           |
|`toY`          |number  |y-coordinate of the camera's focal point                                                                                                           |
|`toZ`          |number  |z-coordinate of the camera's focal point                                                                                                           |
|`[axonometric]`|boolean |Optional, defaults to `true`. Whether to use axonometric projection. This ensures sprites are never "squashed" regardless of the camera pitch angle|
|`[upX]`        |number  |Optional, defaults to `0`. x-component of the camera's up vector                                                                                   |
|`[upY]`        |number  |Optional, defaults to `0`. y-component of the camera's up vector                                                                                   |
|`[upZ]`        |number  |Optional, defaults to `1`. z-component of the camera's up vector                                                                                   |

&nbsp;

## `CardboardViewMatrixReset()`

**Returns:** N/A (`undefined`)

|Name Datatype|Purpose|
|----|--------|-------|
|None|        |       |