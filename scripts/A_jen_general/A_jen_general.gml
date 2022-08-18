//General Jen-Scripts functions. Initialization and grid transformations.

#region Main enumerators and macros.
//Enumerator to denote directions for maze functions.
enum jen_dir
{
	R,
	U,
	D,
	L,
	
	_total
}
#endregion
#region Main global variables.
global.jen_cellh = 16;
global.jen_cellw = 16;
#endregion

//Initialization and Getters/Setters
#region jen_grid_cellsize(cellw, cellh);
/// @func								jen_grid_cellsize(cellw, cellh):
/// @desc								Sets the cell width and cell height of your terrain.
///											Referenced with global.jen_cellw and global.jen_cellh.
/// @arg {Real} cellw		Width of cells (in pixels).
/// @arg {Real} cellh		Height of cells (in pixels).
function jen_grid_cellsize(_cellw, _cellh)
{
	global.jen_cellw = _cellw;
	global.jen_cellh = _cellh;
}
#endregion
#region jen_grid_create(width, height, [cleared]);
/// @func									jen_grid_create(width, height, [cleared]):
/// @desc									Create a new JenGrid of specified width and height.
/// @arg {Real} width			The width of the JenGrid (in cells).
/// @arg {Real} height		The height of the JenGrid (in cells).
/// @arg {Any} [cleared]	The initialized value of the JenGrid. Defaults to noone.
/// @returns {Id.DsGrid}
function jen_grid_create(_width, _height, _cleared = noone)
{
	//Create and fill the new grid.
	var _grid = ds_grid_create(_width, _height);
	ds_grid_clear(_grid, _cleared);
	
	//Return the new grid id.
	return _grid;
}
#endregion
#region jen_grid_destroy(grid);
/// @func							jen_grid_destroy(grid):
/// @desc							Destroy a JenGrid, clearing it from memory.
///										Returns true if the JenGrid was successfully destroyed.
/// @arg {Real} grid	JenGrid to destroy.
/// @returns {Bool}
function jen_grid_destroy(_grid)
{
	//Check if the grid exists.
	if (ds_exists(_grid, ds_type_grid))
	{
		//Destroy the grid and return true.
		ds_grid_destroy(_grid);
		return true;
	}
	return false;
}
#endregion
// >>> TODO_CG: jen_grid_exists(grid);
#region jen_get(grid, x, y);
/// @function jen_get
/// @description Return a value at a position. Returns undefined if it is out of bounds.
/// @param grid
/// @param x
/// @param y
function jen_get(_grid, _x, _y)
{
	//Check if it is out of bounds, otherwise return the value directly.
	if (!jen_grid_inbounds(_grid, _x, _y)) { return undefined; }
	return _grid[# _x, _y];
}
#endregion
#region jen_set(grid, x, y, replace, new_value);
/// @func							jen_set(grid, x, y, replace, new_value):
/// @desc							Set a value at an eligible position.
///										The replace and new_value parameters both accept Arrays.
///										Returns true if the value is sucessfully set.
/// @arg {Id.DsGrid}	grid
/// @arg {Real}				x
/// @arg {Real}				y
/// @arg {Any}				replace
/// @arg {Any}				new_value
/// @returns {Bool}
function jen_set(_grid, _x, _y, _replace, _new_value)
{
	//Array conversions and other checks.
	if (!jen_grid_inbounds(_grid, _x, _y)) { return false; }
	_new_value = _jenternal_convert_new_value(_new_value);
	
	if (jen_test(_grid, _x, _y, _replace))
	{
		//Setting the new value.
		_grid[# _x, _y] = _new_value;
		return true;
	}
	return false;
}
#endregion
#region NEW jen_test(grid, x, y, replace);
/// @func jen_test(grid, x, y, replace):
/// @desc Returns true if a position on the grid matches the provided replace value or array.
/// @arg {Id.DsGrid}	grid
/// @arg {Real}				x
/// @arg {Real}				y
/// @arg {Any}				replace
/// @returns {Bool}
function jen_test(_grid, _x, _y, _replace)
{
	//Array conversions.
	if (!jen_grid_inbounds(_grid, _x, _y)) { return false; }
	if (!is_array(_replace)) { _replace = [_replace]; }
	
	//Testing this position.
	var _test = jen_get(_grid, _x, _y);
	var i = 0; repeat(array_length(_replace))
	{
		if (_replace[i] == all || _replace[i] == _test) { return true; }
	i++; }
	return false;
}
#endregion
#region jen_grid_width(grid);
/// @function jen_grid_width
/// @description Returns the width of a jen_grid.
/// @param grid
function jen_grid_width(_grid)
{
	return ds_grid_width(_grid);
}
#endregion
#region jen_grid_height(grid);
/// @function jen_grid_height
/// @description Returns the height of a jen_grid.
/// @param grid
function jen_grid_height(_grid)
{
	return ds_grid_height(_grid);
}
#endregion
#region NEW jen_grid_inbounds(grid, x, y);
/// @func jen_grid_inbounds
/// @desc Returns true if the position is in bounds of the JenGrid.
/// @arg grid
/// @arg x
/// @arg y
function jen_grid_inbounds(_grid, _x, _y)
{
	return !(_x < 0 || _y < 0 || _x >= jen_grid_width(_grid) || _y >= jen_grid_height(_grid));
}
#endregion

//Transformations
#region jen_grid_apply(target_grid, apply_grid, replace, x1, y1, [chance], [function]);
/// @function jen_grid_apply
/// @description Applies one grid onto another, transfering all filled values to the target.
/// @param target_grid
/// @param apply_grid
/// @param replace
/// @param x1
/// @param y1
/// @param [chance]
/// @param [function]
function jen_grid_apply(_target, _apply, _replace, _x1, _y1, _chance = 100, _function = noone)
{
	//Getting width and height of the grids.
	var _width = jen_grid_width(_target);
	var _height = jen_grid_height(_target);
	var _width_apply = min(jen_grid_width(_apply), _width);
	var _height_apply = min(jen_grid_height(_apply), _height);
	
	//Iterate through the application grid.
	var _value;
	for (var yy = 0; yy < _height_apply; yy ++) {
	for (var xx = 0; xx < _width_apply; xx ++)
	{
		//Get the value of the application grid.
		_value = jen_get(_apply, xx, yy);
		if (_value != noone) && (_chance >= 100 || random(100) < _chance)
		{
			if (_function == noone)
			{
				//Directly set the target value to the application value.
				jen_set(_target, _x1 + xx, _y1 + yy, _replace, _value);
			}
			else if (_replace == all || jen_get(_target, xx, yy) == _replace)
			{
				//Run the custom function.
				_function(_target, _x1 + xx, _y1 + yy, _replace, _value);
			}
		}
	} }
}
#endregion
#region jen_grid_mirror(grid, horizontal, vertical);
/// @function jen_grid_mirror
/// @description Mirrors the data in a grid horizontally and or vertically.
/// @param grid
/// @param horizontal
/// @param vertical
function jen_grid_mirror(_grid, _horizontal, _vertical)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
	//Create a temporary grid.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Iterate through the target grid, copying values.
	var set, xcopy, ycopy;
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
	{
		xcopy = xx;
		ycopy = yy;
		
		//Change positions to mirror the values.
		if (_vertical) { xcopy = _width - xx - 1; }
		if (_horizontal) { ycopy = _height - yy - 1; }
		
		set = jen_get(_grid, xx, yy);
		jen_set(_temp_grid, xcopy, ycopy, all, set);
	} }
	
	//Copy the grid and clear memory.
	ds_grid_copy(_grid, _temp_grid);
	ds_grid_destroy(_temp_grid);
}
#endregion
#region jen_grid_rotate(grid, rotations);
/// @function jen_grid_rotate
/// @description Rotates a grid counterclockwise by 90 degrees, some number of times. (1-3)
/// @param grid
/// @param rotations
function jen_grid_rotate(_grid, _rotations)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
	//Different rotation operations depending on the angle.
	if (_rotations < 1 || _rotations > 3) { show_error("Jen-Scripts function jen_rotate requires a rotation number of 1, 2, or 3.", false); exit; }
	
	//Apply each rotation based on the number of rotations.
	#region 90 degrees.
	if (_rotations == 1)
	{
		var _temp_grid = jen_grid_create(_height, _width);
		
		var xcopy, ycopy, val;
		for (var yy = 0; yy < _height; yy++) {			
		for (var xx = 0; xx < _width; xx++)
		{
			val = jen_get(_grid, xx, yy);
			xcopy = yy;
			ycopy = _width - xx - 1;
			jen_set(_temp_grid, xcopy, ycopy, all, val);
		}	}
	}
	#endregion
	#region 180 degrees.
	else if (_rotations == 2)
	{
		var _temp_grid = jen_grid_create(_width, _height);
		
		var xcopy, ycopy, val;
		for (var yy = 0; yy < _height; yy++) {			
		for (var xx = 0; xx < _width; xx++)
		{
			val = jen_get(_grid, xx, yy);
			xcopy = _width - xx - 1;
			ycopy = _height - yy - 1;
			jen_set(_temp_grid, xcopy, ycopy, all, val);
		}	}
	}
	#endregion
	#region 270 degrees.
	else if (_rotations == 3)
	{
		var _temp_grid = jen_grid_create(_height, _width);
		
		var xcopy, ycopy, val;
		for (var yy = 0; yy < _height; yy++) {			
		for (var xx = 0; xx < _width; xx++)
		{
			val = jen_get(_grid, xx, yy);
			xcopy = _height - yy - 1;
			ycopy = xx;
			jen_set(_temp_grid, xcopy, ycopy, all, val);
		}	}
	}
	#endregion
	
	//Copy the grid and clear memory.
	ds_grid_copy(_grid, _temp_grid);
	ds_grid_destroy(_temp_grid);
}
#endregion
#region jen_grid_scale(grid, factor, upscale);
/// @function jen_grid_scale
/// @description Transforms a grid by scaling it up or down by a whole number factor.
/// @param grid
/// @param factor
/// @param upscale
function jen_grid_scale(_grid, _factor, _upscale)
{
	//Modify parameters.
	_factor = abs(round(_factor));
	
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
	if (_upscale) //Upscaling.
	{
		var _temp_grid = ds_grid_create(_width * _factor, _height * _factor);
	
		var x1, y1, val;
		for (var xx = 0; xx < _width; xx++) {
		for (var yy = 0; yy < _height; yy++)
		{
			//Calculate offsets and set the scaled positions.
			x1 = xx * _factor;
			y1 = yy * _factor;
			val = jen_get(_grid, xx, yy);
			ds_grid_set_region(_temp_grid, x1, y1, x1 + _factor, y1 + _factor, val);
		} }
	}
	else //Downscaling.
	{
		var _temp_grid = ds_grid_create(_width / _factor, _height / _factor);
		
		var x1, y1, val;
		for (var xx = 0; xx < _width; xx += _factor) {
		for (var yy = 0; yy < _height; yy += _factor)
		{
			x1 = xx / _factor;
			y1 = yy / _factor;
			val = jen_get(_grid, xx, yy);
			jen_set(_temp_grid, x1, y1, all, val);
		} }
	}
	
	//Copy the temporary grid and clear memory.
	ds_grid_copy(_grid, _temp_grid);
	ds_grid_destroy(_temp_grid);
}
#endregion

