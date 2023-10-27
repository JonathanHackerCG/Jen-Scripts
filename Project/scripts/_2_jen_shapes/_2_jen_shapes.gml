//Basic shape functions. Lines, circle, rectangles, etcetera.

//Primitive shapes.
#region jen_line(JenGrid, xcell1, ycell1, xcell2, ycell2, replace, new_value, [chance], [setter]);
/// @func jen_line(JenGrid, xcell1, ycell1, xcell2, ycell2, replace, new_value, [chance], [setter]):
/// @desc Creates a line between two points.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell1
/// @arg	{Real}				ycell1
/// @arg	{Real}				xcell2
/// @arg	{Real}				ycell2
/// @arg	{Any}					replace			Supports Array (Any Of)
/// @arg	{Any}					new_value		Supports Array (Chooses)
/// @arg	{Real}				[chance]		Default: 100
/// @arg	{Function}		[setter]		Default: jen_set
function jen_line(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _chance = 100, _setter = jen_set)
{
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
		if (_jenternal_percent(_chance))
		{
			//Setting the line position/appropriate function.
			_setter(_grid, round(xx), round(yy), _replace, _new_value);
		}
		//Increment position.
		xx += _xdis;
		yy += _ydis;
		_count ++;
	}
}
#endregion
#region jen_rectangle(JenGrid, xcell1, ycell1, xcell2, ycell2, replace, new_value, [outline], [chance], [setter]);
/// @func jen_rectangle(JenGrid, xcell1, ycell1, xcell2, ycell2, replace, new_value, [outline], [chance], [setter]):
/// @desc Creates a rectangle between two positions.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell1
/// @arg	{Real}				ycell1
/// @arg	{Real}				xcell2
/// @arg	{Real}				ycell2
/// @arg	{Real}				outline			0 = Filled
/// @arg	{Any}					replace			Supports Array (Any Of)
/// @arg	{Any}					new_value		Supports Array (Chooses)
/// @arg	{Real}				[chance]		Default: 100
/// @arg	{Function}		[setter]		Default: jen_set
function jen_rectangle(_grid, _x1, _y1, _x2, _y2, _outline, _replace, _new_value, _chance = 100, _setter = jen_set)
{
	//Finding corners.
	var _xx1 = min(_x1, _x2);
	var _xx2 = max(_x1, _x2);
	var _yy1 = min(_y1, _y2);
	var _yy2 = max(_y1, _y2);
	
	//Array conversions.
	_replace = _jenternal_convert_array_all(_replace);
	
	//Iterate through the grid.
	for (var yy = _yy1; yy <= _yy2; yy++) {
	for (var xx = _xx1; xx <= _xx2; xx++) {
		//Only checking spaces in the rectangle, based on outline.
		var _o = _outline;
		if (!_o || (xx < _xx1 + _o || yy < _yy1 + _o || xx > _xx2 - _o || yy > _yy2 - _o))
		{
			if (_jenternal_percent(_chance))
			{
				_setter(_grid, xx, yy, _replace, _new_value);
			}
		}
		else
		{
			//To skip some unnecessary checks when it is an outline.
			xx = _xx2 - _o;
		}
	} }
}
#endregion
#region jen_circle(JenGrid, xcell1, ycell1, radius, filled, replace, new_value, [chance], [setter]);
/// @func jen_circle(JenGrid, xcell1, ycell1, radius, filled, replace, new_value, [chance], [setter]):
/// @desc	Creates a circle at a location with given radius. The circle may be filled or left an outline.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell1
/// @arg	{Real}				ycell1
/// @arg	{Bool}				filled
/// @arg	{Any}					replace			Supports Array (Any Of)
/// @arg	{Any}					new_value		Supports Array (Chooses)
/// @arg	{Real}				[chance]		Default: 100
/// @arg	{Function}		[setter]		Default: jen_set
function jen_circle(_grid, _x1, _y1, _radius, _filled, _replace, _new_value, _chance = 100, _setter = jen_set)
{
	for (var yy = -_radius; yy <= _radius; yy++) {
	for (var xx = -_radius; xx <= _radius; xx++) {
		var _dis = xx * xx + yy * yy;
		if (_dis >= _radius * _radius + _radius) { continue; }
		if (!_filled && _dis <= _radius * _radius - _radius) { continue; }
		_setter(_grid, _x1 + xx, _y1 + yy, _replace, _new_value);
	} }
}
#endregion
#region jen_ellipse(JenGrid, x1, y1, haxis, vaxis, angle, filled, replace, new_value, [chance], [setter]);
/// @func jen_ellipse(JenGrid, x1, y1, haxis, vaxis, angle, filled, replace, new_value, [chance], [setter]):
/// @desc Creates an ellipse. Define the length of each axis, and the rotation.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell1
/// @arg	{Real}				ycell1
/// @arg  {Real}				haxis
/// @arg  {Real}				vaxis
/// @arg  {Real}				angle
/// @arg	{Bool}				filled
/// @arg	{Any}					replace			Supports Array (Any Of)
/// @arg	{Any}					new_value		Supports Array (Chooses)
/// @arg	{Real}				[chance]		Default: 100
/// @arg	{Function}		[setter]		Default: jen_set
function jen_ellipse(_grid, _x1, _y1, _haxis, _vaxis,  _angle, _filled, _replace, _new_value, _chance = 100, _setter = jen_set)
{
	static L = [];
	static R = [];
	
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	if (_filled)
	{
		L = array_create(_h, undefined);
		R = array_create(_h, undefined);
	}
	
	//Estimating the required increment.
	var _increment = 90 / (2 * pi * max(_haxis, _vaxis));
	var _temp = jen_grid_create(_w, _h, noone);
	
	//Looping around the course of the ellipse and setting values.
	for (var theta = 0; theta <= 360; theta += _increment)
	{
		var xx = (_haxis * dcos(theta) * dcos(_angle)) - (_vaxis * dsin(theta) * dsin(_angle));
		var yy = (_haxis * dcos(theta) * dsin(_angle)) + (_vaxis * dsin(theta) * dcos(_angle));
		
		//Creating the ellipse in the temporary grid.
		xx = round(_x1 + xx);
		yy = round(_y1 + yy);
		jen_set(_temp, xx, yy, all, _new_value);
		
		//Caching L/R bounds of the ellipse for filling later.
		if (_filled && yy >= 0 && yy < _h)
		{
			L[yy] = min(xx, L[yy] ?? xx);
			R[yy] = max(xx, R[yy] ?? xx);
		}
	}
	
	//Filling (scanlines).
	if (_filled)
	{
		for (var yy = 0; yy < _h; yy++)
		{
			if (L[yy] != undefined && R[yy] != undefined)
			{
				jen_line(_temp, L[yy], yy, R[yy], yy, noone, _new_value);
			}
		}
		L = [];
		R = [];
	}
	
	jen_grid_paste(_grid, _temp, 0, 0, _replace, _chance, _setter);
	jen_grid_destroy(_temp); //Cleanup
}
#endregion
//jen_polygon(...);

