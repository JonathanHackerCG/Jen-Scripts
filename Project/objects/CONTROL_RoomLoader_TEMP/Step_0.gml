/// RoomLoader Control: Step

if (mouse_check_button_pressed(mb_left))
{
	instance_create_layer(mouse_x, mouse_y, "Instances_1", obj_terra_roomloader, {
		load_room: rm_roomloader_test_01
	});
}