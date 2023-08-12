/// @desc MYIMGUI: Step
#region >>> Hotkeys
if (keyboard_check_pressed(vk_escape))
{
	game_end();
}

for (var i = 0; i < _examples_count; i++) {
	if (keyboard_check_pressed(ord(string(i + 1)))) {
		var _example = _examples[i];
		run_example(_example);
	}
}

if (keyboard_check_pressed(vk_tab))
{
	_examples_4x = !_examples_4x;
}

if (keyboard_check_pressed(ord("R")))
{
	room_restart();
	call_later(1, time_source_units_frames, function() {
		run_example(_example_previous);
	});
}
#endregion

ImGui.BeginMainMenuBar();
#region >>> GAME
if (ImGui.BeginMenu("Game")) {
	
	if (ImGui.MenuItem("Exit", "ESC")) {
		game_end();
	}
	
	if (ImGui.MenuItem("Regenerate", "R")) {
		room_restart();
		call_later(1, time_source_units_frames, function() {
			run_example(_example_previous);
		});
	}
ImGui.EndMenu(); }
#endregion
#region >>> EXAMPLES
if (ImGui.BeginMenu("Examples")) {
	_examples_4x = ImGui.Checkbox("4x Examples", _examples_4x);
	ImGui.Separator();
	for (var i = 0; i < _examples_count; i++) {
		var _example = _examples[i];
		if (ImGui.MenuItem(string(i + 1) + " - " + _example.name)) {
			run_example(_example);
		}
	}
ImGui.EndMenu(); }
#endregion
#region >>> DISPLAY
if (ImGui.BeginMenu("Display")) {
	_visible_layer = real(ImGui.InputInt("Layers", _visible_layer, 1, 5));
ImGui.EndMenu(); }
#endregion
ImGui.EndMainMenuBar();

#region More Hotkeys
if (mouse_wheel_down()) { _visible_layer --; }
if (mouse_wheel_up())		{ _visible_layer ++; }
_visible_layer = clamp(_visible_layer, 1, _visible_layer_max);
if (_visible_layer != _visible_layer_previous) {
	with (all) {
		if (depth >= DEPTH_LAYER_5) { visible = (depth >= -MYIMGUI._visible_layer); }
	}
	_visible_layer_previous = _visible_layer;
}
#endregion