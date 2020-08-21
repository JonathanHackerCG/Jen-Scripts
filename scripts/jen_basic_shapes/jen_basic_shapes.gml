//Basic shape functions. Lines, circle, rectangles, etcetera.

#region jen_line(id, x1, y1, x2, y2, replace, new_value, [chance], [function]);
/// @description Creates a line between two points.
/// @param id
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_line(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		//Create struct containing all the parameters.
		info = {};
		info.x1 = _x1; info.y1 = _y1;
		info.x2 = _x2; info.y2 = _y2;
		info.replace = _replace;
		info.new_value = _new_value;
		info.chance = _chance;
	}
	
	//Calculating _step amounts for the line.
	var _xdis = _x2 - _x1;
	var _ydis = _y2 - _y1;
	var _step = max(abs(_xdis), abs(_ydis));
	_xdis = _xdis / _step;
	_ydis = _ydis / _step;
		
	//Creating the line based on total _steps.
	var xx = _x1;
	var yy = _y1;
	var _count = 0;
	while (_count <= _step)
	{
		//Checking first if the position is valid.
		if (_chance >= 100 || random(100) < _chance)
		{
			//Setting the line position/appropriate function.
			if (_function == noone)
			{
				jen_set(_grid, xx, yy, all, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				_function(_grid, xx, yy, info);
			}
		}
		//Increment position.
		xx += _xdis;
		yy += _ydis;
		_count ++;
	}
	delete info;
}
#endregion
#region jen_rectangle(id, x1, y1, x2, y2, replace, new_value, outline, [chance], [function]);
/// @description Creates a rectangle between two positions.
/// @param id
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param replace
/// @param new_value
/// @param outline
/// @param [chance]
/// @param [function]
function jen_rectangle(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _outline, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		info = {};
		info.x1 = _x1; info.y1 = _y1;
		info.x2 = _x2; info.y2 = _y2;
		info.replace = _replace;
		info.new_value = _new_value;
		info.outline = _outline;
		info.chance = _chance;
	}
	
	//Iterate through the grid.
	for (var yy = _y1; yy <= _y2; yy++) {
	for (var xx = _x1; xx <= _x2; xx++)
	{
		//Only checking spaces in the rectangle, based on outline.
		if (!_outline || (xx == _x1 || xx == _x2 || yy == _y1 || yy == _y2))
		{
			//Random chance and using the appropriate function.
			if (random(100) < _chance)
			{
				if (_function == noone)
				{
					//Replace matching values.
					jen_set(_grid, xx, yy, _replace, _new_value);
				}
				else if (_replace == all || jen_get(_grid, xx, yy) == _replace)
				{
					//Run custom function.
					_function(_grid, xx, yy, info);
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
#region jen_triangle(id, x1, y1, x2, y2, x3, y3, replace, new_value, [chance], [function]);
/// @description This creates a triangle. There is no option for a filled triangle.
/// @param id
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param x3
/// @param y3
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_triangle(_grid, _x1, _y1, _x2, _y2, _x3, _y3, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		info = {};
		info.x1 = _x1; info.y1 = _y1;
		info.x2 = _x2; info.y2 = _y2;
		info.x3 = _x3; info.y3 = _y3;
		info.replace = _replace;
		info.new_value = _new_value;
		info.chance = _chance;
	}	
	
	//Drawing three lines. (That's basically all this function does).
	jen_line(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _chance, _function);
	jen_line(_grid, _x2, _y2, _x3, _y3, _replace, _new_value, _chance, _function);
	jen_line(_grid, _x3, _y3, _x1, _y1, _replace, _new_value, _chance, _function);
	
	delete info;
}
#endregion
#region jen_ellipse(id, x1, y1, haxis, vaxis, replace, new_value, angle, outline, [chance], [function]);
/// @description Creates an ellipse. Define the length of each axis, and the rotation.
/// @param id
/// @param x1
/// @param y1
/// @param haxis
/// @param vaxis
/// @param replace
/// @param new_value
/// @param angle
/// @param outline
/// @param [chance]
/// @param [function]
function jen_ellipse(_grid, _x1, _y1, _haxis, _vaxis, _replace, _new_value, _angle, _outline, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		info = {};
		info.x1 = _x1; info.y1 = _y1;
		info.replace = _replace;
		info.new_value = _new_value;
		info.angle = _angle;
		info.outline = _outline;
		info.chance = _chance;
	}
	
	//Getting width and height of the grid.
	var _width = ds_grid_width(_grid);
	var _height = ds_grid_height(_grid);
	
	//Estimating the required increment.
	var _increment = 90 / (2 * pi * max(_haxis, _vaxis));
	var _temp_grid = jen_grid_create(_width, _height, noone);
	var xx = 0; var yy = 0;
	
	//Looping around the course of the ellipse and setting values.
	for (var theta = 0; theta <= 360; theta += _increment)
	{
		xx = (_haxis * dcos(theta) * dcos(_angle)) - (_vaxis * dsin(theta) * dsin(_angle));
		yy = (_haxis * dcos(theta) * dsin(_angle)) + (_vaxis * dsin(theta) * dcos(_angle));
		
		//Creating the ellipse in the temporary grid.
		jen_set(_temp_grid, round(_x1 + xx), round(_y1 + yy), all, _new_value);
		if (_outline) { jen_line(_temp_grid, _x1 + xx, _y1 + yy, _x1, _y1, all, _new_value); }
	}
	
	//Applying the temporary grid over the base grid.
	if (_function == noone)	{	jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance);	}
	else { jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance, _function); }
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
	delete info;
}
#endregion