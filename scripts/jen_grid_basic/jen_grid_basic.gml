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
	/// @function at(_x, _y);
	/// @description Returns the value at a position in the JenGrid.
	/// Returns undefined if the position is out of bounds.
	/// @param _x {integer}
	/// @param _y {integer}
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
	/// @function set(_x, _y, _replace, _value);
	/// @description Replaces a particular value with another value.
	/// Returns true/false if it has changed a value.
	/// @param _x {integer}
	/// @param _y {integer}
	/// @param _replace {value}
	/// @param _value {value}
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
	/// @function show(_x, _y);
	/// @description Shows the data within a JenGrid.
	/// @param _x {integer}
	/// @param _y {integer}
	/// @param [_space] {number}
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

	//Basic Distribution Methods
	#region Scatter
	/// @function scatter(_replace, _value, [_chance], [_function]);
	/// @description Replaces some percentage of one value with another.
	/// @param _replace {value}
	/// @param _value {value}
	/// @param [_chance] {percent}
	/// @param [_function] {function}
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