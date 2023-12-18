// Feather disable all

function TurnFrustrumIntoWireframe(_frustrum)
{
    with(_frustrum)
    {
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlNear, b: trNear, });
        instance_create_depth(0, 0, 0, oDebugLine, { a: blNear, b: brNear, });
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlNear, b: blNear, });
        instance_create_depth(0, 0, 0, oDebugLine, { a: trNear, b: brNear, });
        
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlFar, b: trFar, });
        instance_create_depth(0, 0, 0, oDebugLine, { a: blFar, b: brFar, });
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlFar, b: blFar, });
        instance_create_depth(0, 0, 0, oDebugLine, { a: trFar, b: brFar, });
        
        instance_create_depth(0, 0, 0, oDebugLine, { a: tlNear, b: tlFar, });
        instance_create_depth(0, 0, 0, oDebugLine, { a: trNear, b: trFar, });
        instance_create_depth(0, 0, 0, oDebugLine, { a: blNear, b: blFar, });
        instance_create_depth(0, 0, 0, oDebugLine, { a: brNear, b: brFar, });
    }
}