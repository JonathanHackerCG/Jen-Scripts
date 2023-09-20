//Advanced shapes, wandering lines and mazes.

//Copying
#region jen_grid_copy_room();
/// @func jen_grid_copy_room
/// @desc Will convert the instances of the current room into a new jen_grid.
function jen_grid_copy_room()
{
	//Getting grid variables, making the grid.
	var _xgrid = JEN_CELLW;
	var _ygrid = JEN_CELLH;
	
	var _width = room_width / _xgrid;
	var _height = room_height / _ygrid;
	var _grid = jen_grid_create(_width, _height, noone);
	
	//Iterate through the entire grid.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		var inst = collision_rectangle((xx * _xgrid), (yy * _ygrid), ((xx + 1) * _xgrid) - 1, ((yy + 1) * _ygrid) - 1, all, false, true);
		if (inst != noone)
		{
			jen_set(_grid, xx, yy, all, inst.object_index);
		}
	} }

	//Return the final grid.
	return _grid;
}
#endregion
#region jen_grid_copy_room_part(x1, y1, width, height);
/// @func jen_grid_copy_room_part
/// @desc Converts a region of the room into a new jen_grid.
/// @arg  x1
/// @arg  y1
/// @arg  width
/// @arg  height
function jen_grid_copy_room_part(_x1, _y1, _width, _height)
{
	//Getting grid variables, making the grid.
	var _xgrid = JEN_CELLW;
	var _ygrid = JEN_CELLH;
	var _grid = jen_grid_create(_width, _height, noone);
	
	//Iterate through the entire grid.
	for (var yy = _y1; yy < _y1 + _height; yy++) {
	for (var xx = _x1; xx < _x1 + _width; xx++)
	{
		var inst = collision_rectangle((xx * _xgrid), (yy * _ygrid), ((xx + 1) * _xgrid) - 1, ((yy + 1) * _ygrid) - 1, all, false, true);
		if (inst != noone)
		{
			jen_set(_grid, xx - _x1, yy - _y1, all, inst.object_index);
		}
	} }

	//Return the final grid.
	return _grid;
}
#endregion
#region jen_grid_copy_room_array(x1, y1, width, height, rooms_w, rooms_h, [xspace], [yspace]);
/// @func jen_grid_copy_room_array
/// @desc Divides the current room into a grid, and outputs a list of jen_grids.
/// @arg  x1
/// @arg  y1
/// @arg  width
/// @arg  height
/// @arg  rooms_w
/// @arg  rooms_h
/// @arg  [xspace]
/// @arg  [yspace]
function jen_grid_copy_room_array(_x1, _y1, _width, _height, _rooms_w, _rooms_h, _xspace = 0, _yspace = 0)
{
	var _xgrid = JEN_CELLW;
	var _ygrid = JEN_CELLH;
	var _list = ds_list_create();
	
	//Iterate through entire grid
	for (var yy = 0; yy < _rooms_h; yy ++) {
	for (var xx = 0; xx < _rooms_w; xx ++)
	{
		var _grid = jen_grid_copy_room_part((_x1 + _xspace + (xx * (_xspace + _width))),
			(_y1 + _yspace + (yy * (_yspace + _height))), _width, _height, _xgrid, _ygrid);
		ds_list_add(_list, _grid);
	} }
	
	return _list;
}
#endregion
//TODO: jen_grid_copy_layer
//TODO: jen_grid_copy_layer_part
//TODO: jen_grid_copy_layer_array
//TODO: jen_grid_copy_tilemap
//TODO: jen_grid_copy_tilemap_part
//TODO: jen_grid_copy_tilemap_array

