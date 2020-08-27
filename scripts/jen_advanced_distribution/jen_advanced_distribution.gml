//Advanced distribution functions. Scattering and heightmaps.

//Advanced scattering functions.
#region jen_scatter_offset(grid, find_value, x_offset, y_offset, replace, new_value, [chance], [function]);
/// @description Replaces some percentage of one value with another, offset by a search value.
/// @param grid
/// @param find_value
/// @param x_offset
/// @param y_offset
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_scatter_offset(_grid, _find_value, _xoff, _yoff, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
	//Getting width and height of the grid.
	var _width = ds_grid_width(_grid);
	var _height = ds_grid_height(_grid);
	
	//Create a temporary grid to keep track of changes.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Search for every find value in the base grid.
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
	{
		if (jen_get(_grid, xx, yy) == _find_value)
		{
			jen_set(_temp_grid, xx + _xoff, yy + _yoff, all, _new_value);
		}
	} }
	
	//Apply the temporary grid to the base grid.
	jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance, _function);
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_scatter_apply(target_grid, apply_grid, find_value, x_offset, y_offset, replace, [chance], [function]);
/// @description Replaces some percentage of one value with the values of another grid with jen_apply.
/// @param target_grid
/// @param apply_grid
/// @param find_value
/// @param x_offset
/// @param y_offset
/// @param replace
/// @param [chance]
/// @param [function]
function jen_scatter_apply(_target, _apply, _find_value, _xoff, _yoff, _replace, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
	//Getting width and height of the grid.
	var _width = ds_grid_width(_target);
	var _height = ds_grid_height(_target);
	
	//Create a temporary grid to keep track of changes.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Search for every find value in the base grid.
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
	{
		if (jen_get(_target, xx, yy) == _find_value)
		{
			if (_chance >= 100 || random(100) < _chance)
			{
				jen_grid_apply(_temp_grid, _apply, all, xx + _xoff, yy + _yoff);
			}
		}
	} }
	
	//Apply the temporary grid to the base grid.
	jen_grid_apply(_target, _temp_grid, _replace, 0, 0, 100, _function);
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_scatter_apply_list(target_grid, apply_list, find_value, x_offset, y_offset, replace, [chance], [function]);
/// @description Replaces some percentage of one value with the values of another grid with jen_apply.
/// @param target_grid
/// @param apply_list
/// @param find_value
/// @param x_offset
/// @param y_offset
/// @param replace
/// @param [chance]
/// @param [function]
function jen_scatter_apply_list(_target, _apply_list, _find_value, _xoff, _yoff, _replace, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
	//Getting width and height of the grid.
	var _width = ds_grid_width(_target);
	var _height = ds_grid_height(_target);
	
	//Create a temporary grid to keep track of changes.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Search for every find value in the base grid.
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
	{
		if (jen_get(_target, xx, yy) == _find_value)
		{
			if (_chance >= 100 || random(100) < _chance)
			{
				var size = ds_list_size(_apply_list);
				var _apply = _apply_list[| irandom(size - 1)];
				jen_grid_apply(_temp_grid, _apply, all, xx + _xoff, yy + _yoff);
			}
		}
	} }
	
	//Apply the temporary grid to the base grid.
	jen_grid_apply(_target, _temp_grid, _replace, 0, 0, 100, _function);
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_number_offset(grid, find_value x_offset, y_offset, replace, new_value, number, [chance], [function]);
/// @description Sets a new value some number of times, offset from a particular search value.
/// @param grid
/// @param find_values
/// @param x_offset
/// @param y_offset
/// @param replace
/// @param new_value
/// @param number
/// @param [chance]
/// @param [function]
function jen_number_offset(_grid, _find_value, _xoff, _yoff, _replace, _new_value, _number, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
	//Getting width and height of the grid.
	var _width = ds_grid_width(_grid);
	var _height = ds_grid_height(_grid);
	
	//Create a temporary grid to store the chances.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Create a list to store all the viable positions.
	var _positions = ds_list_create();
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
	{
		if (_replace == all || jen_get(_grid, xx, yy) == _find_value)
		{
			var pos = { x1 : xx, y1 : yy };
			ds_list_add(_positions, pos);
		}
	} }
	
	//If there are less than the target number, replace all of them.
	if (ds_list_size(_positions) <= _number)
	{
		jen_scatter_offset(_grid, _find_value, _xoff, _yoff, _replace, _new_value, _chance, _function);
	}
	else //Changing a certain number of the positions.
	{
		ds_list_shuffle(_positions);
		for (var i = 0; i < _number; i++)
		{
			//Get the coordinates of this valid position.
			var xx = _positions[| i].x1;
			var yy = _positions[| i].y1;
			jen_set(_temp_grid, xx + _xoff, yy + _yoff, all, _new_value);
		}
	}
	
	//Apply the temporary grid to the base grid.
	if (_function == noone) { jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance); }
	else { jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance, _function); }	
	
	//Clearing memory.
	var size = ds_list_size(_positions);
	for (var i = 0; i < size; i++)	{	delete _positions[| i];	}
	ds_list_destroy(_positions);
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_number_apply(target_grid, apply_grid, find_value x_offset, y_offset, replace, number, [chance], [function]);
/// @description Sets a new value some number of times, offset from a particular search value.
/// @param target_grid
/// @param apply_grid
/// @param find_values
/// @param x_offset
/// @param y_offset
/// @param replace
/// @param number
/// @param [chance]
/// @param [function]
function jen_number_apply(_target, _apply, _find_value, _xoff, _yoff, _replace, _number, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
	//Getting width and height of the grid.
	var _width = ds_grid_width(_target);
	var _height = ds_grid_height(_target);
	
	//Create a temporary grid to store the chances.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Create a list to store all the viable positions.
	var _positions = ds_list_create();
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
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
		jen_scatter_apply(_target, _apply, _find_value, _xoff, _yoff, _replace, _chance, _function);
	}
	else //Changing a certain number of the positions.
	{
		ds_list_shuffle(_positions);
		for (var i = 0; i < _number; i++)
		{
			//Get the coordinates of this valid position.
			var xx = _positions[| i].x1;
			var yy = _positions[| i].y1;
			jen_grid_apply(_temp_grid, _apply, all, xx + _xoff, yy + _yoff);
		}
	}
	
	//Apply the temporary grid to the base grid.
	jen_grid_apply(_target, _temp_grid, _replace, 0, 0, _chance, _function);
	
	//Clearing memory.
	var size = ds_list_size(_positions);
	for (var i = 0; i < size; i++)	{	delete _positions[| i];	}
	ds_list_destroy(_positions);
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_number_apply_list(target_grid, apply_list, find_value x_offset, y_offset, replace, number, [chance], [function]);
/// @description Sets a new value some number of times, offset from a particular search value.
/// @param target_grid
/// @param apply_list
/// @param find_values
/// @param x_offset
/// @param y_offset
/// @param replace
/// @param number
/// @param [chance]
/// @param [function]
function jen_number_apply_list(_target, _apply_list, _find_value, _xoff, _yoff, _replace, _number, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
	//Getting width and height of the grid.
	var _width = ds_grid_width(_target);
	var _height = ds_grid_height(_target);
	
	//Create a temporary grid to store the chances.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Create a list to store all the viable positions.
	var _positions = ds_list_create();
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
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
		jen_scatter_apply_list(_target, _apply_list, _find_value, _xoff, _yoff, _replace, _chance, _function);
	}
	else //Changing a certain number of the positions.
	{
		ds_list_shuffle(_positions);
		for (var i = 0; i < _number; i++)
		{
			//Get the coordinates of this valid position.
			var xx = _positions[| i].x1;
			var yy = _positions[| i].y1;
			
			//Apply a random grid from the apply list.
			var size = ds_list_size(_apply_list);
			var _apply = _apply_list[| irandom(size - 1)];
			jen_grid_apply(_temp_grid, _apply, all, xx + _xoff, yy + _yoff);
		}
	}
	
	//Apply the temporary grid to the base grid.
	jen_grid_apply(_target, _temp_grid, _replace, 0, 0, _chance, _function);
	
	//Clearing memory.
	var size = ds_list_size(_positions);
	for (var i = 0; i < size; i++)	{	delete _positions[| i];	}
	ds_list_destroy(_positions);
	jen_grid_destroy(_temp_grid);
}
#endregion

