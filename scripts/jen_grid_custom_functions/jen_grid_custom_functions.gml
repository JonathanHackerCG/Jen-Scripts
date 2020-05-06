//Custom distribution functions.

#region jen_custom_template
/// @function jen_custom_template
/// @description Template for custom function operation.
/// @param x
/// @param y
/// @param info
function jen_custom_template(_xx, _yy, _info)
{
	//This function shall be executed in the scope of a grid.
	#region Grabbing parameters.
	//_info is a struct which carries the parameters of the original function.
	//This section tests for each possible parameter and assigns it to a local variable if it exists.
	if (!is_undefined(_info._x1)) { var _x1 = _info._x1; }
	if (!is_undefined(_info._y1)) { var _y1 = _info._y1; }
	if (!is_undefined(_info._x2)) { var _x2 = _info._x2; }
	if (!is_undefined(_info._y2)) { var _y2 = _info._y2; }
	if (!is_undefined(_info._replace)) { var _replace = _info._replace; }
	if (!is_undefined(_info._value)) { var _value = _info._value; }
	if (!is_undefined(_info._chance)) { var _chance = _info._chance; }
	#endregion
	
	//Your code here...
	//...
}
#endregion
#region jen_horizontal_sin
function jen_horizontal_sin(_xx, _yy, _info)
{
	//This function shall be executed in the scope of a grid.
	#region Grabbing parameters.
	var _replace = _info._replace;
	var _value = _info._value;
	#endregion
	
	//Placing tiles in a horizontal distribution.
	var percent = sin((pi * _xx) / w);
	if (percent >= random(1))
	{
		set(_xx, _yy, _replace, _value);
	}
}
#endregion
#region jen_horizontal_sinB
function jen_horizontal_sinB(_xx, _yy, _info)
{
	//This function shall be executed in the scope of a grid.
	#region Grabbing parameters.
	var _replace = _info._replace;
	var _value = _info._value;
	#endregion
	
	//Placing tiles in a horizontal distribution.
	var percent = abs(sin((pi * _xx) / w * 4) * sin((pi * _yy) / h / 2));
	if (percent >= random(1))
	{
		set(_xx, _yy, _replace, _value);
	}
}
#endregion
#region jen_customA
/// @function jen_custom_template
/// @description Template for custom function operation.
/// @param _x
/// @param _y
/// @param info
function jen_customA(_xx, _yy, _info)
{
	//Your code here...
	if (_xx <= w / 3)
	{
		jen_horizontal_sin(_xx, _yy, _info);
	}
	else if (_yy >= h / 2)
	{
		jen_horizontal_sinB(_xx, _yy, _info);
	}
	else if (irandom(1))
	{
		set(_xx, _yy, all, "A");
	}
}
#endregion

#region jen_rectangle_sin
/// @function jen_rectangle_sin
/// @description Template for custom function operation.
/// @param x
/// @param y
/// @param info
function jen_rectangle_sin(_xx, _yy, _info)
{
	//This function shall be executed in the scope of a grid.
	#region Grabbing parameters.
	//_info is a struct which carries the parameters of the original function.
	//This section tests for each possible parameter and assigns it to a local variable if it exists.
	if (!is_undefined(_info._x1)) { var _x1 = _info._x1; }
	if (!is_undefined(_info._x2)) { var _x2 = _info._x2; }
	if (!is_undefined(_info._replace)) { var _replace = _info._replace; }
	if (!is_undefined(_info._value)) { var _value = _info._value; }
	#endregion
	
	//Placing tiles in a horizontal distribution.
	var percent = sin((pi * (_xx - _x1)) / (_x2 - _x1));
	if (percent >= random(1))
	{
		set(_xx, _yy, _replace, _value);
	}
}
#endregion
#region jen_rectangle_custom
/// @function jen_rectangle_custom
/// @description Template for custom function operation.
/// @param x
/// @param y
/// @param info
function jen_rectangle_custom(_xx, _yy, _info)
{
	//This function shall be executed in the scope of a grid.
	#region Grabbing parameters.
	//_info is a struct which carries the parameters of the original function.
	//This section tests for each possible parameter and assigns it to a local variable if it exists.
	if (!is_undefined(_info._x1)) { var _x1 = _info._x1; }
	if (!is_undefined(_info._y1)) { var _y1 = _info._y1; }
	if (!is_undefined(_info._x2)) { var _x2 = _info._x2; }
	if (!is_undefined(_info._y2)) { var _y2 = _info._y2; }
	if (!is_undefined(_info._replace)) { var _replace = _info._replace; }
	if (!is_undefined(_info._value)) { var _value = _info._value; }
	#endregion
	
	//Placing tiles in a horizontal distribution.
	var chance = min(_xx - _x1, _x2 - _xx, _yy - _y1, _y2 - _yy);
	if (chance <= random(4))
	{
		set(_xx, _yy, _replace, _value);
	}
}
#endregion