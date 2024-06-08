// Q/E rotates the camera
yawTarget += 22.5*(keyboard_check_pressed(ord("E")) - keyboard_check_pressed(ord("Q")));
yaw = lerp(yaw, yawTarget, 0.3);

//WASD and shift/space translate the camera linearly
var _para = 5*(keyboard_check(ord("S")) - keyboard_check(ord("W")));
var _perp = 5*(keyboard_check(ord("D")) - keyboard_check(ord("A")));
var _dz   = 5*(keyboard_check(vk_space) - keyboard_check(vk_shift));

var _dx = lengthdir_x(_para, yawTarget) + lengthdir_x(_perp, yawTarget + 90);
var _dy = lengthdir_y(_para, yawTarget) + lengthdir_y(_perp, yawTarget + 90);

camToX += _dx;
camToY += _dy;
camToZ += _dz;

//Set the camera's "from" position relative to the "to" position
camFromX = camToX + lengthdir_x(cameraDistance, yaw);
camFromY = camToY + lengthdir_y(cameraDistance, yaw);
camFromZ = camToZ + cameraHeight;

cameraHeight += (keyboard_check_pressed(ord("O")) - keyboard_check_pressed(ord("L")));

if (keyboard_check_released(ord("F")))
{
    TurnFrustrumIntoWireframe(cbCamera.GetFrustrumCoords());
    TurnFrustrumIntoBox(oRenderer.light4.GetFrustrumCoords());
}

if (keyboard_check_released(ord("V")))
{
    if (cbCamera.GetProjection().orthographic)
    {
        cbCamera.SetPerspective(90);
    }
    else
    {
        cbCamera.SetOrthographic();
    }
}

cbCamera.SetFrom(camFromX, camFromY, camFromZ);
cbCamera.SetTo(camToX, camToY, camToZ);