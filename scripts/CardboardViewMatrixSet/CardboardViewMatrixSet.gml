/// Sets GameMaker's active view matrix using Cardboard's own z-tilt view matrix
/// 
/// This function also allows use of CardboardSpriteBillboard*()
/// You should use CardboardViewMatrixReset() to reset the view matrix after calling this function
/// 
/// @param fromX               x-coordinate of the camera
/// @param fromY               y-coordinate of the camera
/// @param fromZ               z-coordinate of the camera
/// @param toX                 x-coordinate of the camera's focal point
/// @param toY                 y-coordinate of the camera's focal point
/// @param toZ                 z-coordinate of the camera's focal point
/// @param [axonometric=true]  Optional, defaults to <true>; whether to use axonometric projection. This ensures sprites are never "squashed" regardless of the camera pitch angle
/// @param [upX=0]             x-component of the camera's up vector
/// @param [upY=0]             y-component of the camera's up vector
/// @param [upZ=1]             z-component of the camera's up vector

function CardboardViewMatrixSet(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _axonometrix = undefined, _upX = undefined, _upY = undefined, _upZ = undefined)
{
    CardboardBillboardYawSet(_fromX, _fromY, _toX, _toY);
    
    global.__cardboardOldViewMatrix = matrix_get(matrix_view);
    matrix_set(matrix_view, CardboardViewMatrixBuild(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _axonometrix, _upX, _upY, _upZ));
}