//Heightmaps.
#region jen_heightmap_create(width, height);
/// @description Creates a new empty heightmap.
/// @param width
/// @param height
function jen_heightmap_create(_width, _height)
{
	var _grid = ds_grid_create(_width, _height);
	ds_grid_clear(_grid, 0);
	return _grid;
}
#endregion
#region jen_heightmap_destroy(heightmap);
/// @description Destroys a heightmap.
/// @param heightmap
function jen_heightmap_destroy(_heightmap)
{
	ds_grid_destroy(_heightmap);
}
#endregion
#region jen_heightmap_get(heightmap, x1, y1);
/// @description Returns the value of a heightmap at a position.
/// @param heightmap
/// @param x1
/// @param y1
function jen_heightmap_get(_heightmap, _x, _y)
{
	//Check if it is out of bounds, otherwise return the value directly.
	if (_x < 0 || _y < 0 || _x >= ds_grid_width(_heightmap) || _y >= ds_grid_height(_heightmap)) { return undefined; }
	return _heightmap[# _x, _y];
}
#endregion
#region jen_heightmap_set(heightmap, x1, y1, value);
/// @description 
/// @param heightmap
/// @param x1
/// @param y1
/// @param value
function jen_heightmap_set(_heightmap, _x, _y, _value)
{
	//Checking if it is out of bounds, otherwise attempt to set the value.
	if (_x < 0 || _y < 0 || _x >= ds_grid_width(_heightmap) || _y >= ds_grid_height(_heightmap)) { return false; }

	//Setting the new value.
	_heightmap[# _x, _y] = _value;
	return true;
}
#endregion
#region jen_heightmap_draw(heightmap, x1, y1);
/// @description Displays the values of a heightmap.
/// @param heightmap
/// @param x1
/// @param y1
function jen_heightmap_draw(_heightmap, _x1, _y1)
{
	//Getting the width and height of the heightmap.
	var _width = ds_grid_width(_heightmap);
	var _height = ds_grid_height(_heightmap);
	
	//Drawing each cell of the heightmap.
	var scale = 8;
	for (var yy = 0; yy < _height; yy ++) {
	for (var xx = 0; xx < _width; xx ++)
	{
		draw_set_alpha(jen_heightmap_get(_heightmap, xx, yy));
		draw_rectangle(_x1 + (xx * scale), _y1 + (yy * scale), _x1 + (xx * scale) + scale - 1, _y1 + (yy * scale) + scale - 1, false);
	} }
	draw_set_alpha(1.0);
}
#endregion
#region jen_heightmap_sampling(width, height, radius, iterations);
/// @description Generates a new heightmap using average sampling.
/// @param width
/// @param height
/// @param range
/// @param iterations
function jen_heightmap_sampling(_width, _height, _range, _iterations)
{
	//Create two new heightmaps.
	var _heightmap_new = jen_heightmap_create(_width, _height);
	var _heightmap_temp = jen_heightmap_create(_width, _height);

	//Fill with random values.
	for (var yy = 0; yy < _height; yy ++) {
	for (var xx = 0; xx < _width; xx ++) {
		jen_heightmap_set(_heightmap_new, xx, yy, irandom(1.0));
	} xx = 0; }

	repeat(_iterations)
	{
		//Loop through finding the average for every position.
		for (var yy = 0; yy < _height; yy ++) {
		for (var xx = 0; xx < _width; xx ++) {
			var val = ds_grid_get_disk_mean(_heightmap_new, xx, yy, _range);
			jen_heightmap_set(_heightmap_temp, xx, yy, val);
		} }
		ds_grid_copy(_heightmap_new, _heightmap_temp);
	}

	//Normalize the final heightmap and return the id.
	ds_grid_destroy(_heightmap_temp);
	jen_heightmap_normalize(_heightmap_new);
	return _heightmap_new;
}
#endregion
#region jen_heightmap_gradient(width, height, radius, density);
/// @description 
/// @param width
/// @param height
/// @param radius
/// @param density
function jen_heightmap_gradient(_width, _height, _radius, _density)
{
	//Create the empty heightmap.
	var _heightmap = jen_heightmap_create(_width, _height);
	
	//Build a gradient of the appropriate size.
	var _diameter = (_radius * 2) + 1;
	var _gradient = jen_heightmap_create(_diameter, _diameter);
	for (var yy = 0; yy < _diameter; yy++) {
	for (var xx = 0; xx < _diameter; xx++)
	{
		var val = _radius - point_distance(xx, yy, _radius, _radius);
		if (val > 0) { jen_heightmap_set(_gradient, xx, yy, val); }
	} }
	
	//Add radient circles randomly across the heightmap.
	repeat(_density * _width * _height)
	{
		var x1 = irandom_range(-_radius, _width - 1 + _radius);
		var y1 = irandom_range(-_radius, _height - 1 + _radius);
		
		//Loop through each value of the gradient circle.
		for (var yy = 0; yy < _diameter; yy++) {
		for (var xx = 0; xx < _diameter; xx++)
		{
			var val = jen_heightmap_get(_heightmap, x1 - _radius + xx, y1 - _radius + yy);
			if (val != undefined) { jen_heightmap_set(_heightmap, x1 - _radius + xx, y1 - _radius + yy, val + jen_heightmap_get(_gradient, xx, yy)); }
		} }
	}
	
	//Normalize the final result and return.
	jen_heightmap_normalize(_heightmap);
	return _heightmap;
}
#endregion
#region jen_heightmap_apply(grid, heightmap, x1, y1, min, max, replace, new_value, [chance], [function]);
/// @description Converts a range of values in a heightmap to values in a grid.
/// @param grid
/// @param heightmap
/// @param x1
/// @param y1
/// @param min
/// @param max
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_heightmap_apply(_grid, _heightmap, _x1, _y1, _min, _max, _replace, _new_value, _chance, _function)
{
	//Getting the width and height of the heightmap.
	var _width = ds_grid_width(_heightmap);
	var _height = ds_grid_height(_heightmap);
	
	//Create a temporary grid for storing the changes.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Checking each value in the heightmap.
	for (var yy = 0; yy < _height; yy ++) {
	for (var xx = 0; xx < _width; xx ++) {
		var val = jen_heightmap_get(_heightmap, xx, yy);
		if (val >= _min && val <= _max)
		{
			jen_set(_temp_grid, xx, yy, all, _new_value);
		}
	} }
	
	//Apply the changes to the base grid.
	jen_grid_apply(_grid, _temp_grid, _replace, _x1, _y1, _chance, _function);
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_heightmap_normalize(heightmap)
/// @description Maps all values in a heightmap to a scale between 0.0 and 1.0.
/// @param heightmap
function jen_heightmap_normalize(_heightmap)
{
	//Getting the width and height of the heightmap.
	var _width = ds_grid_width(_heightmap);
	var _height = ds_grid_height(_heightmap);
	
	//Find the maximum and minimum.
	var _max = ds_grid_get_max(_heightmap, 0, 0, _width - 1, _height - 1);
	var _min = ds_grid_get_min(_heightmap, 0, 0, _width - 1, _height - 1);
	
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
	{
		var _value = (jen_heightmap_get(_heightmap, xx, yy) - _min) / (_max - _min);
		jen_heightmap_set(_heightmap, xx, yy, _value);
	} }
}
#endregion