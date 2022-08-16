/// CAM: Scroll Up
event_inherited();

var new_ypos = clamp(camera_get_view_y(camera) - CAM_SCROLL_SPEED, 0, room_height - h);
camera_set_view_pos(camera, 0, new_ypos);