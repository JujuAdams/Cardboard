// Feather disable all

function TurnFrustrumIntoWireframe(_frustrum, _sprite = s3dWhite)
{
    with(_frustrum)
    {
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlNear, b: trNear, }).sprite = _sprite;
        instance_create_depth(0, 0, 0, oDebugLine, { a: blNear, b: brNear, }).sprite = _sprite;
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlNear, b: blNear, }).sprite = _sprite;
        instance_create_depth(0, 0, 0, oDebugLine, { a: trNear, b: brNear, }).sprite = _sprite;
        
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlFar, b: trFar, }).sprite = _sprite;
        instance_create_depth(0, 0, 0, oDebugLine, { a: blFar, b: brFar, }).sprite = _sprite;
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlFar, b: blFar, }).sprite = _sprite;
        instance_create_depth(0, 0, 0, oDebugLine, { a: trFar, b: brFar, }).sprite = _sprite;
        
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlNear, b: tlFar, }).sprite = _sprite;
        instance_create_depth(0, 0, 0, oDebugLine, { a: trNear, b: trFar, }).sprite = _sprite;
        instance_create_depth(0, 0, 0, oDebugLine, { a: blNear, b: blFar, }).sprite = _sprite;
        instance_create_depth(0, 0, 0, oDebugLine, { a: brNear, b: brFar, }).sprite = _sprite;
    }
}