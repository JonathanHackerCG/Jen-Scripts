//General Jen_scripts functions. Initialization and grid transformations.

//Initialization and Getters/Setters
#region jen_grid_create(width, height, [cleared]);
/// @description Create a new jen_grid data structure.
/// @param width
/// @param height
/// @param [cleared]
function jen_grid_create(_width, _height, _cleared)
{
	//Get optional parameters.
	if (is_undefined(_cleared)) { _cleared = noone; }
	
	//Create and fill the new grid.
	var _grid = ds_grid_create(_width, _height);
	ds_grid_clear(_grid, _cleared);
	
	//Return the new grid id.
	return _grid;
}
#endregion
#region jen_grid_destroy(id);
/// @description Destroy a jen_grid.
/// @param id
function jen_grid_destroy(_grid)
{
	ds_grid_destroy(_grid);
}
#endregion
#region jen_get(id, x, y);
/// @description Return a value at a position. Returns undefined if it is out of bounds.
/// @param id
/// @param x
/// @param y
function jen_get(_grid, _x, _y)
{
	//Check if it is out of bounds, otherwise return the value directly.
	if (_x < 0 || _y < 0 || _x >= ds_grid_width(_grid) || _y >= ds_grid_height(_grid)) { return undefined; }
	return _grid[# _x, _y];
}
#endregion
#region jen_set(id, x, y, replace, new_value);
/// @description Set a value at a position.
/// @param id
/// @param x
/// @param y
/// @param replace
/// @param new_value
function jen_set(_grid, _x, _y, _replace, _new_value)
{
	//Checking if it is out of bounds, otherwise attempt to set the value.
	if (_x < 0 || _y < 0 || _x >= ds_grid_width(_grid) || _y >= ds_grid_height(_grid)) { return false; }
	if (_replace == all || _grid[# _x, _y] == _replace)
	{
		//Setting the new value.
		_grid[# _x, _y] = _new_value;
		return true;
	}
	return false;
}
#endregion

//Transformation
#region jen_grid_apply(target_grid, apply_grid, replace, x1, y1, [chance], [function]);
/// @description Applies one grid onto another, transfering all filled values to the target.
/// @param target_grid
/// @param apply_grid
/// @param replace
/// @param x1
/// @param y1
/// @param [chance]
/// @param [function]
function jen_grid_apply(_target, _apply, _replace, _x1, _y1, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		info = {};
		info.x1 = _x1; info.y1 = _y1;
		info.replace = _replace;
		info.chance = _chance;
	}
	
	//Getting width and height of the grids.
	var _width = ds_grid_width(_target);
	var _height = ds_grid_height(_target);
	var _width_apply = min(ds_grid_width(_apply), _width);
	var _height_apply = min(ds_grid_height(_apply), _height);
	
	//Iterate through the application grid.
	var _value;
	for (var yy = 0; yy < _height_apply; yy ++) {
	for (var xx = 0; xx < _width_apply; xx ++)
	{
		//Get the value of the application grid.
		_value = jen_get(_apply, xx, yy);
		if (_value != noone) && (_chance == 100 || random(100) < _chance)
		{
			if (_function == noone)
			{
				//Directly set the target value to the application value.
				jen_set(_target, _x1 + xx, _y1 + yy, _replace, _value);
			}
			else if (_replace == all || jen_get(_target, xx, yy) == _replace)
			{
				//Run the custom function.
				_function(_target, _x1 + xx, _y1 + yy, info);
			}
		}
	} }
	delete info;
}
#endregion

//Debugging Functions
#region jen_grid_string(id);
/// @description Returns the jen_grid formatted as a string.
/// @param id
function jen_grid_string(_grid)
{
	//Getting width and height of the grid.
	var _width = ds_grid_width(_grid);
	var _height = ds_grid_height(_grid);
	
	//Looping through the grid to build the string.
	var _output = "";
	for (var yy = 0; yy < _height; yy++)
	{
		for (var xx = 0; xx < _width; xx++)
		{
			_output += string(jen_get(_grid, xx, yy));
			_output += " ";
		}
		_output += "\n";
	}
	
	//Return the final string.
	return _output;
}
#endregion
#region jen_grid_draw(id, x, y);
/// @description Draws the data within the grid, using jen_grid_string.
/// @param id
/// @param x
/// @param y
function jen_grid_draw(_grid, _x1, _y1)
{
	var _text = jen_grid_string(_grid);
	draw_text(_x1, _y1, _text);
}
#endregion