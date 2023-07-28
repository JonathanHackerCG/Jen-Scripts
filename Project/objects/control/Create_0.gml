/// @desc Initialize
randomize();

room_goto(rm_main);

function clear_room()
{
	with (all)
	{
		if (!persistent)
		{
			instance_destroy();
		}
	}
}