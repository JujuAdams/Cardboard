var _up        = keyboard_check(ord("W")) || (gamepad_axis_value(0, gp_axislv) < -0.5);
var _down      = keyboard_check(ord("S")) || (gamepad_axis_value(0, gp_axislv) >  0.5);
var _left      = keyboard_check(ord("A")) || (gamepad_axis_value(0, gp_axislh) < -0.5);
var _right     = keyboard_check(ord("D")) || (gamepad_axis_value(0, gp_axislh) >  0.5);
var _rotateCCW = keyboard_check_pressed(ord("E")) || gamepad_button_check_pressed(0, gp_padr);
var _rotateCW  = keyboard_check_pressed(ord("Q")) || gamepad_button_check_pressed(0, gp_padl);
var _ascend    = keyboard_check(vk_space) || gamepad_button_check(0, gp_padu);
var _decend    = keyboard_check(vk_shift) || gamepad_button_check(0, gp_padd);

// Q/E rotates the camera
yawTarget += 22.5*(_rotateCCW - _rotateCW);
yaw = lerp(yaw, yawTarget, 0.3);

//WASD and shift/space translate the camera linearly
var _para = 5*(_down - _up);
var _perp = 5*(_right - _left);
var _dz   = 5*(_ascend - _decend);

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
    oRenderer.frustrumViewMatrix = cbCamera.GetViewMatrix();
    oRenderer.frustrumProjMatrix = cbCamera.GetProjectionMatrix();
}

if (keyboard_check_released(ord("Z")))
{
    cbCamera.SetZTilt(not cbCamera.GetZTilt());
}

if (keyboard_check_released(ord("X")))
{
    cbCamera.SetAxonometric(not cbCamera.GetAxonometric());
}

if (keyboard_check_released(ord("V")))
{
    if (cbCamera.GetProjection().orthographic)
    {
        cbCamera.SetPerspective(90, 1, 2048);
    }
    else
    {
        cbCamera.SetOrthographic(-2048, 2048);
    }
}

cbCamera.SetFrom(camFromX, camFromY, camFromZ);
cbCamera.SetTo(camToX, camToY, camToZ);