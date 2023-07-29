// Basic distribution functions. Scattering and replacing.

#region jen_replace(JenGrid, replace, new_value);
/// @func jen_replace(JenGrid, replace, new_value):
/// @desc Replaces all matching values with a new value.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Any}					replace			Supports Array (Any)
/// @arg	{Any}					new_value		Supports Array (Choose)
function jen_replace(_grid, _replace, _new_value)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Array conversions.
	_replace = _jenternal_convert_replace(_replace);
	
	//Looping through the grid to replace each matching value.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		jen_set(_grid, xx, yy, _replace, _new_value);
	} }
}
#endregion
#region NEW jen_replace_not(JenGrid, replace, new_value);
/// @func jen_replace_not(JenGrid, replace, new_value):
/// @desc Replaces all NOT matching values with a new value.
/// @arg  {Id.DsGrid}		JenGrid
/// @arg  {Any}					replace			Supports Array (Any)
/// @arg  {Any}					new_value		Supports Array (Choose)
function jen_replace_not(_grid, _replace, _new_value)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Array conversions.
	_replace = _jenternal_convert_replace(_replace);
	
	//Looping through the grid to replace each matching value.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		jen_set_not(_grid, xx, yy, _replace, _new_value);
	} }
}
#endregion
#region jen_scatter(JenGrid, replace, new_value, [chance], [function]);
/// @func jen_scatter(JenGrid, replace, new_value, [chance], [function]):
/// @desc Replaces some percentage of matching values with a new value.
/// @arg  {Id.DsGrid}		JenGrid
/// @arg  {Any}					replace			Supports Array (Any)
/// @arg  {Any}					new_value		Supports Array (Choose)
/// @arg  {Real}				[chance]		Default: 100
/// @arg  {Function}		[function]	Default: undefined
function jen_scatter(_grid, _replace, _new_value, _chance = 100, _function = undefined)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Array conversions.
	_replace = _jenternal_convert_replace(_replace);
	
	//Looping through the grid to replace each matching value.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (_chance >= 100 || random(100) < _chance)
		{
			if (_function == undefined)
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
	} }
}
#endregion
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
function jen_scatter_offset(_grid, _find_value, _xoff, _yoff, _replace, _new_value, _chance = 100, _function = undefined)
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
	jen_grid_paste(_grid, _temp_grid, _replace, 0, 0, _chance, _function);
	jen_replace(_grid, "_jenternal_undefined", _new_value); //Replace with the intended value.
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_number(JenGrid, replace, new_value, number, [chance], [function]);
/// @func jen_number(JenGrid, replace, new_value, number, [chance], [function]):
/// @desc Replaces a specific number of matching values with a new value.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  {Any}					replace			Supports Array (Any)
/// @arg  {Any}					new_value		Supports Array (Choose)
/// @arg	{Real}				number
/// @arg  {Real}				[chance]		Default: 100
/// @arg  {Function}		[function]	Default: undefined
function jen_number(_grid, _replace, _new_value, _number, _chance = 100, _function = undefined)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Array conversions.
	_replace = _jenternal_convert_replace(_replace);
	
	//Create a list to store all the viable positions.
	var _positions = ds_list_create();
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		if (_replace == all || jen_test(_grid, xx, yy, _replace))
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
				if (_function == undefined)
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
	ds_list_destroy(_positions);
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
function jen_number_offset(_grid, _find_value, _xoff, _yoff, _replace, _new_value, _number, _chance = 100, _function = undefined)
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
	jen_grid_paste(_grid, _temp_grid, _replace, 0, 0, _chance, _function);
	jen_replace(_grid, "_jenternal_undefined", _new_value); //Replace with the intended value.
	
	//Clearing memory.
	var size = ds_list_size(_positions);
	for (var i = 0; i < size; i++)	{	delete _positions[| i];	}
	ds_list_destroy(_positions);
	jen_grid_destroy(_temp_grid);
}
#endregion

