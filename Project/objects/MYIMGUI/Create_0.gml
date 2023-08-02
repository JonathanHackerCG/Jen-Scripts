/// @desc MYIMGUI: Create
ImGui.__Initialize();

_visible_layer_max = 1;
_visible_layer = _visible_layer_max;
_visible_layer_previous = undefined;
_visible_layer_max_previous = _visible_layer_max;

_example_previous = undefined;
_examples = [];
_examples_count = 0;
_examples_4x = true;
#region register_example(name, function, [params]);
/// @func register_example(name, function, [params]):
/// @desc Store an example function to be called later.
/// @arg	name
/// @arg	function
/// @arg	[params]
function register_example(_name, _func, _params = undefined)
{
	array_push(_examples, { name : _name, func : _func, params : _params});
	_examples_count ++;
}
#endregion
#region run_example(example);
/// @func run_example(example):
/// @desc Runs an example script based on provided struct.
/// @arg	example
function run_example(_example)
{
	CONTROL.clear_room();
	if (_example == undefined) { exit; }
	
	if (!_examples_4x) {
		_example.func(40, 22, 0, 8);
	}
	else {
		_example.func(20, 11, 0, 8);
		_example.func(20, 11, 20 * JEN_CELLW, 8);
		_example.func(20, 11, 0, 11 * JEN_CELLH + 8);
		_example.func(20, 11, 20 * JEN_CELLW, 11 * JEN_CELLH + 8);
	}
	
	#region Update Depths
	var _min_depth = -1;
	with (all) {
		if (depth >= DEPTH_LAYER_5) {
			_min_depth = min(_min_depth, depth);
			visible = (depth >= -MYIMGUI._visible_layer);
		}
	}
	_visible_layer_max = abs(_min_depth);
	_visible_layer = clamp(_visible_layer, 1, _visible_layer_max);
	if (_example != _example_previous)
	{
		_visible_layer = _visible_layer_max;
	}
	#endregion
	_example_previous = _example;
}
#endregion

register_example("Plains", jen_example_plains);
register_example("Ruins", jen_example_ruins);