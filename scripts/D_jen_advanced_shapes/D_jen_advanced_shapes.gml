//Advanced shapes, wandering lines and mazes.

//Wandering lines.
#region jen_wander_direction(grid, x1, y1, initial_angle, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [function]);
/// @func jen_wander_direction
/// @desc Will create a wandering line between two positions.
/// @arg  grid
/// @arg  x1
/// @arg  y1
/// @arg  initial_angle
/// @arg  correction_count
/// @arg  correction_accuracy
/// @arg  adjustment_count
/// @arg  adjustment_accuracy
/// @arg  lifetime
/// @arg  replace
/// @arg  new_value
/// @arg  [chance]
/// @arg  [function]
function jen_wander_direction(_grid, _x1, _y1, _initial_angle, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance = 100, _function = noone)
{
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = _initial_angle + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_chance >= 100 || random(100) < _chance)
		{
			if (_function == noone)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				//Run the custom function.
				_function(_grid, round(xx), round(yy), _replace, _new_value);
			}
		}
		
		//Updating primary angle.
		if (_correction_count == 0 || _count % _correction_count == 0)
		{
			_angle = _initial_angle + irandom_range(-_correction_accuracy, _correction_accuracy);
		}
		//Updating movement angle.
		if (_adjustment_count == 0 || _count % _adjustment_count == 0)
		{
			var _angle_off = irandom_range(-_adjustment_accuracy, _adjustment_accuracy);
		}
		_angle += _angle_off;
		
		//Calculating a new position.
		xx += lengthdir_x(1, _angle);
		yy += lengthdir_y(1, _angle);

		_count++; //Increment the count.
	}
}
#endregion
#region jen_wander_line(grid, x1, y1, x2, y2, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [function]);
/// @func jen_wander_line
/// @desc Will create a wandering line between two positions.
/// @arg  grid
/// @arg  x1
/// @arg  y1
/// @arg  x2
/// @arg  y2
/// @arg  correction_count
/// @arg  correction_accuracy
/// @arg  adjustment_count
/// @arg  adjustment_accuracy
/// @arg  lifetime
/// @arg  replace
/// @arg  new_value
/// @arg  [chance]
/// @arg  [function]
function jen_wander_line(_grid, _x1, _y1, _x2, _y2, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance = 100, _function = noone)
{
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = point_direction(_x1, _y1, _x2, _y2) + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_chance >= 100 || random(100) < _chance)
		{
			if (_function == noone)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				//Run the custom function.
				_function(_grid, round(xx), round(yy), _replace, _new_value);
			}
		}
		
		//Updating primary angle.
		if (_correction_count == 0 || _count % _correction_count == 0)
		{
			_angle = point_direction(xx, yy, _x2, _y2) + irandom_range(-_correction_accuracy, _correction_accuracy);
		}
		//Updating movement angle.
		if (_adjustment_count == 0 || _count % _adjustment_count == 0)
		{
			var _angle_off = irandom_range(-_adjustment_accuracy, _adjustment_accuracy);
		}
		
		//Moving directly to the target.
		if (point_distance(xx, yy, _x2, _y2) <= max(_correction_count, _adjustment_count))
		{
			_angle = point_direction(xx, yy, _x2, _y2);
		}
		
		_angle += _angle_off;
		
		//Calculating a new position.
		xx += lengthdir_x(1, _angle);
		yy += lengthdir_y(1, _angle);
		
		_count++; //Increment the count.
		
		//Exit early if it has reached the destination.
		if (point_distance(xx, yy, _x2, _y2) <= 0.5) { exit; }
	}
}
#endregion

//Handcrafted content (room functions).
#region jen_grid_room();
/// @func jen_grid_room
/// @desc Will convert the instances of the current room into a new jen_grid.
function jen_grid_room()
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
#region jen_grid_room_part(x1, y1, width, height);
/// @func jen_grid_room_part
/// @desc Converts a region of the room into a new jen_grid.
/// @arg  x1
/// @arg  y1
/// @arg  width
/// @arg  height
function jen_grid_room_part(_x1, _y1, _width, _height)
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
#region jen_grid_room_array(x1, y1, width, height, rooms_w, rooms_h, [xspace], [yspace]);
/// @func jen_grid_room_array
/// @desc Divides the current room into a grid, and outputs a list of jen_grids.
/// @arg  x1
/// @arg  y1
/// @arg  width
/// @arg  height
/// @arg  rooms_w
/// @arg  rooms_h
/// @arg  [xspace]
/// @arg  [yspace]
function jen_grid_room_array(_x1, _y1, _width, _height, _rooms_w, _rooms_h, _xspace = 0, _yspace = 0)
{
	var _xgrid = JEN_CELLW;
	var _ygrid = JEN_CELLH;
	var _list = ds_list_create();
	
	//Iterate through entire grid
	for (var yy = 0; yy < _rooms_h; yy ++) {
	for (var xx = 0; xx < _rooms_w; xx ++)
	{
		var _grid = jen_grid_room_part((_x1 + _xspace + (xx * (_xspace + _width))),
			(_y1 + _yspace + (yy * (_yspace + _height))), _width, _height, _xgrid, _ygrid);
		ds_list_add(_list, _grid);
	} }
	
	return _list;
}
#endregion