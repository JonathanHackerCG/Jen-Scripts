/// @desc CONTROL: Step

if (keyboard_check_pressed(ord("M")))
{
	maze = jen_maze_create_backtrack(20, 20);
}