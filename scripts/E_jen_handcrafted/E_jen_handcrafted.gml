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
#region jen_grid_paste(target_JenGrid, paste_JenGrid, replace, xcell, ycell, [chance], [function]);
/// @func jen_grid_paste(target_JenGrid, paste_JenGrid, replace, xcell, ycell, [chance], [function]):
/// @desc Transfer all values from applied grid to a target grid.
///				Values of 'noone' in the applied grid will be ignored.
/// @arg	{Id.DsGrid}		target_JenGrid
/// @arg  {Id.DsGrid}		paste_JenGrid
/// @arg	{Any}					replace			Supports Array (Any)
/// @arg	{Real}				xcell
/// @arg	{Real}				ycell
/// @arg  {Real}				[chance]		Default: 100
/// @arg  {Function}		[function]	Default: undefined
function jen_grid_paste(_target, _paste, _replace, _x1, _y1, _chance = 100, _function = undefined)
{
	//Getting width and height of the grids.
	var _width = jen_grid_width(_target);
	var _height = jen_grid_height(_target);
	var _width_paste = min(jen_grid_width(_paste), _width);
	var _height_paste = min(jen_grid_height(_paste), _height);
	
	//Array conversions.
	_replace = _jenternal_convert_replace(_replace);
	
	//Iterate through the application grid.
	var _value;
	for (var yy = 0; yy < _height_paste; yy ++) {
	for (var xx = 0; xx < _width_paste; xx ++)
	{
		//Get the value of the application grid.
		_value = jen_get(_paste, xx, yy);
		if (_value != noone) && (_chance >= 100 || random(100) < _chance)
		{
			if (_function == undefined)
			{
				//Directly set the target value to the application value.
				jen_set(_target, _x1 + xx, _y1 + yy, _replace, _value);
			}
			else if (_replace == all || jen_test(_target, xx, yy, _replace))
			{
				//Run the custom function.
				_function(_target, _x1 + xx, _y1 + yy, _replace, _value);
			}
		}
	} }
}
#endregion
#region jen_scatter_paste(target_grid, paste_grid, find_value, x_offset, y_offset, replace, [chance], [function]);
/// @func jen_scatter_paste
/// @desc Replaces some percentage of one value with the values of another grid with jen_paste.
/// @arg  target_grid
/// @arg  paste_grid
/// @arg  find_value
/// @arg  x_offset
/// @arg  y_offset
/// @arg  replace
/// @arg  [chance]
/// @arg  [function]
function jen_scatter_paste(_target, _paste, _find_value, _xoff, _yoff, _replace, _chance = 100, _function = undefined)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_target);
	var _height = jen_grid_height(_target);
	
	//Create a temporary grid to keep track of changes.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Search for every find value in the base grid.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (jen_get(_target, xx, yy) == _find_value)
		{
			if (_chance >= 100 || random(100) < _chance)
			{
				jen_grid_paste(_temp_grid, _paste, all, xx + _xoff, yy + _yoff);
			}
		}
	} }
	
	//paste the temporary grid to the base grid.
	jen_grid_paste(_target, _temp_grid, _replace, 0, 0, 100, _function);
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_number_paste(target_grid, paste_grid, find_value x_offset, y_offset, replace, number, [chance], [function]);
/// @func jen_number_paste
/// @desc Sets a new value some number of times, offset from a particular search value.
/// @arg  target_grid
/// @arg  paste_grid
/// @arg  find_values
/// @arg  x_offset
/// @arg  y_offset
/// @arg  replace
/// @arg  number
/// @arg  [chance]
/// @arg  [function]
function jen_number_paste(_target, _paste, _find_value, _xoff, _yoff, _replace, _number, _chance = 100, _function = undefined)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_target);
	var _height = jen_grid_height(_target);
	
	//Create a temporary grid to store the chances.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Create a list to store all the viable positions.
	var _positions = ds_list_create();
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (_replace == all || jen_get(_target, xx, yy) == _find_value)
		{
			var pos = { x1 : xx, y1 : yy };
			ds_list_add(_positions, pos);
		}
	} }
	
	//If there are less than the target number, replace all of them.
	if (ds_list_size(_positions) <= _number)
	{
		jen_scatter_paste(_target, _paste, _find_value, _xoff, _yoff, _replace, _chance, _function);
	}
	else //Changing a certain number of the positions.
	{
		ds_list_shuffle(_positions);
		for (var i = 0; i < _number; i++)
		{
			//Get the coordinates of this valid position.
			var xx = _positions[| i].x1;
			var yy = _positions[| i].y1;
			jen_grid_paste(_temp_grid, _paste, all, xx + _xoff, yy + _yoff);
		}
	}
	
	//paste the temporary grid to the base grid.
	jen_grid_paste(_target, _temp_grid, _replace, 0, 0, _chance, _function);
	
	//Clearing memory.
	var size = ds_list_size(_positions);
	for (var i = 0; i < size; i++)	{	delete _positions[| i];	}
	ds_list_destroy(_positions);
	jen_grid_destroy(_temp_grid);
}
#endregion
//TODO: Above scatter/number paste should support arrays for paste_grid parameter.