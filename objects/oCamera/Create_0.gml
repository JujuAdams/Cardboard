yaw       = 270 - 22.5;
yawTarget = 270 - 22.5;

cameraDistance = 200;
cameraHeight   = cameraDistance*0.575; //roughly isometric

camToX = 0;
camToY = 0;
camToZ = 0;

camFromX = camToX + lengthdir_x(cameraDistance, yaw);
camFromY = camToY + lengthdir_y(cameraDistance, yaw);
camFromZ = camToZ + cameraHeight;