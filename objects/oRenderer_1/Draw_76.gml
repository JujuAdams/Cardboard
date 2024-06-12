var _angle = point_direction(room_width/2, room_height/2, mouse_x, mouse_y) + oCamera.yaw + 90;

light.xFrom = oCamera.camToX + lengthdir_x(10, _angle);
light.yFrom = oCamera.camToY + lengthdir_y(10, _angle);
light.zFrom = oCamera.camToZ + 30;
light.xTo   = oCamera.camToX + lengthdir_x(20, _angle);
light.yTo   = oCamera.camToY + lengthdir_y(20, _angle);
light.zTo   = oCamera.camToZ + 30;