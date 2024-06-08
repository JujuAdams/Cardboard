CbCameraFromSet(oCamera.camFromX, oCamera.camFromY, oCamera.camFromZ);
CbCameraToSet(oCamera.camToX, oCamera.camToY, oCamera.camToZ);

if (variable_instance_exists(self, "light1"))
{
    light1.x = oCamera.camToX;
    light1.y = oCamera.camToY + 20;
    light1.z = oCamera.camToZ;
}

if (variable_instance_exists(self, "light2"))
{
    light2.xFrom = oCamera.camToX;
    light2.yFrom = oCamera.camToY + 10;
    light2.zFrom = oCamera.camToZ + 90;
    light2.xTo   = oCamera.camToX;
    light2.yTo   = oCamera.camToY + 10;
    light2.zTo   = oCamera.camToZ;
}

if (variable_instance_exists(self, "light3"))
{
    var _angle = point_direction(room_width/2, room_height/2, mouse_x, mouse_y) + oCamera.yaw + 90;
    
    light3.xFrom = oCamera.camToX + lengthdir_x(10, _angle);
    light3.yFrom = oCamera.camToY + lengthdir_y(10, _angle);
    light3.zFrom = oCamera.camToZ + 30;
    light3.xTo   = oCamera.camToX + lengthdir_x(20, _angle);
    light3.yTo   = oCamera.camToY + lengthdir_y(20, _angle);
    light3.zTo   = oCamera.camToZ + 30;
}

if (variable_instance_exists(self, "light4"))
{
    light4.TrackCamera();
}