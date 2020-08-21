// Basic distribution functions. Scattering and replacing.

#region jen_replace(id, replace, new_value);
/// @description Replaces all of one value with another value.
/// @param id
/// @param replace
/// @param new_value
function jen_replace(_grid, _replace, _new_value)
{
	//Getting width and height of the grid.
	var _width = ds_grid_width(_grid);
	var _height = ds_grid_height(_grid);
	
	//Looping through the grid to replace each matching value.
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
	{
		jen_set(_grid, xx, yy, _replace, _new_value);
	} }
}
#endregion
#region jen_scatter(id, replace, new_value, [chance], [function])
/// @description Replaces some percentage of one value with another.
/// @param id
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_scatter(_grid, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		info = {};
		info.replace = _replace;
		info.new_value = _new_value;
		info.chance = _chance;
	}
	
	//Getting width and height of the grid.
	var _width = ds_grid_width(_grid);
	var _height = ds_grid_height(_grid);
	
	//Looping through the grid to replace each matching value.
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
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
				_function(_grid, xx, yy, info);
			}
		}
	} }
	delete info;
}
#endregion