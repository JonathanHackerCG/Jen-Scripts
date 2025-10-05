

function terra_grid_roomloader(_load_room, _cleared = noone)
{
	var _room_data = room_get_info(_load_room, false, false, false, false, false);
	var w = _room_data.width	/ TERRA_CELLW;
	var h = _room_data.height	/ TERRA_CELLH;
	var _grid = terra_grid_create(w, h, _cleared);
	terra_set(_grid, 0, 0, all, new TerraObject(obj_terra_roomloader, {
		__room: _load_room
	}));
	return _grid;
}