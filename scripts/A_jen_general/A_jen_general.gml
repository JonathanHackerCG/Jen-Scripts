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
JEN_CELLH = 16;
JEN_CELLW = 16;
#endregion

//Initialization and Getters/Setters
#region jen_grid_cellsize(cellw, cellh);
/// @func jen_grid_cellsize(cellw, cellh):
/// @desc Sets the terrain cell width and cell height in pixels.
///				Referenced with JEN_CELLW and JEN_CELLH.
/// @arg	{Real} cellw
/// @arg	{Real} cellh
function jen_grid_cellsize(_cellw, _cellh)
{
	JEN_CELLW = _cellw;
	JEN_CELLH = _cellh;
}
#endregion
#region jen_grid_create(width, height, [cleared]);
/// @func jen_grid_create(width, height, [cleared]):
/// @desc Create a new JenGrid of specified width and height (in cells).
/// @arg	{Real}	width
/// @arg	{Real}	height
/// @arg	{Any}		[cleared]		Default: noone
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
/// @func jen_grid_destroy(grid):
/// @desc Destroy a JenGrid, clearing it from memory.
///				Returns true if the JenGrid was successfully destroyed.
/// @arg	{Id.DsGrid}		JenGrid
/// @returns {Bool}
function jen_grid_destroy(_grid)
{
	//Check if the grid exists.
	if (jen_grid_exists(_grid))
	{
		//Destroy the grid and return true.
		ds_grid_destroy(_grid);
		return true;
	}
	return false;
}
#endregion
#region NEW jen_grid_exists(grid);
/// @func jen_grid_exists(grid):
/// @desc Returns true if a JenGrid exists.
///				NOTE: Currently cannot distinguish between a JenGrid and a DS Grid.
/// @arg	{Id.DsGrid}		JenGrid
/// @returns {Bool}
function jen_grid_exists(_grid)
{
	return ds_exists(_grid, ds_type_grid);
}
#endregion
#region jen_get(JenGrid, xcell, ycell);
/// @func jen_get(JenGrid, xcell, ycell):
/// @desc Return a value at a position.
///				Returns undefined if it is out of bounds.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell
/// @arg	{Real}				ycell
/// @returns {Any}
function jen_get(_grid, _x, _y)
{
	//Check if it is out of bounds, otherwise return the value directly.
	if (!jen_grid_inbounds(_grid, _x, _y)) { return undefined; }
	return _grid[# _x, _y];
}
#endregion
#region jen_set(JenGrid, xcell, ycell, replace, new_value);
/// @func jen_set(JenGrid, xcell, ycell, replace, new_value):
/// @desc Set a value at an eligible position.
///				Returns true if the value is sucessfully set.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell
/// @arg	{Real}				ycell
/// @arg	{Any}					replace			Supports Array (Any)
/// @arg	{Any}					new_value		Supports Array (Choose)
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
#region NEW jen_set_not(JenGrid, xcell, ycell, replace, new_value);
/// @func jen_set_not(JenGrid, xcell, ycell, replace, new_value):
/// @desc Set a value at a position NOT matching the replace value(s).
///				Returns true if the value is sucessfully set.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell
/// @arg	{Real}				ycell
/// @arg	{Any}					replace			Supports Array (Any)
/// @arg	{Any}					new_value		Supports Array (Choose)
/// @returns {Bool}
function jen_set_not(_grid, _x, _y, _replace, _new_value)
{
	//Array conversions and other checks.
	if (!jen_grid_inbounds(_grid, _x, _y)) { return false; }
	_new_value = _jenternal_convert_new_value(_new_value);
	
	if (!jen_test(_grid, _x, _y, _replace))
	{
		//Setting the new value.
		_grid[# _x, _y] = _new_value;
		return true;
	}
	return false;
}
#endregion
#region NEW jen_test(JenGrid, xcell, ycell, target);
/// @func jen_test(JenGrid, xcell, ycell, target):
/// @desc Returns true if a position on the grid matches the provided target value(s).
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell
/// @arg	{Real}				ycell
/// @arg	{Any}					target			Supports Array (Any)
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
/// @func jen_grid_width(grid):
/// @desc Returns the width of a JenGrid.
/// @arg	{Id.DsGrid}		JenGrid
/// @returns {Integer}
function jen_grid_width(_grid)
{
	return ds_grid_width(_grid);
}
#endregion
#region jen_grid_height(grid);
/// @func jen_grid_height(grid):
/// @desc Returns the height of a JenGrid.
/// @arg	{Id.DsGrid}		JenGrid
/// @returns {Real}
function jen_grid_height(_grid)
{
	return ds_grid_height(_grid);
}
#endregion
#region NEW jen_grid_inbounds(JenGrid, xcell, ycell);
/// @func jen_grid_inbounds(JenGrid, xcell, ycell):
/// @desc Returns true if the position is in bounds of the JenGrid.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell
/// @arg	{Real}				ycell
/// @returns {Bool}
function jen_grid_inbounds(_grid, _x, _y)
{
	return !(_x < 0 || _y < 0 || _x >= jen_grid_width(_grid) || _y >= jen_grid_height(_grid));
}
#endregion

//Transformations
#region jen_grid_apply(target_JenGrid, apply_JenGrid, replace, xcell, ycell, [chance], [function]);
/// @func jen_grid_apply(target_JenGrid, apply_JenGrid, replace, xcell, ycell, [chance], [function]):
/// @desc Transfer all values from applied grid to a target grid.
///				Values of 'noone' in the applied grid will be ignored.
/// @arg	{Id.DsGrid}		target_JenGrid
/// @arg  {Id.DsGrid}		apply_JenGrid
/// @arg	{Any}					replace			Supports Array (Any)
/// @arg	{Real}				xcell
/// @arg	{Real}				ycell
/// @arg  {Real}				[chance]		Default: 100
/// @arg  {Function}		[function]	Default: undefined
function jen_grid_apply(_target, _apply, _replace, _x1, _y1, _chance = 100, _function = undefined)
{
	//Getting width and height of the grids.
	var _width = jen_grid_width(_target);
	var _height = jen_grid_height(_target);
	var _width_apply = min(jen_grid_width(_apply), _width);
	var _height_apply = min(jen_grid_height(_apply), _height);
	
	//Array conversions.
	_replace = _jenternal_convert_replace(_replace);
	
	//Iterate through the application grid.
	var _value;
	for (var yy = 0; yy < _height_apply; yy ++) {
	for (var xx = 0; xx < _width_apply; xx ++)
	{
		//Get the value of the application grid.
		_value = jen_get(_apply, xx, yy);
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
#region jen_grid_mirror(JenGrid, horizontal, vertical);
/// @func jen_grid_mirror(JenGrid, horizontal, vertical):
/// @desc Flips the data in a grid horizontally and/or vertically.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  {Bool}				horizontal
/// @arg  {Bool}				vertical
function jen_grid_mirror(_grid, _horizontal, _vertical)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Create a temporary grid.
	var _temp_grid = jen_grid_create(_w, _h, noone);
	
	//Iterate through the target grid, copying values.
	var set, xcopy, ycopy;
	for (var yy = 0; yy < _h; yy++) {
	for (var xx = 0; xx < _w; xx++)
	{
		xcopy = xx;
		ycopy = yy;
		
		//Change positions to mirror the values.
		if (_vertical) { xcopy = _w - xx - 1; }
		if (_horizontal) { ycopy = _h - yy - 1; }
		
		set = jen_get(_grid, xx, yy);
		jen_set(_temp_grid, xcopy, ycopy, all, set);
	} }
	
	//Copy the grid and clear memory.
	ds_grid_copy(_grid, _temp_grid);
	ds_grid_destroy(_temp_grid);
}
#endregion
#region jen_grid_rotate(JenGrid, rotations);
/// @func jen_grid_rotate(JenGrid, rotations):
/// @desc Rotates a JenGrid counterclockwise by 90 degrees, some number of times.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  {Real}				rotations		Supports 0, 1, 2, or 3.
function jen_grid_rotate(_grid, _rotations)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Different rotation operations depending on the angle.
	if (_rotations < 0 || _rotations > 3) { show_error("Jen-Scripts 'jen_rotate' expects a rotation number of 0, 1, 2, or 3.", false); exit; }
	if (_rotations == 0) { exit; }
	
	//Apply each rotation based on the number of rotations.
	#region 90 degrees.
	if (_rotations == 1)
	{
		var _temp_grid = jen_grid_create(_h, _w);
		
		var xcopy, ycopy, val;
		for (var yy = 0; yy < _h; yy++) {			
		for (var xx = 0; xx < _w; xx++)
		{
			val = jen_get(_grid, xx, yy);
			xcopy = yy;
			ycopy = _w - xx - 1;
			jen_set(_temp_grid, xcopy, ycopy, all, val);
		}	}
	}
	#endregion
	#region 180 degrees.
	else if (_rotations == 2)
	{
		var _temp_grid = jen_grid_create(_w, _h);
		
		var xcopy, ycopy, val;
		for (var yy = 0; yy < _h; yy++) {			
		for (var xx = 0; xx < _w; xx++)
		{
			val = jen_get(_grid, xx, yy);
			xcopy = _w - xx - 1;
			ycopy = _h - yy - 1;
			jen_set(_temp_grid, xcopy, ycopy, all, val);
		}	}
	}
	#endregion
	#region 270 degrees.
	else if (_rotations == 3)
	{
		var _temp_grid = jen_grid_create(_h, _w);
		
		var xcopy, ycopy, val;
		for (var yy = 0; yy < _h; yy++) {			
		for (var xx = 0; xx < _w; xx++)
		{
			val = jen_get(_grid, xx, yy);
			xcopy = _h - yy - 1;
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
#region jen_grid_scale(JenGrid, factor, upscale);
/// @func jen_grid_scale
/// @desc Transforms a grid by scaling it up or down by a whole number factor.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  {Real}				factor
/// @arg  {Bool}				upscale
function jen_grid_scale(_grid, _factor, _upscale)
{
	//Modify parameters.
	_factor = abs(round(_factor));
	
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	if (_upscale) //Upscaling.
	{
		var _temp_grid = ds_grid_create(_w * _factor, _h * _factor);
	
		var x1, y1, val;
		for (var xx = 0; xx < _w; xx++) {
		for (var yy = 0; yy < _h; yy++)
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
		var _temp_grid = ds_grid_create(_w / _factor, _h / _factor);
		
		var x1, y1, val;
		for (var xx = 0; xx < _w; xx += _factor) {
		for (var yy = 0; yy < _h; yy += _factor)
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
#region jen_grid_instantiate_layer(JenGrid, x, y, layer, [struct]);
/// @func jen_grid_instantiate_layer(JenGrid, x, y, layer, [struct]):
/// @desc Instantiates a JenGrid on a particular layer, treating each value as an object index.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				x
/// @arg	{Real}				y
/// @arg	{Any}					layer
/// @arg	{Struct}			[struct]		Supports a function(xcell, ycell) that returns a struct.
function jen_grid_instantiate_layer(_grid, _x1, _y1, _layer, _struct = undefined)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	for (var xx = 0; xx < _w; xx++) {
	for (var yy = 0; yy < _h; yy++)
	{
		//Instantiating each object.
		var _index = jen_get(_grid, xx, yy);
		if (is_real(_index) && _index != noone && object_exists(_index))
		{
			if (!is_undefined(_struct))
			{
				if (is_struct(_struct))
				{
					instance_create_layer(_x1 + (xx * JEN_CELLW), _y1 + (yy * JEN_CELLH), _layer, _index, _struct);
				}
				else
				{
					instance_create_layer(_x1 + (xx * JEN_CELLW), _y1 + (yy * JEN_CELLH), _layer, _index, _struct(xx, yy));
				}
			}
			else
			{
				instance_create_layer(_x1 + (xx * JEN_CELLW), _y1 + (yy * JEN_CELLH), _layer, _index);
			}
		}
	} }
}
#endregion
#region jen_grid_instantiate_depth(JenGrid, x, y, depth, [struct]);
/// @func jen_grid_instantiate_depth(JenGrid, x, y, depth, [struct]):
/// @desc Instantiates a JenGrid at a particular depth, treating each value as an object index.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				x
/// @arg	{Real}				y
/// @arg	{Real}				depth
/// @arg	{Struct}			[struct]		Supports a function(xcell, ycell) that returns a struct.
function jen_grid_instantiate_depth(_grid, _x1, _y1, _depth, _struct = undefined)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	for (var xx = 0; xx < _w; xx++) {
	for (var yy = 0; yy < _h; yy++)
	{
		//Instantiating each object.
		var _index = jen_get(_grid, xx, yy);
		if (is_real(_index) && _index != noone && object_exists(_index))
		{
			if (!is_undefined(_struct))
			{
				if (is_struct(_struct))
				{
					instance_create_depth(_x1 + (xx * JEN_CELLW), _y1 + (yy * JEN_CELLH), _depth, _index, _struct);
				}
				else
				{
					instance_create_depth(_x1 + (xx * JEN_CELLW), _y1 + (yy * JEN_CELLH), _depth, _index, _struct(xx, yy));
				}
			}
			else
			{
				instance_create_depth(_x1 + (xx * JEN_CELLW), _y1 + (yy * JEN_CELLH), _depth, _index);
			}
		}
	} }
}
#endregion
#region TODO jen_grid_instantiate_tiles(JenGrid, x, y, tilemap/layer, [flipx], [flipy]);
/// @func jen_grid_instantiate_tiles
/// @desc Instantiates a grid, treating each value as a tile index.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x
/// @arg  y
/// @arg  tilemap/layer
/// @arg  [flipx]
/// @arg  [flipy]
function jen_grid_instantiate_tiles(_grid, _x1, _y1, _tilemap, _flipx = false, _flipy = false)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Updating the coordinate position to cell position.
	_x1 = _x1 div JEN_CELLW;
	_y1 = _y1 div JEN_CELLH;
	
	//Converting a layer name into a tilemap id.
	if (is_string(_tilemap))
	{
		_tilemap = layer_get_id(_tilemap);
		_tilemap = layer_tilemap_get_id(_tilemap);
	}
	
	for (var xx = 0; xx < _w; xx++) {
	for (var yy = 0; yy < _h; yy++)
	{
		//Setting each tile value in the tilemap.
		var val = jen_get(_grid, xx, yy);
		if (is_real(val) && val >= 1)
		{
			var _data = tilemap_get(_tilemap, xx, yy);
			_data = tile_set_index(data, val);
			if (_flipx) { data = tile_set_mirror(data, irandom(1)); }
			if (_flipy) { data = tile_set_flip(data, irandom(1)); }
			tilemap_set(_tilemap, _data, _x1 + xx, _y1 + yy);
		}
	} }
}
#endregion
#region TODO jen_grid_instantiate_autotile(JenGrid, x, y, test, closed_edge, tilemap/layer, [offset]);
/// @func jen_grid_instantiate_autotile
/// @desc Instantiates a grid, searching for adjacent test values, and converting to an autotile tile index.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x
/// @arg  y
/// @arg  test
/// @arg  closed_edge
/// @arg  tilemap/layer
/// @arg  [offset]
function jen_grid_instantiate_autotile(_grid, _x1, _y1, _test, _closed_edge, _tilemap, _offset = 0)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//TODO: Convert (x, y) into tile positions.
	
	//Converting a layer name into a tilemap id.
	if (is_string(_tilemap))
	{
		_tilemap = layer_get_id(_tilemap);
		_tilemap = layer_tilemap_get_id(_tilemap);
	}
	
	//Loop through the grid, checking for matching values.
	for (var xx = 0; xx < _w; xx++) {
	for (var yy = 0; yy < _h; yy++)
	{
		//Setting each tile value in the tilemap.
		var val = jen_get(_grid, xx, yy);
		if (val == _test)
		{
			var tile = _jenternal_autotile(_grid, xx, yy, _test, _closed_edge);
			if (tile != -1) { tilemap_set(_tilemap, tile + (_offset * 20), _x1 + xx, _y1 + yy); }
		}
	} }
}
#endregion

//Debugging Functions
#region jen_grid_string(JenGrid);
/// @func jen_grid_string(JenGrid):
/// @desc Returns the JenGrid formatted as a string.
/// @arg	{Id.DsGrid}		JenGrid
/// @returns {String}
function jen_grid_string(_grid)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Looping through the grid to build the string.
	var _output = "";
	for (var yy = 0; yy < _h; yy++)
	{
		for (var xx = 0; xx < _w; xx++)
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
#region jen_grid_draw(JenGrid, x, y);
/// @func jen_grid_draw(JenGrid, x, y):
/// @desc Draws the data within the grid, using jen_grid_string.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  {Real}				x
/// @arg  {Real}				y
function jen_grid_draw(_grid, _x1, _y1)
{
	var _text = jen_grid_string(_grid);
	draw_text(_x1, _y1, _text);
}
#endregion