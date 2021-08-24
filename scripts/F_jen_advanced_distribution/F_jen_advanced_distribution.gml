//Advanced distribution functions. Scattering and heightmaps.

//Advanced scattering functions.
#region jen_scatter_offset(grid, find_value, x_offset, y_offset, replace, new_value, [chance], [function]);
/// @function jen_scatter_offset
/// @description Replaces some percentage of one value with another, offset by a search value.
/// @param grid
/// @param find_value
/// @param x_offset
/// @param y_offset
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_scatter_offset(_grid, _find_value, _xoff, _yoff, _replace, _new_value, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
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
/// @function jen_scatter_apply
/// @description Replaces some percentage of one value with the values of another grid with jen_apply.
/// @param target_grid
/// @param apply_grid
/// @param find_value
/// @param x_offset
/// @param y_offset
/// @param replace
/// @param [chance]
/// @param [function]
function jen_scatter_apply(_target, _apply, _find_value, _xoff, _yoff, _replace, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_target);
	var _height = jen_grid_height(_target);
	
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
/// @function jen_scatter_apply_list
/// @description Replaces some percentage of one value with the values of another grid with jen_apply.
/// @param target_grid
/// @param apply_list
/// @param find_value
/// @param x_offset
/// @param y_offset
/// @param replace
/// @param [chance]
/// @param [function]
function jen_scatter_apply_list(_target, _apply_list, _find_value, _xoff, _yoff, _replace, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_target);
	var _height = jen_grid_height(_target);
	
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
/// @function jen_number_offset
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
function jen_number_offset(_grid, _find_value, _xoff, _yoff, _replace, _new_value, _number, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
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
/// @function jen_number_apply
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
function jen_number_apply(_target, _apply, _find_value, _xoff, _yoff, _replace, _number, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_target);
	var _height = jen_grid_height(_target);
	
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
/// @function jen_number_apply_list
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
function jen_number_apply_list(_target, _apply_list, _find_value, _xoff, _yoff, _replace, _number, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_target);
	var _height = jen_grid_height(_target);
	
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
#region jen_automata(grid, living, empty, bounds, birth, death, [chance], [function]);
/// @function jen_automata
/// @description Applies cellular automata between two different values.
/// @param grid
/// @param living
/// @param empty
/// @param bounds
/// @param birth
/// @param death
/// @param [chance]
/// @param [function]
function jen_automata(_grid, _living, _empty, _bounds, _birth, _death, _chance = 100, _function = noone)
{
	//Initialize variables.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	var _temp = jen_grid_create(_width, _height);
	
	//Iterate through the grid.
	for (var yy = 0; yy < _height; yy ++) {
	for (var xx = 0; xx < _width; xx ++) {
		var count = 0;
		var cell = jen_get(_grid, xx, yy);

		//Counting the surrounding cells.
		if (_jenternal_test(_grid, xx + 1, yy + 0, _living, _bounds)) { count ++; }
		if (_jenternal_test(_grid, xx - 1, yy + 0, _living, _bounds)) { count ++; }
		if (_jenternal_test(_grid, xx + 0, yy + 1, _living, _bounds)) { count ++; }
		if (_jenternal_test(_grid, xx + 0, yy - 1, _living, _bounds)) { count ++; }
		if (_jenternal_test(_grid, xx + 1, yy + 1, _living, _bounds)) { count ++; }
		if (_jenternal_test(_grid, xx + 1, yy - 1, _living, _bounds)) { count ++; }
		if (_jenternal_test(_grid, xx - 1, yy + 1, _living, _bounds)) { count ++; }
		if (_jenternal_test(_grid, xx - 1, yy - 1, _living, _bounds)) { count ++; }
		
		if (cell == _living && count <= _death)
		{
			jen_set(_temp, xx, yy, all, _empty);
		}
		if (cell == _empty && count >= _birth)
		{
			jen_set(_temp, xx, yy, all, _living);
		}
	}	}
	
	jen_grid_apply(_grid, _temp, all, 0, 0, _chance, _function);
}
#endregion