//Pasting
#region jen_grid_paste(target_JenGrid, paste_JenGrid, xcell, ycell, replace, [chance], [setter]);
/// @func jen_grid_paste(target_JenGrid, paste_JenGrid, xcell, ycell, replace, [chance], [setter]):
/// @desc Transfer all values from pasted grid to a target grid.
///				Values of 'noone' in the pasted grid will be ignored.
/// @arg	{Id.DsGrid}		target_JenGrid
/// @arg  {Id.DsGrid}		paste_JenGrid		Supports Array (Chooses)
/// @arg	{Real}				xcell
/// @arg	{Real}				ycell
/// @arg	{Any}					replace					Supports Array (Any Of)
/// @arg  {Real}				[chance]				Default: 100
/// @arg  {Function}		[setter]				Default: jen_set
function jen_grid_paste(_target, _paste, _x1, _y1, _replace, _chance = 100, _setter = jen_set)
{
	//Array conversions.
	_paste = _jenternal_convert_array_choose(_paste);
	_replace = _jenternal_convert_array_all(_replace);
	
	//Getting width and height of the grids.
	var _w = jen_grid_width(_target);
	var _h = jen_grid_height(_target);
	var _w_paste = min(jen_grid_width(_paste), _w);
	var _h_paste = min(jen_grid_height(_paste), _h);
	
	//Iterate through the pasting grid.
	var _value;
	for (var yy = 0; yy < _h_paste; yy ++) {
	for (var xx = 0; xx < _w_paste; xx ++)
	{
		//Get the value of the pasting grid.
		_value = jen_get(_paste, xx, yy);
		if (_value != noone) && (_jenternal_percent(_chance))
		{
			_setter(_target, _x1 + xx, _y1 + yy, _replace, _value);
		}
	} }
}
#endregion
#region jen_scatter_paste(target_JenGrid, paste_JenGrid, match_value, xcell_off, ycell_off, chance_paste, replace, [chance], [setter]);
/// @func jen_scatter_paste(target_JenGrid, paste_JenGrid, match_value, xcell_off, ycell_off, chance_paste, replace, [chance], [setter]):
/// @desc Pastes a JenGrid (or array of JenGrids) at matching values with a given paste chance.
///				Values of 'noone' in the pasted grid(s) will be ignored.
/// @arg	{Id.DsGrid}		target_JenGrid
/// @arg  {Id.DsGrid}		paste_JenGrid		Supports Array (Chooses)
/// @arg  {Any}					match_value			Supports Array (Any Of)
/// @arg  {Real}				xcell_off				Supports Array (Any Of)
/// @arg  {Real}				ycell_off				Supports Array (Any Of)
/// @arg	{Real}				chance_paste
/// @arg  {Any}					replace					Supports Array (Any Of)
/// @arg  {Real}				[chance]				Default: 100
/// @arg  {Function}		[setter]				Default: jen_set
function jen_scatter_paste(_target, _paste, _match_value, _xoff, _yoff, _chance_paste, _replace, _chance = 100, _setter = jen_set)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_target);
	var _h = jen_grid_height(_target);
	
	//Create a temporary grid to keep track of changes.
	var _temp_grid = jen_grid_create(_w, _h, noone);
	
	//Search for every find value in the base grid.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (jen_test(_target, xx, yy, _match_value) && _jenternal_percent(_chance_paste))
		{
			jen_grid_paste(_temp_grid, _paste,
				xx + _jenternal_convert_array_choose(_xoff),
				yy + _jenternal_convert_array_choose(_yoff),
				all);
		}
	} }
	
	//Paste the temporary grid to the base grid.
	jen_grid_paste(_target, _temp_grid, 0, 0, _replace, _chance, _setter);
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_number_paste(target_grid, paste_grid, match_value, x_offset, y_offset, replace, number, [chance], [setter]);
/// @func jen_number_paste
/// @desc Sets a new value some number of times, offset from a particular search value.
///				Values of 'noone' in the pasted grid(s) will be ignored.
/// @arg	{Id.DsGrid}		target_JenGrid
/// @arg  {Id.DsGrid}		paste_JenGrid		Supports Array (Chooses)
/// @arg  {Any}					match_value			Supports Array (Any Of)
/// @arg  {Real}				xcell_off				Supports Array (Any Of)
/// @arg  {Real}				ycell_off				Supports Array (Any Of)
/// @arg	{Real}				number
/// @arg  {Any}					replace					Supports Array (Any Of)
/// @arg  {Real}				[chance]				Default: 100
/// @arg  {Function}		[setter]				Default: jen_set
function jen_number_paste(_target, _paste, _match_value, _xoff, _yoff, _number, _replace, _chance = 100, _setter = jen_set)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_target);
	var _h = jen_grid_height(_target);
	var _temp = jen_grid_create(_w, _h, noone);
	
	//Create a list to store all the viable positions.
	var _positions = ds_list_create();
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (jen_test(_target, xx, yy, _match_value))
		{
			ds_list_add(_positions, { x1 : xx, y1 : yy });
		}
	} }
	
	//Pasting the paste grid specified number of times.
	ds_list_shuffle(_positions);
	var _size = ds_list_size(_positions);
	for (var i = 0; i < min(_number, _size); i++)
	{
		//Get the coordinates of this valid position.
		var xx = _positions[| i].x1 + _jenternal_convert_array_choose(_xoff);
		var yy = _positions[| i].y1 + _jenternal_convert_array_choose(_yoff);
		jen_grid_paste(_temp, _paste, xx, yy, all);
	}
	
	//Paste the final modified grid.
	jen_grid_paste(_target, _temp, 0, 0, _replace, _chance, _setter);
	
	//Clearing memory.
	ds_list_destroy(_positions);
	jen_grid_destroy(_temp);
}
#endregion