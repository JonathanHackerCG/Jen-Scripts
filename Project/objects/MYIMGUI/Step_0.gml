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
#endregion

ImGui.BeginMainMenuBar();
#region >>> GAME
if (ImGui.BeginMenu("Game")) {
	
	if (ImGui.MenuItem("Exit", "ESC")) {
		game_end();
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
ImGui.EndMainMenuBar();