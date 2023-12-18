// Feather disable all

function TurnFrustrumIntoBox(_frustrum)
{
    with(_frustrum)
    {
        instance_create_depth(0, 0, 0, oDebugQuad, { a: tlNear, b: trNear, c: blNear, d: brNear }).image_blend = c_red;
        instance_create_depth(0, 0, 0, oDebugQuad, { a: tlFar,  b: trFar,  c: blFar,  d: brFar  }).image_blend = c_blue;
        instance_create_depth(0, 0, 0, oDebugQuad, { a: tlNear, b: blNear, c: tlFar,  d: blFar  }).image_blend = c_lime;
        instance_create_depth(0, 0, 0, oDebugQuad, { a: trNear, b: brNear, c: trFar,  d: brFar  }).image_blend = c_yellow;
        instance_create_depth(0, 0, 0, oDebugQuad, { a: tlNear, b: trNear, c: tlFar,  d: trFar  }).image_blend = c_aqua;
        instance_create_depth(0, 0, 0, oDebugQuad, { a: blNear, b: brNear, c: blFar,  d: brFar  }).image_blend = c_fuchsia;
    }
}