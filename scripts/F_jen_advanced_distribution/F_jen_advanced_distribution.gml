//Advanced distribution functions. Scattering and heightmaps.

//Advanced scattering functions.
#region jen_scatter_offset(JenGrid, find_value, x_offset, y_offset, replace, new_value, [chance], [function]);
/// @func jen_scatter_offset
/// @desc Replaces some percentage of one value with another, offset by a search value.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  find_value
/// @arg  x_offset
/// @arg  y_offset
/// @arg  replace
/// @arg  new_value
/// @arg  [chance]
/// @arg  [function]
function jen_scatter_offset(_grid, _find_value, _xoff, _yoff, _replace, _new_value, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Create a temporary grid to keep track of changes.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Search for every find value in the base grid.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (jen_get(_grid, xx, yy) == _find_value)
		{
			jen_set(_temp_grid, xx + _xoff, yy + _yoff, all, "_jenternal_undefined");
		}
	} }
	
	//Apply the temporary grid to the base grid.
	jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance, _function);
	jen_replace(_grid, "_jenternal_undefined", _new_value); //Replace with the intended value.
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_scatter_apply(target_grid, apply_grid, find_value, x_offset, y_offset, replace, [chance], [function]);
/// @func jen_scatter_apply
/// @desc Replaces some percentage of one value with the values of another grid with jen_apply.
/// @arg  target_grid
/// @arg  apply_grid
/// @arg  find_value
/// @arg  x_offset
/// @arg  y_offset
/// @arg  replace
/// @arg  [chance]
/// @arg  [function]
function jen_scatter_apply(_target, _apply, _find_value, _xoff, _yoff, _replace, _chance = 100, _function = noone)
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
/// @func jen_scatter_apply_list
/// @desc Replaces some percentage of one value with the values of another grid with jen_apply.
/// @arg  target_grid
/// @arg  apply_list
/// @arg  find_value
/// @arg  x_offset
/// @arg  y_offset
/// @arg  replace
/// @arg  [chance]
/// @arg  [function]
function jen_scatter_apply_list(_target, _apply_list, _find_value, _xoff, _yoff, _replace, _chance = 100, _function = noone)
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
#region jen_number_offset(JenGrid, find_value x_offset, y_offset, replace, new_value, number, [chance], [function]);
/// @func jen_number_offset
/// @desc Sets a new value some number of times, offset from a particular search value.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  find_values
/// @arg  x_offset
/// @arg  y_offset
/// @arg  replace
/// @arg  new_value
/// @arg  number
/// @arg  [chance]
/// @arg  [function]
function jen_number_offset(_grid, _find_value, _xoff, _yoff, _replace, _new_value, _number, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Create a temporary grid to store the chances.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Create a list to store all the viable positions.
	var _positions = ds_list_create();
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
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
			jen_set(_temp_grid, xx + _xoff, yy + _yoff, all, "_jenternal_undefined");
		}
	}
	
	//Apply the temporary grid to the base grid.
	jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance, _function);
	jen_replace(_grid, "_jenternal_undefined", _new_value); //Replace with the intended value.
	
	//Clearing memory.
	var size = ds_list_size(_positions);
	for (var i = 0; i < size; i++)	{	delete _positions[| i];	}
	ds_list_destroy(_positions);
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_number_apply(target_grid, apply_grid, find_value x_offset, y_offset, replace, number, [chance], [function]);
/// @func jen_number_apply
/// @desc Sets a new value some number of times, offset from a particular search value.
/// @arg  target_grid
/// @arg  apply_grid
/// @arg  find_values
/// @arg  x_offset
/// @arg  y_offset
/// @arg  replace
/// @arg  number
/// @arg  [chance]
/// @arg  [function]
function jen_number_apply(_target, _apply, _find_value, _xoff, _yoff, _replace, _number, _chance = 100, _function = noone)
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
/// @func jen_number_apply_list
/// @desc Sets a new value some number of times, offset from a particular search value.
/// @arg  target_grid
/// @arg  apply_list
/// @arg  find_values
/// @arg  x_offset
/// @arg  y_offset
/// @arg  replace
/// @arg  number
/// @arg  [chance]
/// @arg  [function]
function jen_number_apply_list(_target, _apply_list, _find_value, _xoff, _yoff, _replace, _number, _chance = 100, _function = noone)
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
#region jen_automata(JenGrid, living, empty, bounds, birth, death, [chance], [function]);
/// @func jen_automata
/// @desc Applies cellular automata between two different values.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  living
/// @arg  empty
/// @arg  bounds
/// @arg  birth
/// @arg  death
/// @arg  [chance]
/// @arg  [function]
function jen_automata(_grid, _living, _empty, _bounds, _birth, _death, _chance = 100, _function = noone)
{
	//Initialize variables.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
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
			jen_set(_temp, xx, yy, all, "_jenternal_empty");
		}
		if (cell == _empty && count >= _birth)
		{
			jen_set(_temp, xx, yy, all, "_jenternal_living");
		}
	}	}
	
	jen_grid_apply(_grid, _temp, all, 0, 0, _chance, _function);
	jen_replace(_grid, "_jenternal_empty", _empty);
	jen_replace(_grid, "_jenternal_living", _living);
	jen_grid_destroy(_temp);
}
#endregion