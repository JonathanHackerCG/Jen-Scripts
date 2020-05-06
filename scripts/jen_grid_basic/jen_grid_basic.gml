/// @description Used for initializing various data structures.

/// @function JenGrid(_width, _height);
/// @param _width {integer}
/// @param _height {integer}
/// @param [_cleared]
JenGrid = function(_width, _height, _cleared) constructor
{
	w = _width;
	h = _height;
	data = ds_grid_create(_width, _height);
	
	if (is_undefined(_cleared)) { _cleared = noone; }
	ds_grid_clear(data, _cleared);
	
	//Basic Access Methods
	#region Destroy
	/// @function destroy();
	/// @description Clears memory for the JenGrid.
	function destroy()
	{
		ds_grid_destroy(data);
	}
	#endregion
	#region At
	/// @function at(x, y);
	/// @description Returns the value at a position in the JenGrid.
	/// Returns undefined if the position is out of bounds.
	/// @param x {integer}
	/// @param y {integer}
	function at(_x, _y)
	{
		if (_x >= 0 && _y >= 0 && _x < w && _y < h)
		{
			return data[# _x, _y];
		}
		return undefined;
	}
	#endregion
	#region Set
	/// @function set(x, y, replace, value);
	/// @description Replaces a particular value with another value.
	/// Returns true/false if it has changed a value.
	/// @param x {integer}
	/// @param y {integer}
	/// @param replace
	/// @param value
	function set(_x, _y, _replace, _value)
	{
		if (_x >= 0 && _y >= 0 && _x < w && _y < h) {
		if (_replace == all || at(_x, _y) == _replace)
		{
			data[# _x, _y] = _value;
			return true;
		} }
		return false;
	}
	#endregion
	#region Show
	/// @function show(x, y);
	/// @description Shows the data within a JenGrid.
	/// @param x {integer}
	/// @param y {integer}
	/// @param [space] {real}
	function show(_x, _y, _space)
	{
		if (is_undefined(_space)) { _space = 24; }
		
		for (var yy = 0; yy < h; yy++) {
		for (var xx = 0; xx < w; xx++)
		{
			draw_text(_x + (xx * _space), _y + (yy * _space), string(at(xx, yy)));
		} }
	}
	#endregion
	
	//General Methods
	#region Replace
	/// @function replace(replace, value)
	/// @description Replaces all of one value with another value.
	/// @param replace
	/// @param value
	/// @param [function]
	function replace(_replace, _value, _function)
	{
		if (is_undefined(_function)) { _function = noone; }
		else
		{
			_function = method(self, _function);
			info = {};
			info._replace = _replace;
			info._value = _value;
		}
		
		for (var yy = 0; yy < h; yy++) {
		for (var xx = 0; xx < w; xx++)
		{
			//Replace each matching value.
			if (_replace == all || at(xx, yy) == _replace)
			{
				if (_function == noone)
				{
					set(xx, yy, _replace, _value);
				}
				else
				{
					_function(xx, yy, info);
				}
			}
		} }
		delete info;
	}
	#endregion
	
	//Basic Shapes
	#region Rectangle
	/// @function rectangle(x1, y1, x2, y2, replace, value, outline, [chance], [function]);
	/// @description Creates a rectangle stretched between two points. With or without an outline.
	/// @param x1
	/// @param y1
	/// @param x2
	/// @param y2
	/// @param replace
	/// @param value
	/// @param outline
	/// @param [chance]
	/// @param [function]
	function rectangle(_x1, _y1, _x2, _y2, _replace, _value, _outline, _chance, _function)
	{
		//Getting parameters and defining custom functions.
		if (is_undefined(_chance)) { _chance = 100; }
		if (is_undefined(_function)) { _function = noone; }
		else
		{
			_function = method(self, _function);
			info = {};
			info._x1 = _x1; info._y1 = _y1;
			info._x2 = _x2; info._y2 = _y2;
			info._replace = _replace;
			info._value = _value;
		}
		
		//Iterate through the grid.
		for (var yy = _y1; yy <= _y2; yy++) {
		for (var xx = _x1; xx <= _x2; xx++)
		{
			//Only checking spaces in the rectangle, based on outline.
			if (!_outline || (xx == _x1 || xx == _x2 || yy == _y1 || yy == _y2))
			{
				//Replacing the current value.
				if (_replace == all || at(xx, yy) == _replace)
				{
					//Random chance and using the appropriate function.
					var percent = random(100);
					if (_chance >= percent)
					{
						if (_function == noone)
						{
							set(xx, yy, _replace, _value);
						}
						else
						{
							_function(xx, yy, info);
						}
					}
				}
			}
			else
			{
				//To skip some unnecessary checks when it is an outline.
				xx = _x2 - 1;
			}
		} }
		delete info;
	}
	#endregion

	//Basic Distribution Methods
	#region Scatter
	/// @function scatter(replace, value, [chance], [function]);
	/// @description Replaces some percentage of one value with another.
	/// @param replace
	/// @param value
	/// @param [chance] {percent}
	/// @param [function] {function}
	function scatter(_replace, _value, _chance, _function)
	{
		if (is_undefined(_chance)) { _chance = 100; }
		if (is_undefined(_function)) { _function = noone; }
		else
		{
			_function = method(self, _function);
			info = {};
			info._replace = _replace;
			info._value = _value;
			info._chance = _chance;
		}
		
		//Iterate through the grid.
		for (var yy = 0; yy < h; yy++) {
		for (var xx = 0; xx < w; xx++)
		{
			//Replacing the current value.
			if (_replace == all || at(xx, yy) == _replace)
			{
				var percent = random(100);
				if (_chance >= percent)
				{
					if (_function == noone)
					{
						set(xx, yy, all, _value);
					}
					else
					{
						_function(xx, yy, info);
					}
				}
			}
		} }
		delete info;
	}
	#endregion
}