//Instantiation
#region jen_grid_instantiate_layer(grid, x1, y1, layer);
/// @function jen_grid_instantiate_layer
/// @description Instantiates a grid, treating each value as an object index.
/// @param grid
/// @param x1
/// @param y1
/// @param layer
function jen_grid_instantiate_layer(_grid, _x1, _y1, _layer)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
	for (var xx = 0; xx < _width; xx++) {
	for (var yy = 0; yy < _height; yy++)
	{
		//Instantiating each object.
		var index = jen_get(_grid, xx, yy);
		if (is_real(index) && index != noone && object_exists(index))
		{
			instance_create_layer(_x1 + (xx * global.jen_cellw), _y1 + (yy * global.jen_cellh), _layer, index);
		}
	} }
}
#endregion
#region jen_grid_instantiate_depth(grid, x1, y1, depth);
/// @function jen_grid_instantiate_depth
/// @description Instantiates a grid, treating each value as an object index.
/// @param grid
/// @param x1
/// @param y1
/// @param depth
function jen_grid_instantiate_depth(_grid, _x1, _y1, _depth)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
	for (var xx = 0; xx < _width; xx++) {
	for (var yy = 0; yy < _height; yy++)
	{
		//Instantiating each object.
		var index = jen_get(_grid, xx, yy);
		if (is_real(index) && index != noone && object_exists(index))
		{
			instance_create_depth(_x1 + (xx * global.jen_cellw), _y1 + (yy * global.jen_cellh), _depth, index);
		}
	} }
}
#endregion
#region jen_grid_instantiate_tiles(grid, x1, y1, tilemap/layer, [flipx], [flipy]);
/// @function jen_grid_instantiate_tiles
/// @description Instantiates a grid, treating each value as a tile index.
/// @param grid
/// @param x1
/// @param y1
/// @param tilemap/layer
/// @param [flipx]
/// @param [flipy]
function jen_grid_instantiate_tiles(_grid, _x1, _y1, _tilemap, _flipx = false, _flipy = false)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
	//Updating the coordinate position to cell position.
	_x1 = _x1 div global.jen_cellw;
	_y1 = _y1 div global.jen_cellh;
	
	//Converting a layer name into a tilemap id.
	if (is_string(_tilemap))
	{
		_tilemap = layer_get_id(_tilemap);
		_tilemap = layer_tilemap_get_id(_tilemap);
	}
	
	for (var xx = 0; xx < _width; xx++) {
	for (var yy = 0; yy < _height; yy++)
	{
		//Setting each tile value in the tilemap.
		var val = jen_get(_grid, xx, yy);
		if (is_real(val) && val >= 1)
		{
			var _data = tilemap_get(_tilemap, xx, yy);
			_data = tile_set_index(data, val);
			if (_flipx) { data = tile_set_mirror(data, irandom(1)); }
			if (_flipy) { data = tile_set_flip(data, irandom(1)); }
			//Feather ignore once GM1029
			tilemap_set(_tilemap, _data, _x1 + xx, _y1 + yy);
		}
	} }
}
#endregion
#region jen_grid_instantiate_autotile(grid, x1, y1, test, closed_edge, tilemap/layer, [offset]);
/// @function jen_grid_instantiate_autotile
/// @description Instantiates a grid, searching for adjacent test values, and converting to an autotile tile index.
/// @param grid
/// @param x1
/// @param y1
/// @param test
/// @param closed_edge
/// @param tilemap/layer
/// @param [offset]
function jen_grid_instantiate_autotile(_grid, _x1, _y1, _test, _closed_edge, _tilemap, _offset = 0)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
	//Converting a layer name into a tilemap id.
	if (is_string(_tilemap))
	{
		_tilemap = layer_get_id(_tilemap);
		_tilemap = layer_tilemap_get_id(_tilemap);
	}
	
	//Loop through the grid, checking for matching values.
	for (var xx = 0; xx < _width; xx++) {
	for (var yy = 0; yy < _height; yy++)
	{
		//Setting each tile value in the tilemap.
		var val = jen_get(_grid, xx, yy);
		if (val == _test)
		{
			var tile = _jenternal_autotile(_grid, xx, yy, _test, _closed_edge);
			//Feather ignore once GM1029
			if (tile != -1) { tilemap_set(_tilemap, tile + (_offset * 20), _x1 + xx, _y1 + yy); }
		}
	} }
}
#endregion

//Debugging Functions
#region jen_grid_string(grid);
/// @function jen_grid_string
/// @description Returns the jen_grid formatted as a string.
/// @param grid
function jen_grid_string(_grid)
{
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
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
#region jen_grid_draw(grid, x, y);
/// @function jen_grid_draw
/// @description Draws the data within the grid, using jen_grid_string.
/// @param grid
/// @param x
/// @param y
function jen_grid_draw(_grid, _x1, _y1)
{
	var _text = jen_grid_string(_grid);
	draw_text(_x1, _y1, _text);
}
#endregion