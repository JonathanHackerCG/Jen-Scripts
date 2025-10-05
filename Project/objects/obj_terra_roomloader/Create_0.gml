/// Terra RoomLoader: Create

if (__room == noone)
{
	instance_destroy(self, false);
	exit;
}

__payload = RoomLoader.Load(__room, x, y);