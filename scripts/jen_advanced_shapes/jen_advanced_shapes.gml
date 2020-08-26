//Advanced shapes, wandering lines and mazes.

#region jen_wander_direction(grid, x1, y1, initial_angle, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [function]);
/// @description Will create a wandering line between two positions.
/// @param id
/// @param x1
/// @param y1
/// @param initial_angle
/// @param correction_count
/// @param correction_accuracy
/// @param adjustment_count
/// @param adjustment_accuracy
/// @param lifetime
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_wander_direction(_grid, _x1, _y1, _initial_angle, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		info = {};
		info.x1 = _x1; info.y1 = _y1;
		info.chance = _chance;
		info.initial_angle = _initial_angle;
		info.correction_count = _correction_count;
		info.correction_accuracy = _correction_accuracy;
		info.adjustment_count = _adjustment_count;
		info.adjustment_accuracy = _adjustment_accuracy;
		info.lifetime = _lifetime;
	}
	
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = _initial_angle + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_chance >= 100 || random(100) < _chance)
		{
			if (_function == noone)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				//Run the custom function.
				_function(_grid, round(xx), round(yy), _replace, _new_value, info);
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
#region jen_wander_line(grid, x1, y1, x2, y2, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [function]);
/// @description Will create a wandering line between two positions.
/// @param id
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param correction_count
/// @param correction_accuracy
/// @param adjustment_count
/// @param adjustment_accuracy
/// @param lifetime
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_wander_line(_grid, _x1, _y1, _x2, _y2, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		info = {};
		info.x1 = _x1; info.y1 = _y1;
		info.x2 = _x2; info.y2 = _y2;
		info.chance = _chance;
		info.correction_count = _correction_count;
		info.correction_accuracy = _correction_accuracy;
		info.adjustment_count = _adjustment_count;
		info.adjustment_accuracy = _adjustment_accuracy;
		info.lifetime = _lifetime;
	}
	
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = point_direction(_x1, _y1, _x2, _y2) + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_chance >= 100 || random(100) < _chance)
		{
			if (_function == noone)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				//Run the custom function.
				_function(_grid, round(xx), round(yy), _replace, _new_value, info);
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