//Wandering lines.
#region jen_wander_direction(JenGrid, x1, y1, initial_angle, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [setter]);
/// @func jen_wander_direction
/// @desc Will create a wandering line between two positions.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  initial_angle
/// @arg  correction_count
/// @arg  correction_accuracy
/// @arg  adjustment_count
/// @arg  adjustment_accuracy
/// @arg  lifetime
/// @arg  replace
/// @arg  new_value
/// @arg  [chance]
/// @arg  [setter]	
function jen_wander_direction(_grid, _x1, _y1, _initial_angle, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance = 100, _setter = undefined)
{
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = _initial_angle + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_jenternal_percent(_chance))
		{
			//TODO: Update to use jen_set as default _setter parameter.
			if (_setter == undefined)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				_setter(_grid, round(xx), round(yy), _replace, _new_value);
			}
		}
		
		//Updating primary angle.
		if (_correction_count == 0 || _count % _correction_count == 0)
		{
			_angle = _initial_angle + irandom_range(-_correction_accuracy, _correction_accuracy);
		}
		//Updating movement angle.
		if (_adjustment_count == 0 || _count % _adjustment_count == 0)
		{
			var _angle_off = irandom_range(-_adjustment_accuracy, _adjustment_accuracy);
		}
		_angle += _angle_off;
		
		//Calculating a new position.
		xx += lengthdir_x(1, _angle);
		yy += lengthdir_y(1, _angle);

		_count++; //Increment the count.
	}
}
#endregion
#region jen_wander_line(JenGrid, x1, y1, x2, y2, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [setter]);
/// @func jen_wander_line
/// @desc Will create a wandering line between two positions.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  x2
/// @arg  y2
/// @arg  correction_count
/// @arg  correction_accuracy
/// @arg  adjustment_count
/// @arg  adjustment_accuracy
/// @arg  lifetime
/// @arg  replace
/// @arg  new_value
/// @arg  [chance]
/// @arg  [setter]	
function jen_wander_line(_grid, _x1, _y1, _x2, _y2, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance = 100, _setter = jen_set)
{
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = point_direction(_x1, _y1, _x2, _y2) + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_jenternal_percent(_chance))
		{
			//TODO: Update to use jen_set as default _setter parameter.
			if (_setter == undefined)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				_setter(_grid, round(xx), round(yy), _replace, _new_value);
			}
		}
		
		//Updating primary angle.
		if (_correction_count == 0 || _count % _correction_count == 0)
		{
			_angle = point_direction(xx, yy, _x2, _y2) + irandom_range(-_correction_accuracy, _correction_accuracy);
		}
		//Updating movement angle.
		if (_adjustment_count == 0 || _count % _adjustment_count == 0)
		{
			var _angle_off = irandom_range(-_adjustment_accuracy, _adjustment_accuracy);
		}
		
		//Moving directly to the target.
		if (point_distance(xx, yy, _x2, _y2) <= max(_correction_count, _adjustment_count))
		{
			_angle = point_direction(xx, yy, _x2, _y2);
		}
		
		_angle += _angle_off;
		
		//Calculating a new position.
		xx += lengthdir_x(1, _angle);
		yy += lengthdir_y(1, _angle);
		
		_count++; //Increment the count.
		
		//Exit early if it has reached the destination.
		if (point_distance(xx, yy, _x2, _y2) <= 0.5) { exit; }
	}
}
#endregion