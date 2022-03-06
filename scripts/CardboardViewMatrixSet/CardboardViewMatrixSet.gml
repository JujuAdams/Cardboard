/// @param fromX
/// @param fromY
/// @param fromZ
/// @param toX
/// @param toY
/// @param toZ
/// @param [lockYAxis=true]
/// @param [upX=0]
/// @param [upY=0]
/// @param [upZ=1]

function CardboardViewMatrixSet(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _lockYAxis = undefined, _upX = undefined, _upY = undefined, _upZ = undefined)
{
    global.__cardboardOldViewMatrix = matrix_get(matrix_view);
    global.__cardboardBillboardYaw = point_direction(_fromX, _fromY, _toX, _toY) - 90;
    matrix_set(matrix_view, CardboardViewMatrixGet(_fromX, _fromY, _fromZ, _toX, _toY, _toZ, _lockYAxis, _upX, _upY, _upZ));
}