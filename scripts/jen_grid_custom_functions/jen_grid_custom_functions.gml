//Custom distribution functions.

#region jen_custom_template
/// @function jen_custom_template
/// @description Template for custom function operation.
/// @param _x
/// @param _y
/// @param info
function jen_custom_template(_xx, _yy, _info)
{
	//This function shall be executed in the scope of a grid.
	#region Grabbing parameters.
	//_info is a struct which carries the parameters of the original function.
	//_info._replace is the value to be replaced.
	//_info._value is the new value.
	var _replace = _info._replace;
	var _value = _info._value;
	var _chance = _info._chance;
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
	//_info is a struct which carries the parameters of the original function.
	//_info._replace is the value to be replaced.
	//_info._value is the new value.
	var _replace = _info._replace;
	var _value = _info._value;
	var _chance = _info._chance;
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
	//_info is a struct which carries the parameters of the original function.
	//_info._replace is the value to be replaced.
	//_info._value is the new value.
	var _replace = _info._replace;
	var _value = _info._value;
	var _chance = _info._chance;
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
	//This function shall be executed in the scope of a grid.
	#region Grabbing parameters.
	//_info is a struct which carries the parameters of the original function.
	//_info._replace is the value to be replaced.
	//_info._value is the new value.
	var _replace = _info._replace;
	var _value = _info._value;
	var _chance = _info._chance;
	#endregion
	
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