//Extras
#region jen_near(JenGrid, target, replace, new_value, radius, [chance], [function]);
/// @func jen_near(JenGrid, target, replace, new_value, radius, [chance], [function]):
/// @desc Replaces all matching values with a new value, within radius distance of matching target values.
/// @arg  {Id.DsGrid}		JenGrid
/// @arg  {Any}					target			Supports Array (Any)
/// @arg  {Any}					replace			Supports Array (Any)
/// @arg  {Any}					new_value		Supports Array (Chooses)
/// @arg  {Real}				radius
/// @arg  {Real}				[chance]		Default: 100
/// @arg  {Function}		[function]	Default: undefined
function jen_near(_grid, _target, _replace, _new_value, _radius, _chance = 100, _function = undefined)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Array conversions.
	_replace = _jenternal_convert_replace(_replace);
	_target = _jenternal_convert_replace(_target);
	
	//Create a temporary grid to store changes.
	var _temp_grid = jen_grid_create(_w, _h, noone);
	
	//Create circles around every matching value.
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		//Finding matching values.
		if (jen_test(_grid, xx, yy, _target))
		{
			//Set to an undefined value (to allow the jen_grid_paste to override noone).
			ds_grid_set_disk(_temp_grid, xx, yy, _radius, "_jenternal_undefined");
		}
	} }
	
	//Apply the temporary grid to the target grid.
	jen_grid_paste(_grid, _temp_grid, _replace, 0, 0, _chance, _function);
	jen_replace(_grid, "_jenternal_undefined", _new_value); //Replace with the intended value.
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_obfuscate(JenGrid, value, [chance]);
/// @func jen_obfuscate
/// @desc Causes certain values to swap with values around them.
/// @arg	{Id.DsGrid}		JenGrid
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
function jen_automata(_grid, _living, _empty, _bounds, _birth, _death, _chance = 100, _function = undefined)
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
	
	jen_grid_paste(_grid, _temp, all, 0, 0, _chance, _function);
	jen_replace(_grid, "_jenternal_empty", _empty);
	jen_replace(_grid, "_jenternal_living", _living);
	jen_grid_destroy(_temp);
}
#endregion
#region jen_fill(JenGrid, x1, y1, replace, new_value, diagonal);
/// @func jen_fill
/// @desc Fills a space of matching values. May cross diagonals or not.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  replace
/// @arg  new_value
/// @arg  diagonal
function jen_fill(_grid, xx, yy, _replace, _new_value, _diagonal)
{
	//Attempt to set the starting position. Only runs if this part works.
	if (jen_set(_grid, xx, yy, _replace, _new_value))
	{
		//Create a queue to keep track of every position to fill.
		var _Qx = ds_queue_create();
		var _Qy = ds_queue_create();
		
		//Add the initial point to the queue.
		ds_queue_enqueue(_Qx, xx);
		ds_queue_enqueue(_Qy, yy);
		
		//In theory, the x and y queue should always be the same size.
		while (ds_queue_size(_Qx) != 0)
		{
			//Get the top point in the queue.
			xx = ds_queue_dequeue(_Qx);
			yy = ds_queue_dequeue(_Qy);
			
			//Check for fillable positions in each direction and add them to the queue.
			#region Right/Up/Left/Down
			if (jen_set(_grid, xx + 1, yy, _replace, _new_value))
			{
				ds_queue_enqueue(_Qx, xx + 1);
				ds_queue_enqueue(_Qy, yy);
			}
			if (jen_set(_grid, xx, yy - 1, _replace, _new_value))
			{
				ds_queue_enqueue(_Qx, xx);
				ds_queue_enqueue(_Qy, yy - 1);
			}
			if (jen_set(_grid, xx - 1, yy, _replace, _new_value))
			{
				ds_queue_enqueue(_Qx, xx - 1);
				ds_queue_enqueue(_Qy, yy);
			}
			if (jen_set(_grid, xx, yy + 1, _replace, _new_value))
			{
				ds_queue_enqueue(_Qx, xx);
				ds_queue_enqueue(_Qy, yy + 1);
			}
			#endregion
			#region Diagonals
			if (_diagonal)
			{
				if (jen_set(_grid, xx + 1, yy + 1, _replace, _new_value))
				{
					ds_queue_enqueue(_Qx, xx + 1);
					ds_queue_enqueue(_Qy, yy + 1);
				}
				if (jen_set(_grid, xx + 1, yy - 1, _replace, _new_value))
				{
					ds_queue_enqueue(_Qx, xx + 1);
					ds_queue_enqueue(_Qy, yy - 1);
				}
				if (jen_set(_grid, xx - 1, yy - 1, _replace, _new_value))
				{
					ds_queue_enqueue(_Qx, xx - 1);
					ds_queue_enqueue(_Qy, yy - 1);
				}
				if (jen_set(_grid, xx - 1, yy + 1, _replace, _new_value))
				{
					ds_queue_enqueue(_Qx, xx - 1);
					ds_queue_enqueue(_Qy, yy + 1);
				}
			}
			#endregion
		}
		
		//Clearing memory.
		ds_queue_destroy(_Qx);
		ds_queue_destroy(_Qy);
	}
}
#endregion