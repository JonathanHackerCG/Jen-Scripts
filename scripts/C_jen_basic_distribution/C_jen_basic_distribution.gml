// Basic distribution functions. Scattering and replacing.

#region jen_replace(grid, replace, new_value);
/// @func jen_replace
/// @desc Replaces all of one value with another value.
/// @arg  grid
/// @arg  replace
/// @arg  new_value
function jen_replace(_grid, _replace, _new_value)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Looping through the grid to replace each matching value.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		jen_set(_grid, xx, yy, _replace, _new_value);
	} }
}
#endregion
#region jen_scatter(grid, replace, new_value, [chance], [function]);
/// @func jen_scatter
/// @desc Replaces some percentage of one value with another.
/// @arg  grid
/// @arg  replace
/// @arg  new_value
/// @arg  [chance]
/// @arg  [function]
function jen_scatter(_grid, _replace, _new_value, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Looping through the grid to replace each matching value.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (_chance >= 100 || random(100) < _chance)
		{
			if (_function == noone)
			{
				//Replace matching values.
				jen_set(_grid, xx, yy, _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, xx, yy) == _replace)
			{
				//Run the custom function.
				_function(_grid, xx, yy, _replace, _new_value);
			}
		}
	} }
}
#endregion
#region jen_number(grid, replace, new_value, number, [chance], [function]);
/// @func jen_number
/// @desc Changes a specific number of one value into another.
/// @arg  grid
/// @arg  replace
/// @arg  new_value
/// @arg  number
/// @arg  [chance]
/// @arg  [function]
function jen_number(_grid, _replace, _new_value, _number, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Create a list to store all the viable positions.
	var _positions = ds_list_create();
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (_replace == all || jen_get(_grid, xx, yy) == _replace)
		{
			var pos = { x1 : xx, y1 : yy };
			ds_list_add(_positions, pos);
		}
	} }
	
	//If there are less than the target number, replace all of them.
	if (ds_list_size(_positions) <= _number)
	{
		jen_scatter(_grid, _replace, _new_value, _chance, _function);
	}
	else //Changing a certain number of the positions.
	{
		ds_list_shuffle(_positions);
		for (var i = 0; i < _number; i++)
		{
			//Get the coordinates of this valid position.
			var xx = _positions[| i].x1;
			var yy = _positions[| i].y1;
			if (_chance >= 100 || random(100) < _chance)
			{
				if (_function == noone)
				{
					//Replace matching values.
					jen_set(_grid, xx, yy, _replace, _new_value);
				}
				else
				{
					//Run the custom function.
					_function(_grid, xx, yy, _replace, _new_value);
				}
			}
		}
	}
	
	//Clearing memory.
	var size = ds_list_size(_positions);
	for (var i = 0; i < size; i++)	{	delete _positions[| i];	}
	ds_list_destroy(_positions);
}
#endregion
#region jen_near(grid, near, replace, new_value, radius, [chance], [function]);
/// @func jen_near
/// @desc Changes all values that are within a radius of another value.
/// @arg  grid
/// @arg  near
/// @arg  replace
/// @arg  new_value
/// @arg  radius
/// @arg  [chance]
/// @arg  [function]
function jen_near(_grid, _near, _replace, _new_value, _radius, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Create a temporary grid to store changes.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Create circles around every matching value.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		//Finding matching values.
		if (jen_get(_grid, xx, yy) == _near)
		{
			//Set to an undefined value (to allow the jen_grid_apply to override noone).
			ds_grid_set_disk(_temp_grid, xx, yy, _radius, "_jenternal_undefined");
		}
	} }
	
	//Apply the temporary grid to the target grid.
	jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance, _function);
	jen_replace(_grid, "_jenternal_undefined", _new_value); //Replace with the intended value.
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_obfuscate(grid, value, [chance]);
/// @func jen_obfuscate
/// @desc Causes certain values to swap with values around them.
/// @arg  grid
/// @arg  value
/// @arg  [chance]
function jen_obfuscate(_grid, _value, _chance = 100)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Create a list of every position in the array.
	var _positions = ds_list_create();
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (_value == all || jen_get(_grid, xx, yy) == _value)
		{
			var pos = { x1 : xx, y1 : yy }
			ds_list_add(_positions, pos);
		}
	} }
	
	//Shuffle the list and go through each one in a random order.
	ds_list_shuffle(_positions);
	var xoff, yoff, xx, yy, temp, neo;
	var size = ds_list_size(_positions);
	for (var i = 0; i < size; i++)
	{
		if (_chance >= 100 || random(100) < _chance)
		{
			//Getting the position of this value in the grid.
			xx = _positions[| i].x1;
			yy = _positions[| i].y1;
			
			//Choosing an offset to attempt a swap.
			xoff = 0; yoff = 0;
			if (irandom(1)) { xoff = choose(-1, 1); }
			else { yoff = choose(-1, 1); }
			
			//Swapping values with adjacent value.
			neo = jen_get(_grid, xx + xoff, yy + yoff);
			if (neo != undefined)
			{
				temp = jen_get(_grid, xx, yy);
				jen_set(_grid, xx + xoff, yy + yoff, all, temp);
				jen_set(_grid, xx, yy, all, neo);
			}
		}
		
		//Delete the structs when finished with them.
		delete _positions[| i];
	}
	
	//Clearing memory.
	ds_list_destroy(_positions);
}
#endregion