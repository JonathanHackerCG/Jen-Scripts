/**
*  This script includes snake_case function defintions for ImGui_GM, as an alternative to the namespaced convention
*  To use, just drop this script into your project with ImGui_GM
*  Generated at 3/11/2023, 4:16:10 AM
*/

/// @func imgui_initialize
function imgui_initialize() {
	return ImGui_.__Initialize();
}

/// @func imgui_update
function imgui_update() {
	return ImGui_.__Update();
}

/// @func imgui_render
function imgui_render() {
	return ImGui_.__Render();
}

/// @func imgui_create_context()
/// @return {Pointer}
function imgui_create_context() {
	return __imgui_create_context();
}

/// @func imgui_destroy_context(ctx)
/// @argument {Pointer} ctx
/// @return {Undefined}
function imgui_destroy_context(ctx) {
	return __imgui_destroy_context(ctx);
}

/// @func imgui_get_current_context()
/// @return {Pointer}
function imgui_get_current_context() {
	return __imgui_get_current_context();
}

/// @func imgui_set_current_context(ctx)
/// @argument {Pointer} ctx
/// @return {Undefined}
function imgui_set_current_context(ctx) {
	return __imgui_set_current_context(ctx);
}

/// @func imgui_show_demo_window(open)
/// @argument {Bool} [open=undefined]
/// @return {Bool}
function imgui_show_demo_window(open=undefined) {
	return __imgui_show_demo_window(open);
}

/// @func imgui_show_metrics_window(open)
/// @argument {Bool} [open=undefined]
/// @return {Bool}
function imgui_show_metrics_window(open=undefined) {
	return __imgui_show_metrics_window(open);
}

/// @func imgui_show_debug_log_window(open)
/// @argument {Bool} [open=undefined]
/// @return {Bool}
function imgui_show_debug_log_window(open=undefined) {
	return __imgui_show_debug_log_window(open);
}

/// @func imgui_show_stack_tool_window(open)
/// @argument {Bool} [open=undefined]
/// @return {Bool}
function imgui_show_stack_tool_window(open=undefined) {
	return __imgui_show_stack_tool_window(open);
}

/// @func imgui_show_about_window(open)
/// @argument {Bool} [open=undefined]
/// @return {Bool}
function imgui_show_about_window(open=undefined) {
	return __imgui_show_about_window(open);
}

/// @func imgui_show_style_editor()
/// @return {Undefined}
function imgui_show_style_editor() {
	return __imgui_show_style_editor();
}

/// @func imgui_show_style_selector(label)
/// @argument {String} label
/// @return {Bool}
function imgui_show_style_selector(label) {
	return __imgui_show_style_selector(label);
}

/// @func imgui_show_font_selector(label)
/// @argument {String} label
/// @return {Undefined}
function imgui_show_font_selector(label) {
	return __imgui_show_font_selector(label);
}

/// @func imgui_show_user_guide()
/// @return {Undefined}
function imgui_show_user_guide() {
	return __imgui_show_user_guide();
}

/// @func imgui_get_version()
/// @return {String}
function imgui_get_version() {
	return __imgui_get_version();
}

/// @func imgui_push_id(_id)
/// @argument {String|Real} _id
/// @return {Undefined}
function imgui_push_id(_id) {
	return __imgui_push_id(_id);
}

/// @func imgui_pop_id()
/// @return {Undefined}
function imgui_pop_id() {
	return __imgui_pop_id();
}

/// @func imgui_get_id(str_id)
/// @argument {String} str_id
/// @return {Real}
function imgui_get_id(str_id) {
	return __imgui_get_id(str_id);
}

/// @func imgui_begin_disabled(disabled)
/// @argument {Bool} [disabled=true]
/// @return {Undefined}
function imgui_begin_disabled(disabled=true) {
	return __imgui_begin_disabled(disabled);
}

/// @func imgui_end_disabled()
/// @return {Undefined}
function imgui_end_disabled() {
	return __imgui_end_disabled();
}

/// @func imgui_is_item_hovered(flags)
/// @argument {Enum.ImGuiHoveredFlags} [flags=ImGuiHoveredFlags.None]
/// @return {Bool}
function imgui_is_item_hovered(flags=ImGuiHoveredFlags.None) {
	return __imgui_is_item_hovered(flags);
}

/// @func imgui_is_item_active()
/// @return {Bool}
function imgui_is_item_active() {
	return __imgui_is_item_active();
}

/// @func imgui_is_item_focused()
/// @return {Bool}
function imgui_is_item_focused() {
	return __imgui_is_item_focused();
}

/// @func imgui_is_item_clicked(mouse_button)
/// @argument {Enum.ImGuiMouseButton} [mouse_button=ImGuiMouseButton.Left]
/// @return {Bool}
function imgui_is_item_clicked(mouse_button=ImGuiMouseButton.Left) {
	return __imgui_is_item_clicked(mouse_button);
}

/// @func imgui_is_item_visible()
/// @return {Bool}
function imgui_is_item_visible() {
	return __imgui_is_item_visible();
}

/// @func imgui_is_item_edited()
/// @return {Bool}
function imgui_is_item_edited() {
	return __imgui_is_item_edited();
}

/// @func imgui_is_item_activated()
/// @return {Bool}
function imgui_is_item_activated() {
	return __imgui_is_item_activated();
}

/// @func imgui_is_item_deactivated()
/// @return {Bool}
function imgui_is_item_deactivated() {
	return __imgui_is_item_deactivated();
}

/// @func imgui_is_item_deactivated_after_edit()
/// @return {Bool}
function imgui_is_item_deactivated_after_edit() {
	return __imgui_is_item_deactivated_after_edit();
}

/// @func imgui_is_item_toggled_open()
/// @return {Bool}
function imgui_is_item_toggled_open() {
	return __imgui_is_item_toggled_open();
}

/// @func imgui_is_any_item_hovered()
/// @return {Bool}
function imgui_is_any_item_hovered() {
	return __imgui_is_any_item_hovered();
}

/// @func imgui_is_any_item_active()
/// @return {Bool}
function imgui_is_any_item_active() {
	return __imgui_is_any_item_active();
}

/// @func imgui_is_any_item_focused()
/// @return {Bool}
function imgui_is_any_item_focused() {
	return __imgui_is_any_item_focused();
}

/// @func imgui_get_item_id()
/// @return {Real}
function imgui_get_item_id() {
	return __imgui_get_item_id();
}

/// @func imgui_get_item_rect_min_x()
/// @return {Real}
function imgui_get_item_rect_min_x() {
	return __imgui_get_item_rect_min_x();
}

/// @func imgui_get_item_rect_min_y()
/// @return {Real}
function imgui_get_item_rect_min_y() {
	return __imgui_get_item_rect_min_y();
}

/// @func imgui_get_item_rect_max_x()
/// @return {Real}
function imgui_get_item_rect_max_x() {
	return __imgui_get_item_rect_max_x();
}

/// @func imgui_get_item_rect_max_y()
/// @return {Real}
function imgui_get_item_rect_max_y() {
	return __imgui_get_item_rect_max_y();
}

/// @func imgui_get_item_rect_size_x()
/// @return {Real}
function imgui_get_item_rect_size_x() {
	return __imgui_get_item_rect_size_x();
}

/// @func imgui_get_item_rect_size_y()
/// @return {Real}
function imgui_get_item_rect_size_y() {
	return __imgui_get_item_rect_size_y();
}

/// @func imgui_set_item_allow_overlap()
/// @return {Undefined}
function imgui_set_item_allow_overlap() {
	return __imgui_set_item_allow_overlap();
}

/// @func imgui_is_rect_visible(x1, y1, x2, y2)
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @return {Bool}
function imgui_is_rect_visible(x1, y1, x2, y2) {
	return __imgui_is_rect_visible(x1, y1, x2, y2);
}

/// @func imgui_get_time()
/// @return {Real}
function imgui_get_time() {
	return __imgui_get_time();
}

/// @func imgui_get_frame_count()
/// @return {Real}
function imgui_get_frame_count() {
	return __imgui_get_frame_count();
}

/// @func imgui_calc_text_width(text, hide_text_after_double_hash, wrap_width)
/// @argument {String} text
/// @argument {Bool} [hide_text_after_double_hash=false]
/// @argument {Real} [wrap_width=-1]
/// @return {Real}
function imgui_calc_text_width(text, hide_text_after_double_hash=false, wrap_width=-1) {
	return __imgui_calc_text_width(text, hide_text_after_double_hash, wrap_width);
}

/// @func imgui_calc_text_height(text, hide_text_after_double_hash, wrap_width)
/// @argument {String} text
/// @argument {Bool} [hide_text_after_double_hash=false]
/// @argument {Real} [wrap_width=-1]
/// @return {Real}
function imgui_calc_text_height(text, hide_text_after_double_hash=false, wrap_width=-1) {
	return __imgui_calc_text_height(text, hide_text_after_double_hash, wrap_width);
}

/// @func imgui_push_allow_keyboard_focus(allow_keyboard_focus)
/// @argument {Bool} allow_keyboard_focus
/// @return {Undefined}
function imgui_push_allow_keyboard_focus(allow_keyboard_focus) {
	return __imgui_push_allow_keyboard_focus(allow_keyboard_focus);
}

/// @func imgui_pop_allow_keyboard_focus()
/// @return {Undefined}
function imgui_pop_allow_keyboard_focus() {
	return __imgui_pop_allow_keyboard_focus();
}

/// @func imgui_set_keyboard_focus_here(offset)
/// @argument {Real} [offset=0]
/// @return {Undefined}
function imgui_set_keyboard_focus_here(offset=0) {
	return __imgui_set_keyboard_focus_here(offset);
}

/// @func imgui_push_button_repeat(_repeat)
/// @argument {Bool} _repeat
/// @return {Undefined}
function imgui_push_button_repeat(_repeat) {
	return __imgui_push_button_repeat(_repeat);
}

/// @func imgui_pop_button_repeat()
/// @return {Undefined}
function imgui_pop_button_repeat() {
	return __imgui_pop_button_repeat();
}

/// @func imgui_set_item_default_focus()
/// @return {Undefined}
function imgui_set_item_default_focus() {
	return __imgui_set_item_default_focus();
}

/// @func imgui_config_flags_get()
/// @return {Real}
function imgui_config_flags_get() {
	return __imgui_config_flags_get();
}

/// @func imgui_config_flags_set(flags)
/// @argument {Real} flags
/// @return {Unknown<unset>}
function imgui_config_flags_set(flags) {
	return __imgui_config_flags_set(flags);
}

/// @func imgui_config_flag_toggle(flag)
/// @argument {Real} flag
/// @return {Bool}
function imgui_config_flag_toggle(flag) {
	return __imgui_config_flag_toggle(flag);
}

/// @func imgui_get_main_viewport()
/// @return {Pointer}
function imgui_get_main_viewport() {
	return __imgui_get_main_viewport();
}

/// @func imgui_log_text(text)
/// @argument {String} text
/// @return {Undefined}
function imgui_log_text(text) {
	return __imgui_log_text(text);
}

/// @func imgui_want_keyboard_capture(val)
/// @argument {Bool} [val=undefined]
/// @return {Bool}
function imgui_want_keyboard_capture(val=undefined) {
	return __imgui_want_keyboard_capture(val);
}

/// @func imgui_want_mouse_capture(val)
/// @argument {Bool} [val=undefined]
/// @return {Bool}
function imgui_want_mouse_capture(val=undefined) {
	return __imgui_want_mouse_capture(val);
}

/// @func imgui_want_text_input(val)
/// @argument {Bool} [val=undefined]
/// @return {Bool}
function imgui_want_text_input(val=undefined) {
	return __imgui_want_text_input(val);
}

/// @func imgui_want_mouse_unless_popup_close(val)
/// @argument {Bool} [val=undefined]
/// @return {Bool}
function imgui_want_mouse_unless_popup_close(val=undefined) {
	return __imgui_want_mouse_unless_popup_close(val);
}

/// @func imgui_color_edit3(label, col, flags)
/// @argument {String} label
/// @argument {Real} col
/// @argument {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
/// @return {Real}
function imgui_color_edit3(label, col, flags=ImGuiColorEditFlags.None) {
	return __imgui_color_edit3(label, col, flags);
}

/// @func imgui_color_picker3(label, col, flags)
/// @argument {String} label
/// @argument {Real} col
/// @argument {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
/// @return {Real}
function imgui_color_picker3(label, col, flags=ImGuiColorEditFlags.None) {
	return __imgui_color_picker3(label, col, flags);
}

/// @func imgui_color_edit4(label, col, flags)
/// @argument {String} label
/// @argument {ImColor} col
/// @argument {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
/// @return {Bool}
function imgui_color_edit4(label, col, flags=ImGuiColorEditFlags.None) {
	return __imgui_color_edit4(label, col, flags);
}

/// @func imgui_color_picker4(label, col, flags)
/// @argument {String} label
/// @argument {ImColor} col
/// @argument {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
/// @return {Bool}
function imgui_color_picker4(label, col, flags=ImGuiColorEditFlags.None) {
	return __imgui_color_picker4(label, col, flags);
}

/// @func imgui_color_button(desc_id, color, alpha, flags, width, height)
/// @argument {String} desc_id
/// @argument {Real} color
/// @argument {Real} [alpha=1]
/// @argument {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @return {Bool}
function imgui_color_button(desc_id, color, alpha=1, flags=ImGuiColorEditFlags.None, width=0, height=0) {
	return __imgui_color_button(desc_id, color, alpha, flags, width, height);
}

/// @func imgui_set_color_edit_options(flags)
/// @argument {Enum.ImGuiCol} [flags=ImGuiColorEditFlags.None]
/// @return {Undefined}
function imgui_set_color_edit_options(flags=ImGuiColorEditFlags.None) {
	return __imgui_set_color_edit_options(flags);
}

/// @func imgui_begin_combo(label, preview, flags)
/// @argument {String} label
/// @argument {String} preview
/// @argument {Real} flags
/// @return {Bool}
function imgui_begin_combo(label, preview, flags) {
	return __imgui_begin_combo(label, preview, flags);
}

/// @func imgui_end_combo()
/// @return {Undefined}
function imgui_end_combo() {
	return __imgui_end_combo();
}

/// @func imgui_combo()
/// @return {Unknown<unset>}
function imgui_combo() {
	return __imgui_combo();
}

/// @func imgui_dock_space(_id, width, height, flags)
/// @argument {Real} _id
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @argument {Enum.ImGuiDockNodeFlags} [flags=ImGuiDockNodeFlags.None]
/// @return {Real}
function imgui_dock_space(_id, width=0, height=0, flags=ImGuiDockNodeFlags.None) {
	return __imgui_dock_space(_id, width, height, flags);
}

/// @func imgui_dock_space_over_viewport(flags)
/// @argument {Enum.ImGuiDockNodeFlags} [flags=ImGuiDockNodeFlags.None]
/// @return {Real}
function imgui_dock_space_over_viewport(flags=ImGuiDockNodeFlags.None) {
	return __imgui_dock_space_over_viewport(flags);
}

/// @func imgui_set_next_window_dock_id(dock_id, cond)
/// @argument {Real} dock_id
/// @argument {Real} cond
/// @return {Undefined}
function imgui_set_next_window_dock_id(dock_id, cond) {
	return __imgui_set_next_window_dock_id(dock_id, cond);
}

/// @func imgui_set_next_window_class()
/// @return {Unknown<unset>}
function imgui_set_next_window_class() {
	return __imgui_set_next_window_class();
}

/// @func imgui_get_window_dock_id()
/// @return {Real}
function imgui_get_window_dock_id() {
	return __imgui_get_window_dock_id();
}

/// @func imgui_is_window_docked()
/// @return {Bool}
function imgui_is_window_docked() {
	return __imgui_is_window_docked();
}

/// @func imgui_drag_float(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Real} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Real}
function imgui_drag_float(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_float(label, v, v_speed, v_min, v_max, format, flags);
}

/// @func imgui_drag_float2(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_float2(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_float2(label, v, v_speed, v_min, v_max, format, flags);
}

/// @func imgui_drag_float3(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_float3(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_float3(label, v, v_speed, v_min, v_max, format, flags);
}

/// @func imgui_drag_float4(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_float4(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_float4(label, v, v_speed, v_min, v_max, format, flags);
}

/// @func imgui_drag_floatn(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_floatn(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_floatn(label, v, v_speed, v_min, v_max, format, flags, array_length(v));
}

/// @func imgui_drag_float_range2(label, v, v_speed, v_min, v_max, format_min, format_max, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format_min=%.3f]
/// @argument {String} [format_max=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_float_range2(label, v, v_speed=1, v_min=0, v_max=0, format_min="%.3f", format_max="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_float_range2(label, v, v_speed, v_min, v_max, format_min, format_max, flags);
}

/// @func imgui_drag_int(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Real} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Real}
function imgui_drag_int(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_int(label, v, v_speed, v_min, v_max, format, flags);
}

/// @func imgui_drag_int2(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_int2(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_int2(label, v, v_speed, v_min, v_max, format, flags);
}

/// @func imgui_drag_int3(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_int3(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_int3(label, v, v_speed, v_min, v_max, format, flags);
}

/// @func imgui_drag_int4(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_int4(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_int4(label, v, v_speed, v_min, v_max, format, flags);
}

/// @func imgui_drag_intn(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_intn(label, v, v_speed=1, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_intn(label, v, v_speed, v_min, v_max, format, flags, array_length(v));
}

/// @func imgui_drag_int_range2(label, v, v_current_max, v_speed, v_min, v_max, format_max, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} v_current_max
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format_max=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_drag_int_range2(label, v, v_current_max, v_speed=1, v_min=0, v_max=0, format_max="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_drag_int_range2(label, v, v_current_max, v_speed, v_min, v_max, format_max, flags);
}

/// @func imgui_get_background_drawlist(viewport)
/// @argument {Pointer} [viewport=undefined]
/// @return {Pointer}
function imgui_get_background_drawlist(viewport=undefined) {
	return __imgui_get_background_drawlist(viewport);
}

/// @func imgui_get_foreground_drawlist(viewport)
/// @argument {Pointer} [viewport=undefined]
/// @return {Pointer}
function imgui_get_foreground_drawlist(viewport=undefined) {
	return __imgui_get_foreground_drawlist(viewport);
}

/// @func imgui_get_window_drawlist()
/// @return {Pointer}
function imgui_get_window_drawlist() {
	return __imgui_get_window_drawlist();
}

/// @func imgui_drawlist_add_line(list, x1, y1, x2, y2, col, thickness)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} col
/// @argument {Real} [thickness=1]
/// @return {Undefined}
function imgui_drawlist_add_line(list, x1, y1, x2, y2, col, thickness=1) {
	return __imgui_drawlist_add_line(list, x1, y1, x2, y2, col, thickness);
}

/// @func imgui_drawlist_add_rect(list, x1, y1, x2, y2, col, rounding, flags, thickness)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} col
/// @argument {Real} [rounding=0]
/// @argument {Enum.ImDrawFlags} [flags=ImDrawFlags.None]
/// @argument {Real} [thickness=1]
/// @return {Undefined}
function imgui_drawlist_add_rect(list, x1, y1, x2, y2, col, rounding=0, flags=ImDrawFlags.None, thickness=1) {
	return __imgui_drawlist_add_rect(list, x1, y1, x2, y2, col, rounding, flags, thickness);
}

/// @func imgui_drawlist_add_rect_filled(list, x1, y1, x2, y2, col, rounding, flags)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} col
/// @argument {Real} [rounding=0]
/// @argument {Enum.ImDrawFlags} [flags=ImDrawFlags.None]
/// @return {Undefined}
function imgui_drawlist_add_rect_filled(list, x1, y1, x2, y2, col, rounding=0, flags=ImDrawFlags.None) {
	return __imgui_drawlist_add_rect_filled(list, x1, y1, x2, y2, col, rounding, flags);
}

/// @func imgui_drawlist_add_rect_filled_multicolor(list, x1, y1, x2, y2, col1, col2, col3, col4)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} col1
/// @argument {Real} col2
/// @argument {Real} col3
/// @argument {Real} col4
/// @return {Undefined}
function imgui_drawlist_add_rect_filled_multicolor(list, x1, y1, x2, y2, col1, col2, col3, col4) {
	return __imgui_drawlist_add_rect_filled_multicolor(list, x1, y1, x2, y2, col1, col2, col3, col4);
}

/// @func imgui_drawlist_add_quad(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} x3
/// @argument {Real} y3
/// @argument {Real} x4
/// @argument {Real} y4
/// @argument {Real} col
/// @argument {Real} [thickness=1]
/// @return {Undefined}
function imgui_drawlist_add_quad(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness=1) {
	return __imgui_drawlist_add_quad(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness);
}

/// @func imgui_drawlist_add_quad_filled(list, x1, y1, x2, y2, x3, y3, x4, y4, col)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} x3
/// @argument {Real} y3
/// @argument {Real} x4
/// @argument {Real} y4
/// @argument {Real} col
/// @return {Undefined}
function imgui_drawlist_add_quad_filled(list, x1, y1, x2, y2, x3, y3, x4, y4, col) {
	return __imgui_drawlist_add_quad_filled(list, x1, y1, x2, y2, x3, y3, x4, y4, col);
}

/// @func imgui_drawlist_add_triangle(list, x1, y1, x2, y2, x3, y3, col, thickness)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} x3
/// @argument {Real} y3
/// @argument {Real} col
/// @argument {Real} [thickness=1]
/// @return {Undefined}
function imgui_drawlist_add_triangle(list, x1, y1, x2, y2, x3, y3, col, thickness=1) {
	return __imgui_drawlist_add_triangle(list, x1, y1, x2, y2, x3, y3, col, thickness);
}

/// @func imgui_drawlist_add_triangle_filled(list, x1, y1, x2, y2, x3, y3, col)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} x3
/// @argument {Real} y3
/// @argument {Real} col
/// @return {Undefined}
function imgui_drawlist_add_triangle_filled(list, x1, y1, x2, y2, x3, y3, col) {
	return __imgui_drawlist_add_triangle_filled(list, x1, y1, x2, y2, x3, y3, col);
}

/// @func imgui_drawlist_add_circle(list, _x, _y, radius, col, num_segments, thickness)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {Real} radius
/// @argument {Real} col
/// @argument {Real} [num_segments=0]
/// @argument {Real} [thickness=1]
/// @return {Undefined}
function imgui_drawlist_add_circle(list, _x, _y, radius, col, num_segments=0, thickness=1) {
	return __imgui_drawlist_add_circle(list, _x, _y, radius, col, num_segments, thickness);
}

/// @func imgui_drawlist_add_circle_filled(list, _x, _y, radius, col, num_segments)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {Real} radius
/// @argument {Real} col
/// @argument {Real} [num_segments=0]
/// @return {Undefined}
function imgui_drawlist_add_circle_filled(list, _x, _y, radius, col, num_segments=0) {
	return __imgui_drawlist_add_circle_filled(list, _x, _y, radius, col, num_segments);
}

/// @func imgui_drawlist_add_ngon(list, _x, _y, radius, col, num_segments, thickness)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {Real} radius
/// @argument {Real} col
/// @argument {Real} [num_segments=0]
/// @argument {Real} [thickness=1]
/// @return {Undefined}
function imgui_drawlist_add_ngon(list, _x, _y, radius, col, num_segments=0, thickness=1) {
	return __imgui_drawlist_add_ngon(list, _x, _y, radius, col, num_segments, thickness);
}

/// @func imgui_drawlist_add_ngon_filled(list, _x, _y, radius, col, num_segments)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {Real} radius
/// @argument {Real} col
/// @argument {Real} [num_segments=0]
/// @return {Undefined}
function imgui_drawlist_add_ngon_filled(list, _x, _y, radius, col, num_segments=0) {
	return __imgui_drawlist_add_ngon_filled(list, _x, _y, radius, col, num_segments);
}

/// @func imgui_drawlist_add_text(list, _x, _y, text, col)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {String} text
/// @argument {Real} col
/// @return {Undefined}
function imgui_drawlist_add_text(list, _x, _y, text, col) {
	return __imgui_drawlist_add_text(list, _x, _y, text, col);
}

/// @func imgui_drawlist_add_text_font(list, _x, _y, text, col, font, font_size, wrap_width)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {String} text
/// @argument {Real} col
/// @argument {Pointer} font
/// @argument {Real} font_size
/// @argument {Real} [wrap_width=0]
/// @return {Undefined}
function imgui_drawlist_add_text_font(list, _x, _y, text, col, font, font_size, wrap_width=0) {
	return __imgui_drawlist_add_text_font(list, _x, _y, text, col, font, font_size, wrap_width);
}

/// @func imgui_drawlist_add_polyline(list, positions, col, flags, thickness)
/// @argument {Pointer} list
/// @argument {Array<Real>} positions
/// @argument {Real} col
/// @argument {Enum.ImDrawFlags} flags
/// @argument {Real} thickness
/// @return {Undefined}
function imgui_drawlist_add_polyline(list, positions, col, flags, thickness) {
	return __imgui_drawlist_add_polyline(list, positions, col, flags, thickness, array_length(positions));
}

/// @func imgui_drawlist_add_convex_poly_filled(list, positions, col)
/// @argument {Pointer} list
/// @argument {Array<Real>} positions
/// @argument {Real} col
/// @return {Undefined}
function imgui_drawlist_add_convex_poly_filled(list, positions, col) {
	return __imgui_drawlist_add_convex_poly_filled(list, positions, col, array_length(positions));
}

/// @func imgui_drawlist_add_bezier_cubic(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness, num_segments)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} x3
/// @argument {Real} y3
/// @argument {Real} x4
/// @argument {Real} y4
/// @argument {Real} col
/// @argument {Real} thickness
/// @argument {Real} [num_segments=0]
/// @return {Undefined}
function imgui_drawlist_add_bezier_cubic(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness, num_segments=0) {
	return __imgui_drawlist_add_bezier_cubic(list, x1, y1, x2, y2, x3, y3, x4, y4, col, thickness, num_segments);
}

/// @func imgui_drawlist_add_bezier_quadratic(list, x1, y1, x2, y2, x3, y3, col, thickness, num_segments)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} x3
/// @argument {Real} y3
/// @argument {Real} col
/// @argument {Real} thickness
/// @argument {Real} [num_segments=0]
/// @return {Undefined}
function imgui_drawlist_add_bezier_quadratic(list, x1, y1, x2, y2, x3, y3, col, thickness, num_segments=0) {
	return __imgui_drawlist_add_bezier_quadratic(list, x1, y1, x2, y2, x3, y3, col, thickness, num_segments);
}

/// @func imgui_drawlist_path_fill_convex(list, col)
/// @argument {Pointer} list
/// @argument {Real} col
/// @return {Undefined}
function imgui_drawlist_path_fill_convex(list, col) {
	return __imgui_drawlist_path_fill_convex(list, col);
}

/// @func imgui_drawlist_path_stroke(list, col, flags, thickness)
/// @argument {Pointer} list
/// @argument {Real} col
/// @argument {Enum.ImDrawFlags} [flags=ImDrawFlags.None]
/// @argument {Real} [thickness=1]
/// @return {Undefined}
function imgui_drawlist_path_stroke(list, col, flags=ImDrawFlags.None, thickness=1) {
	return __imgui_drawlist_path_stroke(list, col, flags, thickness);
}

/// @func imgui_drawlist_path_clear(list)
/// @argument {Pointer} list
/// @return {Undefined}
function imgui_drawlist_path_clear(list) {
	return __imgui_drawlist_path_clear(list);
}

/// @func imgui_drawlist_path_line_to(list, _x, _y)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @return {Undefined}
function imgui_drawlist_path_line_to(list, _x, _y) {
	return __imgui_drawlist_path_line_to(list, _x, _y);
}

/// @func imgui_drawlist_path_line_to_merge_duplicate(list, _x, _y)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @return {Undefined}
function imgui_drawlist_path_line_to_merge_duplicate(list, _x, _y) {
	return __imgui_drawlist_path_line_to_merge_duplicate(list, _x, _y);
}

/// @func imgui_drawlist_path_arc_to(list, _x, _y, radius, a_min, a_max, num_segments)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {Real} radius
/// @argument {Real} a_min
/// @argument {Real} a_max
/// @argument {Real} [num_segments=0]
/// @return {Undefined}
function imgui_drawlist_path_arc_to(list, _x, _y, radius, a_min, a_max, num_segments=0) {
	return __imgui_drawlist_path_arc_to(list, _x, _y, radius, a_min, a_max, num_segments);
}

/// @func imgui_drawlist_path_arc_to_fast(list, _x, _y, radius, a_min_of_12, a_max_of_12)
/// @argument {Pointer} list
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {Real} radius
/// @argument {Real} a_min_of_12
/// @argument {Real} a_max_of_12
/// @return {Undefined}
function imgui_drawlist_path_arc_to_fast(list, _x, _y, radius, a_min_of_12, a_max_of_12) {
	return __imgui_drawlist_path_arc_to_fast(list, _x, _y, radius, a_min_of_12, a_max_of_12);
}

/// @func imgui_drawlist_path_bezier_cubic_curve_to(list, x2, y2, x3, y3, x4, y4, num_segments)
/// @argument {Pointer} list
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} x3
/// @argument {Real} y3
/// @argument {Real} x4
/// @argument {Real} y4
/// @argument {Real} [num_segments=0]
/// @return {Undefined}
function imgui_drawlist_path_bezier_cubic_curve_to(list, x2, y2, x3, y3, x4, y4, num_segments=0) {
	return __imgui_drawlist_path_bezier_cubic_curve_to(list, x2, y2, x3, y3, x4, y4, num_segments);
}

/// @func imgui_drawlist_path_bezier_quadratic_curve_to(list, x2, y2, x3, y3, num_segments)
/// @argument {Pointer} list
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} x3
/// @argument {Real} y3
/// @argument {Real} [num_segments=0]
/// @return {Undefined}
function imgui_drawlist_path_bezier_quadratic_curve_to(list, x2, y2, x3, y3, num_segments=0) {
	return __imgui_drawlist_path_bezier_quadratic_curve_to(list, x2, y2, x3, y3, num_segments);
}

/// @func imgui_drawlist_path_rect(list, x1, y1, x2, y2, rounding, flags)
/// @argument {Pointer} list
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} [rounding=0]
/// @argument {Enum.ImDrawFlags} [flags=ImDrawFlags.None]
/// @return {Undefined}
function imgui_drawlist_path_rect(list, x1, y1, x2, y2, rounding=0, flags=ImDrawFlags.None) {
	return __imgui_drawlist_path_rect(list, x1, y1, x2, y2, rounding, flags);
}

/// @func imgui_drawlist_add_image(list, sprite, subimg, x1, y1, x2, y2, col)
/// @argument {Pointer} list
/// @argument {Real} sprite
/// @argument {Real} subimg
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} [col=c_white]
/// @return {Undefined}
function imgui_drawlist_add_image(list, sprite, subimg, x1, y1, x2, y2, col=c_white) {
	return __imgui_drawlist_add_image(list, sprite, subimg, x1, y1, x2, y2, col, sprite_get_uvs(sprite, subimg));
}

/// @func imgui_drawlist_add_image_rounded(list, sprite, subimg, x1, y1, x2, y2, col, rounding, flags)
/// @argument {Pointer} list
/// @argument {Real} sprite
/// @argument {Real} subimg
/// @argument {Real} x1
/// @argument {Real} y1
/// @argument {Real} x2
/// @argument {Real} y2
/// @argument {Real} col
/// @argument {Real} rounding
/// @argument {Real} flags
/// @return {Undefined}
function imgui_drawlist_add_image_rounded(list, sprite, subimg, x1, y1, x2, y2, col, rounding, flags) {
	return __imgui_drawlist_add_image_rounded(list, sprite, subimg, x1, y1, x2, y2, col, rounding, flags, sprite_get_uvs(sprite, subimg));
}

/// @func imgui_drawlist_push_clip_rect(list, clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect)
/// @argument {Pointer} list
/// @argument {Real} clip_min_x
/// @argument {Real} clip_min_y
/// @argument {Real} clip_max_x
/// @argument {Real} clip_max_y
/// @argument {Bool} intersect_with_current_clip_rect
/// @return {Undefined}
function imgui_drawlist_push_clip_rect(list, clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect) {
	return __imgui_drawlist_push_clip_rect(list, clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect);
}

/// @func imgui_drawlist_push_clip_rect_fullscreen(list)
/// @argument {Pointer} list
/// @return {Undefined}
function imgui_drawlist_push_clip_rect_fullscreen(list) {
	return __imgui_drawlist_push_clip_rect_fullscreen(list);
}

/// @func imgui_drawlist_pop_clip_rect(list)
/// @argument {Pointer} list
/// @return {Undefined}
function imgui_drawlist_pop_clip_rect(list) {
	return __imgui_drawlist_pop_clip_rect(list);
}

/// @func imgui_drawlist_push_textureid(list, sprite, subimg)
/// @argument {Pointer} list
/// @argument {Real} sprite
/// @argument {Real} subimg
/// @return {Undefined}
function imgui_drawlist_push_textureid(list, sprite, subimg) {
	return __imgui_drawlist_push_textureid(list, sprite, subimg);
}

/// @func imgui_drawlist_pop_textureid(list)
/// @argument {Pointer} list
/// @return {Undefined}
function imgui_drawlist_pop_textureid(list) {
	return __imgui_drawlist_pop_textureid(list);
}

/// @func imgui_drawlist_flags_get(list)
/// @argument {Pointer} list
/// @return {Real}
function imgui_drawlist_flags_get(list) {
	return __imgui_drawlist_flags_get(list);
}

/// @func imgui_drawlist_flags_set(list, flags)
/// @argument {Pointer} list
/// @argument {Real} flags
/// @return {Undefined}
function imgui_drawlist_flags_set(list, flags) {
	return __imgui_drawlist_flags_set(list, flags);
}

/// @func imgui_drawlist_flag_toggle(list, flag)
/// @argument {Pointer} list
/// @argument {Real} flag
/// @return {Bool}
function imgui_drawlist_flag_toggle(list, flag) {
	return __imgui_drawlist_flag_toggle(list, flag);
}

/// @func imgui_memory_editor_window(title, buffer, offset, size)
/// @argument {String} title
/// @argument {Real} buffer
/// @argument {Real} [offset=0]
/// @argument {Real} [size=buffer_get_size⌊buffer⌉]
/// @return {Undefined}
function imgui_memory_editor_window(title, buffer, offset=0, size=buffer_get_size(buffer)) {
	return __imgui_memory_editor_window(title, buffer, offset, size);
}

/// @func imgui_memory_editor_contents(buffer, offset, size)
/// @argument {Real} buffer
/// @argument {Real} [offset=0]
/// @argument {Real} [size=buffer_get_size⌊buffer⌉]
/// @return {Undefined}
function imgui_memory_editor_contents(buffer, offset=0, size=buffer_get_size(buffer)) {
	return __imgui_memory_editor_contents(buffer, offset, size);
}

/// @func imgui_get_font()
/// @return {Pointer}
function imgui_get_font() {
	return __imgui_get_font();
}

/// @func imgui_get_font_size()
/// @return {Real}
function imgui_get_font_size() {
	return __imgui_get_font_size();
}

/// @func imgui_push_font(ptr)
/// @argument {Any} [ptr=undefined]
/// @return {Undefined}
function imgui_push_font(ptr=undefined) {
	return __imgui_push_font(ptr);
}

/// @func imgui_pop_font()
/// @return {Undefined}
function imgui_pop_font() {
	return __imgui_pop_font();
}

/// @func imgui_add_font_from_file(file, size)
/// @argument {String} file
/// @argument {Real} size
/// @return {Pointer|Undefined}
function imgui_add_font_from_file(file, size) {
	return __imgui_add_font_from_file(file, size);
}

/// @func imgui_add_font_default()
/// @return {Unknown<unset>}
function imgui_add_font_default() {
	return __imgui_add_font_default();
}

/// @func imguigm_native()
/// @return {Bool}
function imguigm_native() {
	return __imguigm_native();
}

/// @func imguigm_command_buffer()
/// @return {Real}
function imguigm_command_buffer() {
	return __imguigm_command_buffer();
}

/// @func imguigm_font_buffer()
/// @return {Real}
function imguigm_font_buffer() {
	return __imguigm_font_buffer();
}

/// @func imguigm_keepalive()
/// @return {Real}
function imguigm_keepalive() {
	return __imguigm_keepalive();
}

/// @func imgui_input_text(label, val, flags)
/// @argument {String} label
/// @argument {String} val
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {String}
function imgui_input_text(label, val, flags=ImGuiInputTextFlags.None) {
	return __imgui_input_text(label, val, flags);
}

/// @func imgui_input_textmultiline(label, val, width, height, flags)
/// @argument {String} label
/// @argument {String} val
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {String}
function imgui_input_textmultiline(label, val, width=0, height=0, flags=ImGuiInputTextFlags.None) {
	return __imgui_input_textmultiline(label, val, width, height, flags);
}

/// @func imgui_input_textwithhint(label, hint, val, flags)
/// @argument {String} label
/// @argument {String} hint
/// @argument {String} val
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {String}
function imgui_input_textwithhint(label, hint, val, flags=ImGuiInputTextFlags.None) {
	return __imgui_input_textwithhint(label, hint, val, flags);
}

/// @func imgui_input_float(label, v, step, step_fast, format, flags)
/// @argument {String} label
/// @argument {Real} v
/// @argument {Real} [step=0]
/// @argument {Real} [step_fast=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Real}
function imgui_input_float(label, v, step=0, step_fast=0, format="%.3f", flags=ImGuiInputTextFlags.None) {
	return __imgui_input_float(label, v, step, step_fast, format, flags);
}

/// @func imgui_input_float2(label, v, step, step_fast, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [step=0]
/// @argument {Real} [step_fast=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Bool}
function imgui_input_float2(label, v, step=0, step_fast=0, format="%.3f", flags=ImGuiInputTextFlags.None) {
	return __imgui_input_float2(label, v, step, step_fast, format, flags);
}

/// @func imgui_input_float3(label, v, step, step_fast, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [step=0]
/// @argument {Real} [step_fast=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Bool}
function imgui_input_float3(label, v, step=0, step_fast=0, format="%.3f", flags=ImGuiInputTextFlags.None) {
	return __imgui_input_float3(label, v, step, step_fast, format, flags);
}

/// @func imgui_input_float4(label, v, step, step_fast, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [step=0]
/// @argument {Real} [step_fast=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Bool}
function imgui_input_float4(label, v, step=0, step_fast=0, format="%.3f", flags=ImGuiInputTextFlags.None) {
	return __imgui_input_float4(label, v, step, step_fast, format, flags);
}

/// @func imgui_input_floatn(label, v, step, step_fast, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [step=0]
/// @argument {Real} [step_fast=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Bool}
function imgui_input_floatn(label, v, step=0, step_fast=0, format="%.3f", flags=ImGuiInputTextFlags.None) {
	return __imgui_input_floatn(label, v, step, step_fast, format, flags, array_length(v));
}

/// @func imgui_input_int(label, v, step, step_fast, flags)
/// @argument {String} label
/// @argument {Real} v
/// @argument {Real} [step=0]
/// @argument {Real} [step_fast=0]
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Real}
function imgui_input_int(label, v, step=0, step_fast=0, flags=ImGuiInputTextFlags.None) {
	return __imgui_input_int(label, v, step, step_fast, flags);
}

/// @func imgui_input_int2(label, v, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Bool}
function imgui_input_int2(label, v, flags=ImGuiInputTextFlags.None) {
	return __imgui_input_int2(label, v, flags);
}

/// @func imgui_input_int3(label, v, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Bool}
function imgui_input_int3(label, v, flags=ImGuiInputTextFlags.None) {
	return __imgui_input_int3(label, v, flags);
}

/// @func imgui_input_int4(label, v, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Bool}
function imgui_input_int4(label, v, flags=ImGuiInputTextFlags.None) {
	return __imgui_input_int4(label, v, flags);
}

/// @func imgui_input_intn(label, v, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Bool}
function imgui_input_intn(label, v, flags=ImGuiInputTextFlags.None) {
	return __imgui_input_intn(label, v, flags, array_length(v));
}

/// @func imgui_input_double(label, v, step, step_fast, format, flags)
/// @argument {String} label
/// @argument {Real} v
/// @argument {Real} [step=0]
/// @argument {Real} [step_fast=0]
/// @argument {String} [format=%.6f]
/// @argument {Enum.ImGuiInputTextFlags} [flags=ImGuiInputTextFlags.None]
/// @return {Real}
function imgui_input_double(label, v, step=0, step_fast=0, format="%.6f", flags=ImGuiInputTextFlags.None) {
	return __imgui_input_double(label, v, step, step_fast, format, flags);
}

/// @func imgui_spacing()
/// @return {Undefined}
function imgui_spacing() {
	return __imgui_spacing();
}

/// @func imgui_dummy(width, height)
/// @argument {Real} width
/// @argument {Real} height
/// @return {Undefined}
function imgui_dummy(width, height) {
	return __imgui_dummy(width, height);
}

/// @func imgui_newline()
/// @return {Undefined}
function imgui_newline() {
	return __imgui_newline();
}

/// @func imgui_align_text_to_frame_padding()
/// @return {Undefined}
function imgui_align_text_to_frame_padding() {
	return __imgui_align_text_to_frame_padding();
}

/// @func imgui_separator()
/// @return {Undefined}
function imgui_separator() {
	return __imgui_separator();
}

/// @func imgui_indent(indent_w)
/// @argument {Real} [indent_w=0]
/// @return {Undefined}
function imgui_indent(indent_w=0) {
	return __imgui_indent(indent_w);
}

/// @func imgui_unindent(indent_w)
/// @argument {Real} [indent_w=0]
/// @return {Undefined}
function imgui_unindent(indent_w=0) {
	return __imgui_unindent(indent_w);
}

/// @func imgui_sameline(offset_from_start_x, spacing)
/// @argument {Real} [offset_from_start_x=0]
/// @argument {Real} [spacing=-1]
/// @return {Undefined}
function imgui_sameline(offset_from_start_x=0, spacing=-1) {
	return __imgui_sameline(offset_from_start_x, spacing);
}

/// @func imgui_begin_group()
/// @return {Undefined}
function imgui_begin_group() {
	return __imgui_begin_group();
}

/// @func imgui_end_group()
/// @return {Undefined}
function imgui_end_group() {
	return __imgui_end_group();
}

/// @func imgui_get_cursor_pos_x()
/// @return {Real}
function imgui_get_cursor_pos_x() {
	return __imgui_get_cursor_pos_x();
}

/// @func imgui_get_cursor_pos_y()
/// @return {Real}
function imgui_get_cursor_pos_y() {
	return __imgui_get_cursor_pos_y();
}

/// @func imgui_get_cursor_start_pos_x()
/// @return {Real}
function imgui_get_cursor_start_pos_x() {
	return __imgui_get_cursor_start_pos_x();
}

/// @func imgui_get_cursor_start_pos_y()
/// @return {Real}
function imgui_get_cursor_start_pos_y() {
	return __imgui_get_cursor_start_pos_y();
}

/// @func imgui_get_cursor_screen_pos_x()
/// @return {Real}
function imgui_get_cursor_screen_pos_x() {
	return __imgui_get_cursor_screen_pos_x();
}

/// @func imgui_get_cursor_screen_pos_y()
/// @return {Real}
function imgui_get_cursor_screen_pos_y() {
	return __imgui_get_cursor_screen_pos_y();
}

/// @func imgui_set_cursor_screen_pos(_x, _y)
/// @argument {Real} _x
/// @argument {Real} _y
/// @return {Undefined}
function imgui_set_cursor_screen_pos(_x, _y) {
	return __imgui_set_cursor_screen_pos(_x, _y);
}

/// @func imgui_set_cursor_pos(local_x, local_y)
/// @argument {Real} local_x
/// @argument {Real} local_y
/// @return {Undefined}
function imgui_set_cursor_pos(local_x, local_y) {
	return __imgui_set_cursor_pos(local_x, local_y);
}

/// @func imgui_set_cursor_pos_x(local_x)
/// @argument {Real} local_x
/// @return {Undefined}
function imgui_set_cursor_pos_x(local_x) {
	return __imgui_set_cursor_pos_x(local_x);
}

/// @func imgui_set_cursor_pos_y(local_y)
/// @argument {Real} local_y
/// @return {Undefined}
function imgui_set_cursor_pos_y(local_y) {
	return __imgui_set_cursor_pos_y(local_y);
}

/// @func imgui_get_text_line_height()
/// @return {Real}
function imgui_get_text_line_height() {
	return __imgui_get_text_line_height();
}

/// @func imgui_get_text_line_height_with_spacing()
/// @return {Real}
function imgui_get_text_line_height_with_spacing() {
	return __imgui_get_text_line_height_with_spacing();
}

/// @func imgui_get_frame_height()
/// @return {Real}
function imgui_get_frame_height() {
	return __imgui_get_frame_height();
}

/// @func imgui_get_frame_height_with_spacing()
/// @return {Real}
function imgui_get_frame_height_with_spacing() {
	return __imgui_get_frame_height_with_spacing();
}

/// @func imgui_get_content_region_avail_x()
/// @return {Real}
function imgui_get_content_region_avail_x() {
	return __imgui_get_content_region_avail_x();
}

/// @func imgui_get_content_region_avail_y()
/// @return {Real}
function imgui_get_content_region_avail_y() {
	return __imgui_get_content_region_avail_y();
}

/// @func imgui_get_content_region_max_x()
/// @return {Real}
function imgui_get_content_region_max_x() {
	return __imgui_get_content_region_max_x();
}

/// @func imgui_get_content_region_max_y()
/// @return {Real}
function imgui_get_content_region_max_y() {
	return __imgui_get_content_region_max_y();
}

/// @func imgui_get_window_content_region_min_x()
/// @return {Real}
function imgui_get_window_content_region_min_x() {
	return __imgui_get_window_content_region_min_x();
}

/// @func imgui_get_window_content_region_min_y()
/// @return {Real}
function imgui_get_window_content_region_min_y() {
	return __imgui_get_window_content_region_min_y();
}

/// @func imgui_get_window_content_region_max_x()
/// @return {Real}
function imgui_get_window_content_region_max_x() {
	return __imgui_get_window_content_region_max_x();
}

/// @func imgui_get_window_content_region_max_y()
/// @return {Real}
function imgui_get_window_content_region_max_y() {
	return __imgui_get_window_content_region_max_y();
}

/// @func imgui_push_item_width(item_width)
/// @argument {Real} item_width
/// @return {Undefined}
function imgui_push_item_width(item_width) {
	return __imgui_push_item_width(item_width);
}

/// @func imgui_pop_item_width()
/// @return {Undefined}
function imgui_pop_item_width() {
	return __imgui_pop_item_width();
}

/// @func imgui_set_next_item_width(item_width)
/// @argument {Real} item_width
/// @return {Undefined}
function imgui_set_next_item_width(item_width) {
	return __imgui_set_next_item_width(item_width);
}

/// @func imgui_calc_item_width()
/// @return {Real}
function imgui_calc_item_width() {
	return __imgui_calc_item_width();
}

/// @func imgui_push_text_wrap_pos(wrap_local_pos_x)
/// @argument {Real} [wrap_local_pos_x=0]
/// @return {Undefined}
function imgui_push_text_wrap_pos(wrap_local_pos_x=0) {
	return __imgui_push_text_wrap_pos(wrap_local_pos_x);
}

/// @func imgui_pop_text_wrap_pos()
/// @return {Undefined}
function imgui_pop_text_wrap_pos() {
	return __imgui_pop_text_wrap_pos();
}

/// @func imgui_push_clip_rect(clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect)
/// @argument {Real} clip_min_x
/// @argument {Real} clip_min_y
/// @argument {Real} clip_max_x
/// @argument {Real} clip_max_y
/// @argument {Bool} intersect_with_current_clip_rect
/// @return {Undefined}
function imgui_push_clip_rect(clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect) {
	return __imgui_push_clip_rect(clip_min_x, clip_min_y, clip_max_x, clip_max_y, intersect_with_current_clip_rect);
}

/// @func imgui_pop_clip_rect()
/// @return {Undefined}
function imgui_pop_clip_rect() {
	return __imgui_pop_clip_rect();
}

/// @func imgui_begin_listbox(label, width, height)
/// @argument {String} label
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @return {Bool}
function imgui_begin_listbox(label, width=0, height=0) {
	return __imgui_begin_listbox(label, width, height);
}

/// @func imgui_end_listbox()
/// @return {Undefined}
function imgui_end_listbox() {
	return __imgui_end_listbox();
}

/// @func imgui_listbox()
/// @return {Unknown<unset>}
function imgui_listbox() {
	return __imgui_listbox();
}

/// @func imgui_begin_menubar()
/// @return {Bool}
function imgui_begin_menubar() {
	return __imgui_begin_menubar();
}

/// @func imgui_end_menubar()
/// @return {Undefined}
function imgui_end_menubar() {
	return __imgui_end_menubar();
}

/// @func imgui_begin_mainmenubar()
/// @return {Bool}
function imgui_begin_mainmenubar() {
	return __imgui_begin_mainmenubar();
}

/// @func imgui_end_mainmenubar()
/// @return {Undefined}
function imgui_end_mainmenubar() {
	return __imgui_end_mainmenubar();
}

/// @func imgui_begin_menu(label, enabled)
/// @argument {String} label
/// @argument {Bool} [enabled=true]
/// @return {Bool}
function imgui_begin_menu(label, enabled=true) {
	return __imgui_begin_menu(label, enabled);
}

/// @func imgui_end_menu()
/// @return {Undefined}
function imgui_end_menu() {
	return __imgui_end_menu();
}

/// @func imgui_menu_item(label, shortcut, selected, enabled, mask)
/// @argument {String} label
/// @argument {String} [shortcut=]
/// @argument {Bool} [selected=undefined]
/// @argument {Bool} [enabled=true]
/// @argument {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
/// @return {Real}
function imgui_menu_item(label, shortcut="", selected=undefined, enabled=true, mask=ImGuiReturnMask.Return) {
	return __imgui_menu_item(label, shortcut, selected, enabled, mask);
}

/// @func imgui_begin_drag_drop_source(flags)
/// @argument {Enum.ImGuiDragDropFlags} [flags=ImGuiDragDropFlags.None]
/// @return {Bool}
function imgui_begin_drag_drop_source(flags=ImGuiDragDropFlags.None) {
	return __imgui_begin_drag_drop_source(flags);
}

/// @func imgui_end_drag_drop_source()
/// @return {Undefined}
function imgui_end_drag_drop_source() {
	return __imgui_end_drag_drop_source();
}

/// @func imgui_begin_drag_drop_target()
/// @return {Bool}
function imgui_begin_drag_drop_target() {
	return __imgui_begin_drag_drop_target();
}

/// @func imgui_end_drag_drop_target()
/// @return {Undefined}
function imgui_end_drag_drop_target() {
	return __imgui_end_drag_drop_target();
}

/// @func imgui_set_drag_drop_payload(type, data, cond)
/// @argument {String} type
/// @argument {Any} data
/// @argument {Enum.ImGuiCond} [cond=ImGuiCond.None]
/// @return {Bool}
function imgui_set_drag_drop_payload(type, data, cond=ImGuiCond.None) {
	return __imgui_set_drag_drop_payload(type, data, cond);
}

/// @func imgui_accept_drag_drop_payload(type, flags)
/// @argument {String} type
/// @argument {Enum.ImGuiDragDropFlags} [flags=ImGuiDragDropFlags.None]
/// @return {Any|Undefined}
function imgui_accept_drag_drop_payload(type, flags=ImGuiDragDropFlags.None) {
	return __imgui_accept_drag_drop_payload(type, flags);
}

/// @func imgui_get_drag_drop_payload()
/// @return {Any|Undefined}
function imgui_get_drag_drop_payload() {
	return __imgui_get_drag_drop_payload();
}

/// @func imgui_get_payload_type()
/// @return {String|Undefined}
function imgui_get_payload_type() {
	return __imgui_get_payload_type();
}

/// @func imgui_plot_lines(label, values, values_offset, overlay_text, scale_min, scale_max, graph_width, graph_height)
/// @argument {String} label
/// @argument {Array<Real>} values
/// @argument {Real} [values_offset=0]
/// @argument {String} [overlay_text=]
/// @argument {Real} [scale_min=0]
/// @argument {Real} [scale_max=0]
/// @argument {Real} [graph_width=0]
/// @argument {Real} [graph_height=0]
/// @return {Undefined}
function imgui_plot_lines(label, values, values_offset=0, overlay_text="", scale_min=0, scale_max=0, graph_width=0, graph_height=0) {
	return __imgui_plot_lines(label, values, values_offset, overlay_text, scale_min, scale_max, graph_width, graph_height, array_length(values));
}

/// @func imgui_plot_histogram(label, values, values_offset, overlay_text, scale_min, scale_max, graph_width, graph_height)
/// @argument {String} label
/// @argument {Array<Real>} values
/// @argument {Real} [values_offset=0]
/// @argument {String} [overlay_text=]
/// @argument {Real} [scale_min=0]
/// @argument {Real} [scale_max=0]
/// @argument {Real} [graph_width=0]
/// @argument {Real} [graph_height=0]
/// @return {Undefined}
function imgui_plot_histogram(label, values, values_offset=0, overlay_text="", scale_min=0, scale_max=0, graph_width=0, graph_height=0) {
	return __imgui_plot_histogram(label, values, values_offset, overlay_text, scale_min, scale_max, graph_width, graph_height, array_length(values));
}

/// @func imgui_begin_popup(str_id, flags)
/// @argument {String} str_id
/// @argument {Enum.ImGuiWindowFlags} [flags=ImGuiWindowFlags.None]
/// @return {Bool}
function imgui_begin_popup(str_id, flags=ImGuiWindowFlags.None) {
	return __imgui_begin_popup(str_id, flags);
}

/// @func imgui_begin_popup_modal(name, open, flags, mask)
/// @argument {String} name
/// @argument {Bool} [open=undefined]
/// @argument {Enum.ImGuiWindowFlags} [flags=ImGuiWindowFlags.None]
/// @argument {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
/// @return {Real}
function imgui_begin_popup_modal(name, open=undefined, flags=ImGuiWindowFlags.None, mask=ImGuiReturnMask.Return) {
	return __imgui_begin_popup_modal(name, open, flags, mask);
}

/// @func imgui_end_popup()
/// @return {Undefined}
function imgui_end_popup() {
	return __imgui_end_popup();
}

/// @func imgui_open_popup(str_id, flags)
/// @argument {String} str_id
/// @argument {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.None]
/// @return {Undefined}
function imgui_open_popup(str_id, flags=ImGuiPopupFlags.None) {
	return __imgui_open_popup(str_id, flags);
}

/// @func imgui_open_popup_on_item_click(str_id, flags)
/// @argument {String} [str_id=undefined]
/// @argument {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.MouseButtonRight]
/// @return {Undefined}
function imgui_open_popup_on_item_click(str_id="undefined", flags=ImGuiPopupFlags.MouseButtonRight) {
	return __imgui_open_popup_on_item_click(str_id, flags);
}

/// @func imgui_close_current_popup()
/// @return {Undefined}
function imgui_close_current_popup() {
	return __imgui_close_current_popup();
}

/// @func imgui_begin_popup_context_item(str_id, flags)
/// @argument {String} [str_id=undefined]
/// @argument {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.MouseButtonRight]
/// @return {Bool}
function imgui_begin_popup_context_item(str_id="undefined", flags=ImGuiPopupFlags.MouseButtonRight) {
	return __imgui_begin_popup_context_item(str_id, flags);
}

/// @func imgui_begin_popup_context_window(str_id, flags)
/// @argument {String} [str_id=undefined]
/// @argument {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.MouseButtonRight]
/// @return {Bool}
function imgui_begin_popup_context_window(str_id="undefined", flags=ImGuiPopupFlags.MouseButtonRight) {
	return __imgui_begin_popup_context_window(str_id, flags);
}

/// @func imgui_begin_popup_context_void(str_id, flags)
/// @argument {String} [str_id=undefined]
/// @argument {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.MouseButtonRight]
/// @return {Bool}
function imgui_begin_popup_context_void(str_id="undefined", flags=ImGuiPopupFlags.MouseButtonRight) {
	return __imgui_begin_popup_context_void(str_id, flags);
}

/// @func imgui_is_popup_open(str_id, flags)
/// @argument {String} str_id
/// @argument {Enum.ImGuiPopupFlags} [flags=ImGuiPopupFlags.None]
/// @return {Bool}
function imgui_is_popup_open(str_id, flags=ImGuiPopupFlags.None) {
	return __imgui_is_popup_open(str_id, flags);
}

/// @func imgui_selectable(label, selected, flags, width, height)
/// @argument {String} label
/// @argument {Bool} [selected=false]
/// @argument {Enum.ImGuiSelectableFlags} [flags=ImGuiSelectableFlags.None]
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @return {Bool}
function imgui_selectable(label, selected=false, flags=ImGuiSelectableFlags.None, width=0, height=0) {
	return __imgui_selectable(label, selected, flags, width, height);
}

/// @func imgui_slider_float(label, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Real} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Real}
function imgui_slider_float(label, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_float(label, v, v_min, v_max, format, flags);
}

/// @func imgui_slider_float2(label, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_slider_float2(label, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_float2(label, v, v_min, v_max, format, flags);
}

/// @func imgui_slider_float3(label, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_slider_float3(label, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_float3(label, v, v_min, v_max, format, flags);
}

/// @func imgui_slider_float4(label, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_slider_float4(label, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_float4(label, v, v_min, v_max, format, flags);
}

/// @func imgui_slider_floatn(label, v, v_speed, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_speed=1]
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_slider_floatn(label, v, v_speed=1, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_floatn(label, v, v_speed, v_min, v_max, format, flags, array_length(v));
}

/// @func imgui_slider_int(label, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Real} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Real}
function imgui_slider_int(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_int(label, v, v_min, v_max, format, flags);
}

/// @func imgui_slider_int2(label, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_slider_int2(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_int2(label, v, v_min, v_max, format, flags);
}

/// @func imgui_slider_int3(label, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_slider_int3(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_int3(label, v, v_min, v_max, format, flags);
}

/// @func imgui_slider_int4(label, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_slider_int4(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_int4(label, v, v_min, v_max, format, flags);
}

/// @func imgui_slider_intn(label, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Array<Real>} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Bool}
function imgui_slider_intn(label, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_intn(label, v, v_min, v_max, format, flags, array_length(v));
}

/// @func imgui_vslider_float(label, width, height, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Real} width
/// @argument {Real} height
/// @argument {Real} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%.3f]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Real}
function imgui_vslider_float(label, width, height, v, v_min=0, v_max=0, format="%.3f", flags=ImGuiSliderFlags.None) {
	return __imgui_vslider_float(label, width, height, v, v_min, v_max, format, flags);
}

/// @func imgui_vslider_int(label, width, height, v, v_min, v_max, format, flags)
/// @argument {String} label
/// @argument {Real} width
/// @argument {Real} height
/// @argument {Real} v
/// @argument {Real} [v_min=0]
/// @argument {Real} [v_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Real}
function imgui_vslider_int(label, width, height, v, v_min=0, v_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_vslider_int(label, width, height, v, v_min, v_max, format, flags);
}

/// @func imgui_slider_angle(label, v_rad, v_degrees_min, v_degrees_max, format, flags)
/// @argument {String} label
/// @argument {Real} v_rad
/// @argument {Real} [v_degrees_min=0]
/// @argument {Real} [v_degrees_max=0]
/// @argument {String} [format=%d]
/// @argument {Enum.ImGuiSliderFlags} [flags=ImGuiSliderFlags.None]
/// @return {Real}
function imgui_slider_angle(label, v_rad, v_degrees_min=0, v_degrees_max=0, format="%d", flags=ImGuiSliderFlags.None) {
	return __imgui_slider_angle(label, v_rad, v_degrees_min, v_degrees_max, format, flags);
}

/// @func imgui_style_colors_dark()
/// @return {Undefined}
function imgui_style_colors_dark() {
	return __imgui_style_colors_dark();
}

/// @func imgui_style_colors_light()
/// @return {Undefined}
function imgui_style_colors_light() {
	return __imgui_style_colors_light();
}

/// @func imgui_style_colors_classic()
/// @return {Undefined}
function imgui_style_colors_classic() {
	return __imgui_style_colors_classic();
}

/// @func imgui_push_style_color(idx, col, alpha)
/// @argument {Real} idx
/// @argument {Real} col
/// @argument {Real} alpha
/// @return {Undefined}
function imgui_push_style_color(idx, col, alpha) {
	return __imgui_push_style_color(idx, col, alpha);
}

/// @func imgui_pop_style_color(count)
/// @argument {Real} [count=1]
/// @return {Undefined}
function imgui_pop_style_color(count=1) {
	return __imgui_pop_style_color(count);
}

/// @func imgui_push_style_var(idx, val, val2)
/// @argument {Real} idx
/// @argument {Real} val
/// @argument {Any} [val2=undefined]
/// @return {Undefined}
function imgui_push_style_var(idx, val, val2=undefined) {
	return __imgui_push_style_var(idx, val, val2);
}

/// @func imgui_pop_style_var(count)
/// @argument {Real} [count=1]
/// @return {Undefined}
function imgui_pop_style_var(count=1) {
	return __imgui_pop_style_var(count);
}

/// @func imgui_get_style_color(idx)
/// @argument {Real} idx
/// @return {Real}
function imgui_get_style_color(idx) {
	return __imgui_get_style_color(idx);
}

/// @func imgui_get_style_color_name(idx)
/// @argument {Real} idx
/// @return {String}
function imgui_get_style_color_name(idx) {
	return __imgui_get_style_color_name(idx);
}

/// @func imgui_begin_table(str_id, column, flags, outer_width, outer_height, inner_width)
/// @argument {String} str_id
/// @argument {Real} column
/// @argument {Enum.ImGuiTableFlags} [flags=ImGuiTableFlags.None]
/// @argument {Real} [outer_width=0]
/// @argument {Real} [outer_height=0]
/// @argument {Real} [inner_width=0]
/// @return {Bool}
function imgui_begin_table(str_id, column, flags=ImGuiTableFlags.None, outer_width=0, outer_height=0, inner_width=0) {
	return __imgui_begin_table(str_id, column, flags, outer_width, outer_height, inner_width);
}

/// @func imgui_end_table()
/// @return {Undefined}
function imgui_end_table() {
	return __imgui_end_table();
}

/// @func imgui_table_next_row(row_flags, min_row_height)
/// @argument {Enum.ImGuiTableRowFlags} [row_flags=ImGuiTableRowFlags.None]
/// @argument {Real} [min_row_height=0]
/// @return {Undefined}
function imgui_table_next_row(row_flags=ImGuiTableRowFlags.None, min_row_height=0) {
	return __imgui_table_next_row(row_flags, min_row_height);
}

/// @func imgui_table_next_column()
/// @return {Bool}
function imgui_table_next_column() {
	return __imgui_table_next_column();
}

/// @func imgui_table_set_column_index(column_n)
/// @argument {Real} column_n
/// @return {Bool}
function imgui_table_set_column_index(column_n) {
	return __imgui_table_set_column_index(column_n);
}

/// @func imgui_table_setup_column(label, flags, user_id)
/// @argument {String} label
/// @argument {Enum.ImGuiTableColumnFlags} [flags=ImGuiTableColumnFlags.None]
/// @argument {Real} [user_id=0]
/// @return {Undefined}
function imgui_table_setup_column(label, flags=ImGuiTableColumnFlags.None, user_id=0) {
	return __imgui_table_setup_column(label, flags, user_id);
}

/// @func imgui_table_setup_scroll_freeze(cols, rows)
/// @argument {Real} cols
/// @argument {Real} rows
/// @return {Undefined}
function imgui_table_setup_scroll_freeze(cols, rows) {
	return __imgui_table_setup_scroll_freeze(cols, rows);
}

/// @func imgui_table_headers_row()
/// @return {Undefined}
function imgui_table_headers_row() {
	return __imgui_table_headers_row();
}

/// @func imgui_table_header(label)
/// @argument {String} label
/// @return {Undefined}
function imgui_table_header(label) {
	return __imgui_table_header(label);
}

/// @func imgui_table_get_column_count()
/// @return {Real}
function imgui_table_get_column_count() {
	return __imgui_table_get_column_count();
}

/// @func imgui_table_get_column_index()
/// @return {Real}
function imgui_table_get_column_index() {
	return __imgui_table_get_column_index();
}

/// @func imgui_table_get_column_name(column_n)
/// @argument {Real} [column_n=-1]
/// @return {String}
function imgui_table_get_column_name(column_n=-1) {
	return __imgui_table_get_column_name(column_n);
}

/// @func imgui_table_get_column_flags(column_n)
/// @argument {Real} [column_n=-1]
/// @return {Real}
function imgui_table_get_column_flags(column_n=-1) {
	return __imgui_table_get_column_flags(column_n);
}

/// @func imgui_table_get_row_index()
/// @return {Real}
function imgui_table_get_row_index() {
	return __imgui_table_get_row_index();
}

/// @func imgui_table_set_column_enabled(column_n, v)
/// @argument {Real} column_n
/// @argument {Bool} v
/// @return {Undefined}
function imgui_table_set_column_enabled(column_n, v) {
	return __imgui_table_set_column_enabled(column_n, v);
}

/// @func imgui_table_set_bg_color(target, col, column_n)
/// @argument {Real} target
/// @argument {Real} col
/// @argument {Real} [column_n=-1]
/// @return {Undefined}
function imgui_table_set_bg_color(target, col, column_n=-1) {
	return __imgui_table_set_bg_color(target, col, column_n);
}

/// @func imgui_columns(count, _id, border)
/// @argument {Real} [count=1]
/// @argument {String} [_id=]
/// @argument {Bool} [border=true]
/// @return {Undefined}
function imgui_columns(count=1, _id="", border=true) {
	return __imgui_columns(count, _id, border);
}

/// @func imgui_next_column()
/// @return {Undefined}
function imgui_next_column() {
	return __imgui_next_column();
}

/// @func imgui_get_column_index()
/// @return {Real}
function imgui_get_column_index() {
	return __imgui_get_column_index();
}

/// @func imgui_get_column_width(column_index)
/// @argument {Real} [column_index=-1]
/// @return {Real}
function imgui_get_column_width(column_index=-1) {
	return __imgui_get_column_width(column_index);
}

/// @func imgui_set_column_width(column_index, width)
/// @argument {Real} column_index
/// @argument {Real} width
/// @return {Undefined}
function imgui_set_column_width(column_index, width) {
	return __imgui_set_column_width(column_index, width);
}

/// @func imgui_get_column_offset(column_index)
/// @argument {Real} [column_index=-1]
/// @return {Real}
function imgui_get_column_offset(column_index=-1) {
	return __imgui_get_column_offset(column_index);
}

/// @func imgui_set_column_offset(column_index, offset_x)
/// @argument {Real} column_index
/// @argument {Real} offset_x
/// @return {Undefined}
function imgui_set_column_offset(column_index, offset_x) {
	return __imgui_set_column_offset(column_index, offset_x);
}

/// @func imgui_get_columns_count()
/// @return {Real}
function imgui_get_columns_count() {
	return __imgui_get_columns_count();
}

/// @func imgui_begin_tab_bar(str_id, flags)
/// @argument {String} str_id
/// @argument {Enum.ImGuiTabBarFlags} [flags=ImGuiTabBarFlags.None]
/// @return {Bool}
function imgui_begin_tab_bar(str_id, flags=ImGuiTabBarFlags.None) {
	return __imgui_begin_tab_bar(str_id, flags);
}

/// @func imgui_end_tab_bar()
/// @return {Undefined}
function imgui_end_tab_bar() {
	return __imgui_end_tab_bar();
}

/// @func imgui_begin_tab_item(label, open, flags, mask)
/// @argument {String} label
/// @argument {Bool} [open=undefined]
/// @argument {Enum.ImGuiTabItemFlags} [flags=ImGuiTabItemFlags.None]
/// @argument {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
/// @return {Real}
function imgui_begin_tab_item(label, open=undefined, flags=ImGuiTabItemFlags.None, mask=ImGuiReturnMask.Return) {
	return __imgui_begin_tab_item(label, open, flags, mask);
}

/// @func imgui_end_tab_item()
/// @return {Undefined}
function imgui_end_tab_item() {
	return __imgui_end_tab_item();
}

/// @func imgui_tab_item_button(label, flags)
/// @argument {String} label
/// @argument {Enum.ImGuiTabItemFlags} [flags=ImGuiTabItemFlags.None]
/// @return {Bool}
function imgui_tab_item_button(label, flags=ImGuiTabItemFlags.None) {
	return __imgui_tab_item_button(label, flags);
}

/// @func imgui_set_tab_item_closed(tab_or_docked_window_label)
/// @argument {String} tab_or_docked_window_label
/// @return {Undefined}
function imgui_set_tab_item_closed(tab_or_docked_window_label) {
	return __imgui_set_tab_item_closed(tab_or_docked_window_label);
}

/// @func imgui_text_unformatted(text)
/// @argument {String} text
/// @return {Undefined}
function imgui_text_unformatted(text) {
	return __imgui_text_unformatted(text);
}

/// @func imgui_text(val)
/// @argument {String} val
/// @return {Undefined}
function imgui_text(val) {
	return __imgui_text(val);
}

/// @func imgui_text_colored(val, color, alpha)
/// @argument {String} val
/// @argument {Real} color
/// @argument {Real} [alpha=1]
/// @return {Undefined}
function imgui_text_colored(val, color, alpha=1) {
	return __imgui_text_colored(val, color, alpha);
}

/// @func imgui_text_disabled(val)
/// @argument {String} val
/// @return {Undefined}
function imgui_text_disabled(val) {
	return __imgui_text_disabled(val);
}

/// @func imgui_text_wrapped(val)
/// @argument {String} val
/// @return {Undefined}
function imgui_text_wrapped(val) {
	return __imgui_text_wrapped(val);
}

/// @func imgui_label_text(label, val)
/// @argument {String} label
/// @argument {String} val
/// @return {Undefined}
function imgui_label_text(label, val) {
	return __imgui_label_text(label, val);
}

/// @func imgui_bullet_text(val)
/// @argument {String} val
/// @return {Undefined}
function imgui_bullet_text(val) {
	return __imgui_bullet_text(val);
}

/// @func imgui_value()
/// @return {Unknown<unset>}
function imgui_value() {
	return __imgui_value();
}

/// @func imgui_begin_tooltip()
/// @return {Undefined}
function imgui_begin_tooltip() {
	return __imgui_begin_tooltip();
}

/// @func imgui_end_tooltip()
/// @return {Undefined}
function imgui_end_tooltip() {
	return __imgui_end_tooltip();
}

/// @func imgui_set_tooltip(val)
/// @argument {String} val
/// @return {Undefined}
function imgui_set_tooltip(val) {
	return __imgui_set_tooltip(val);
}

/// @func imgui_tree_node(label)
/// @argument {String} label
/// @return {Bool}
function imgui_tree_node(label) {
	return __imgui_tree_node(label);
}

/// @func imgui_tree_node_ex(label, flags)
/// @argument {String} label
/// @argument {Enum.ImGuiTreeNodeFlags} [flags=ImGuiTreeNodeFlags.None]
/// @return {Bool}
function imgui_tree_node_ex(label, flags=ImGuiTreeNodeFlags.None) {
	return __imgui_tree_node_ex(label, flags);
}

/// @func imgui_tree_push(str_id)
/// @argument {String} str_id
/// @return {Undefined}
function imgui_tree_push(str_id) {
	return __imgui_tree_push(str_id);
}

/// @func imgui_tree_pop()
/// @return {Undefined}
function imgui_tree_pop() {
	return __imgui_tree_pop();
}

/// @func imgui_get_tree_node_to_label_spacing()
/// @return {Real}
function imgui_get_tree_node_to_label_spacing() {
	return __imgui_get_tree_node_to_label_spacing();
}

/// @func imgui_set_next_item_open(is_open, cond)
/// @argument {Bool} is_open
/// @argument {Enum.ImGuiCond} [cond=ImGuiCond.None]
/// @return {Undefined}
function imgui_set_next_item_open(is_open, cond=ImGuiCond.None) {
	return __imgui_set_next_item_open(is_open, cond);
}

/// @func imgui_collapsing_header(label, _visible, flags, mask)
/// @argument {String} label
/// @argument {Bool} [_visible=undefined]
/// @argument {Enum.ImGuiTreeNodeFlags} [flags=ImGuiTreeNodeFlags.None]
/// @argument {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
/// @return {Real}
function imgui_collapsing_header(label, _visible=undefined, flags=ImGuiTreeNodeFlags.None, mask=ImGuiReturnMask.Return) {
	return __imgui_collapsing_header(label, _visible, flags, mask);
}

/// @func imgui_button(label, width, height)
/// @argument {String} label
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @return {Bool}
function imgui_button(label, width=0, height=0) {
	return __imgui_button(label, width, height);
}

/// @func imgui_small_button(label)
/// @argument {String} label
/// @return {Bool}
function imgui_small_button(label) {
	return __imgui_small_button(label);
}

/// @func imgui_invisible_button(_id, width, height, flags)
/// @argument {String} _id
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @argument {Enum.ImGuiButtonFlags} [flags=ImGuiButtonFlags.None]
/// @return {Bool}
function imgui_invisible_button(_id, width=0, height=0, flags=ImGuiButtonFlags.None) {
	return __imgui_invisible_button(_id, width, height, flags);
}

/// @func imgui_arrow_button(str_id, dir)
/// @argument {String} str_id
/// @argument {Real} dir
/// @return {Bool}
function imgui_arrow_button(str_id, dir) {
	return __imgui_arrow_button(str_id, dir);
}

/// @func imgui_image(sprite, subimg, color, alpha, width, height)
/// @argument {Real} sprite
/// @argument {Real} subimg
/// @argument {Real} [color=c_white]
/// @argument {Real} [alpha=1]
/// @argument {Real} [width=sprite_get_width⌊sprite⌉]
/// @argument {Real} [height=sprite_get_height⌊sprite⌉]
/// @return {Undefined}
function imgui_image(sprite, subimg, color=c_white, alpha=1, width=sprite_get_width(sprite), height=sprite_get_height(sprite)) {
	return __imgui_image(sprite, subimg, color, alpha, width, height, sprite_get_uvs(sprite, subimg));
}

/// @func imgui_image_button(str_id, sprite, subimg, color, alpha, bg_color, bg_alpha, width, height)
/// @argument {String} str_id
/// @argument {Real} sprite
/// @argument {Real} subimg
/// @argument {Real} color
/// @argument {Real} alpha
/// @argument {Real} bg_color
/// @argument {Real} bg_alpha
/// @argument {Real} [width=sprite_get_width⌊sprite⌉]
/// @argument {Real} [height=sprite_get_height⌊sprite⌉]
/// @return {Bool}
function imgui_image_button(str_id, sprite, subimg, color, alpha, bg_color, bg_alpha, width=sprite_get_width(sprite), height=sprite_get_height(sprite)) {
	return __imgui_image_button(str_id, sprite, subimg, color, alpha, bg_color, bg_alpha, width, height, sprite_get_uvs(sprite, subimg));
}

/// @func imgui_surface(surface, color, alpha, width, height)
/// @argument {Real} surface
/// @argument {Real} [color=c_white]
/// @argument {Real} [alpha=1]
/// @argument {Real} [width=surface_get_width⌊surface⌉]
/// @argument {Real} [height=surface_get_height⌊surface⌉]
/// @return {Undefined}
function imgui_surface(surface, color=c_white, alpha=1, width=surface_get_width(surface), height=surface_get_height(surface)) {
	var _tex = surface_get_texture(surface); 
	return __imgui_surface(surface, color, alpha, width, height, texture_get_uvs(_tex));
}

/// @func imgui_checkbox(label, checked)
/// @argument {String} label
/// @argument {Bool} checked
/// @return {Bool}
function imgui_checkbox(label, checked) {
	return __imgui_checkbox(label, checked);
}

/// @func imgui_checkbox_flags(label, flags, flags_value)
/// @argument {String} label
/// @argument {Real} flags
/// @argument {Real} flags_value
/// @return {Real}
function imgui_checkbox_flags(label, flags, flags_value) {
	return __imgui_checkbox_flags(label, flags, flags_value);
}

/// @func imgui_radio_button(label, active)
/// @argument {String} label
/// @argument {Bool} active
/// @return {Bool}
function imgui_radio_button(label, active) {
	return __imgui_radio_button(label, active);
}

/// @func imgui_progressbar(_frac, width, height, overlay)
/// @argument {Real} _frac
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @argument {String} [overlay=]
/// @return {Undefined}
function imgui_progressbar(_frac, width=0, height=0, overlay="") {
	return __imgui_progressbar(_frac, width, height, overlay);
}

/// @func imgui_bullet()
/// @return {Undefined}
function imgui_bullet() {
	return __imgui_bullet();
}

/// @func imgui_begin(name, open, flags, mask)
/// @argument {String} name
/// @argument {Bool} [open=undefined]
/// @argument {Enum.ImGuiWindowFlags} [flags=ImGuiWindowFlags.None]
/// @argument {Enum.ImGuiReturnMask} [mask=ImGuiReturnMask.Return]
/// @return {Real}
function imgui_begin(name, open=undefined, flags=ImGuiWindowFlags.None, mask=ImGuiReturnMask.Return) {
	return __imgui_begin(name, open, flags, mask);
}

/// @func imgui_end()
/// @return {Undefined}
function imgui_end() {
	return __imgui_end();
}

/// @func imgui_begin_child(str_id, width, height, border, flags)
/// @argument {String} str_id
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @argument {Bool} [border=false]
/// @argument {Enum.ImGuiWindowFlags} [flags=ImGuiWindowFlags.None]
/// @return {Bool}
function imgui_begin_child(str_id, width=0, height=0, border=false, flags=ImGuiWindowFlags.None) {
	return __imgui_begin_child(str_id, width, height, border, flags);
}

/// @func imgui_end_child()
/// @return {Undefined}
function imgui_end_child() {
	return __imgui_end_child();
}

/// @func imgui_begin_child_frame(_id, width, height, flags)
/// @argument {Real} _id
/// @argument {Real} [width=0]
/// @argument {Real} [height=0]
/// @argument {Enum.ImGuiWindowFlags} [flags=ImGuiWindowFlags.None]
/// @return {Bool}
function imgui_begin_child_frame(_id, width=0, height=0, flags=ImGuiWindowFlags.None) {
	return __imgui_begin_child_frame(_id, width, height, flags);
}

/// @func imgui_end_child_frame()
/// @return {Undefined}
function imgui_end_child_frame() {
	return __imgui_end_child_frame();
}

/// @func imgui_is_window_appearing()
/// @return {Bool}
function imgui_is_window_appearing() {
	return __imgui_is_window_appearing();
}

/// @func imgui_is_window_collapsed()
/// @return {Bool}
function imgui_is_window_collapsed() {
	return __imgui_is_window_collapsed();
}

/// @func imgui_is_window_focused(flags)
/// @argument {Enum.ImGuiFocusedFlags} [flags=ImGuiFocusedFlags.None]
/// @return {Bool}
function imgui_is_window_focused(flags=ImGuiFocusedFlags.None) {
	return __imgui_is_window_focused(flags);
}

/// @func imgui_is_window_hovered(flags)
/// @argument {Enum.ImGuiHoveredFlags} [flags=ImGuiHoveredFlags.None]
/// @return {Bool}
function imgui_is_window_hovered(flags=ImGuiHoveredFlags.None) {
	return __imgui_is_window_hovered(flags);
}

/// @func imgui_get_window_dpi_scale()
/// @return {Real}
function imgui_get_window_dpi_scale() {
	return __imgui_get_window_dpi_scale();
}

/// @func imgui_get_window_x()
/// @return {Real}
function imgui_get_window_x() {
	return __imgui_get_window_x();
}

/// @func imgui_get_window_y()
/// @return {Real}
function imgui_get_window_y() {
	return __imgui_get_window_y();
}

/// @func imgui_get_window_width()
/// @return {Real}
function imgui_get_window_width() {
	return __imgui_get_window_width();
}

/// @func imgui_get_window_height()
/// @return {Real}
function imgui_get_window_height() {
	return __imgui_get_window_height();
}

/// @func imgui_set_next_window_pos(_x, _y, cond, pivot_x, pivot_y)
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {Enum.ImGuiCond} [cond=ImGuiCond.None]
/// @argument {Real} [pivot_x=0]
/// @argument {Real} [pivot_y=0]
/// @return {Undefined}
function imgui_set_next_window_pos(_x, _y, cond=ImGuiCond.None, pivot_x=0, pivot_y=0) {
	return __imgui_set_next_window_pos(_x, _y, cond, pivot_x, pivot_y);
}

/// @func imgui_set_next_window_size(width, height, cond)
/// @argument {Real} width
/// @argument {Real} height
/// @argument {Enum.ImGuiCond} [cond=ImGuiCond.None]
/// @return {Undefined}
function imgui_set_next_window_size(width, height, cond=ImGuiCond.None) {
	return __imgui_set_next_window_size(width, height, cond);
}

/// @func imgui_set_next_window_size_constraints(min_width, min_height, max_width, max_height)
/// @argument {Real} min_width
/// @argument {Real} min_height
/// @argument {Real} max_width
/// @argument {Real} max_height
/// @return {Undefined}
function imgui_set_next_window_size_constraints(min_width, min_height, max_width, max_height) {
	return __imgui_set_next_window_size_constraints(min_width, min_height, max_width, max_height);
}

/// @func imgui_set_next_window_content_size(width, height)
/// @argument {Real} width
/// @argument {Real} height
/// @return {Undefined}
function imgui_set_next_window_content_size(width, height) {
	return __imgui_set_next_window_content_size(width, height);
}

/// @func imgui_set_next_window_collapsed(collapsed, cond)
/// @argument {Bool} collapsed
/// @argument {Enum.ImGuiCond} [cond=ImGuiCond.None]
/// @return {Undefined}
function imgui_set_next_window_collapsed(collapsed, cond=ImGuiCond.None) {
	return __imgui_set_next_window_collapsed(collapsed, cond);
}

/// @func imgui_set_next_window_focus()
/// @return {Undefined}
function imgui_set_next_window_focus() {
	return __imgui_set_next_window_focus();
}

/// @func imgui_set_next_window_scroll(scroll_x, scroll_y)
/// @argument {Real} scroll_x
/// @argument {Real} scroll_y
/// @return {Undefined}
function imgui_set_next_window_scroll(scroll_x, scroll_y) {
	return __imgui_set_next_window_scroll(scroll_x, scroll_y);
}

/// @func imgui_set_next_window_bgalpha(alpha)
/// @argument {Real} alpha
/// @return {Undefined}
function imgui_set_next_window_bgalpha(alpha) {
	return __imgui_set_next_window_bgalpha(alpha);
}

/// @func imgui_get_scroll_x()
/// @return {Real}
function imgui_get_scroll_x() {
	return __imgui_get_scroll_x();
}

/// @func imgui_get_scroll_y()
/// @return {Real}
function imgui_get_scroll_y() {
	return __imgui_get_scroll_y();
}

/// @func imgui_set_scroll_x(scroll_x)
/// @argument {Real} scroll_x
/// @return {Undefined}
function imgui_set_scroll_x(scroll_x) {
	return __imgui_set_scroll_x(scroll_x);
}

/// @func imgui_set_scroll_y(scroll_y)
/// @argument {Real} scroll_y
/// @return {Undefined}
function imgui_set_scroll_y(scroll_y) {
	return __imgui_set_scroll_y(scroll_y);
}

/// @func imgui_get_scroll_max_x()
/// @return {Real}
function imgui_get_scroll_max_x() {
	return __imgui_get_scroll_max_x();
}

/// @func imgui_get_scroll_max_y()
/// @return {Real}
function imgui_get_scroll_max_y() {
	return __imgui_get_scroll_max_y();
}

/// @func imgui_set_scroll_here_x(center_x_ratio)
/// @argument {Real} [center_x_ratio=0.5]
/// @return {Undefined}
function imgui_set_scroll_here_x(center_x_ratio=0.5) {
	return __imgui_set_scroll_here_x(center_x_ratio);
}

/// @func imgui_set_scroll_here_y(center_y_ratio)
/// @argument {Real} [center_y_ratio=0.5]
/// @return {Undefined}
function imgui_set_scroll_here_y(center_y_ratio=0.5) {
	return __imgui_set_scroll_here_y(center_y_ratio);
}

/// @func imgui_set_scroll_from_pos_x(local_x, center_x_ratio)
/// @argument {Real} local_x
/// @argument {Real} [center_x_ratio=0.5]
/// @return {Undefined}
function imgui_set_scroll_from_pos_x(local_x, center_x_ratio=0.5) {
	return __imgui_set_scroll_from_pos_x(local_x, center_x_ratio);
}

/// @func imgui_set_scroll_from_pos_y(local_y, center_y_ratio)
/// @argument {Real} local_y
/// @argument {Real} [center_y_ratio=0.5]
/// @return {Undefined}
function imgui_set_scroll_from_pos_y(local_y, center_y_ratio=0.5) {
	return __imgui_set_scroll_from_pos_y(local_y, center_y_ratio);
}

/// @func imgui_set_window_pos(_x, _y, cond)
/// @argument {Real} _x
/// @argument {Real} _y
/// @argument {Enum.ImGuiCond} [cond=ImGuiCond.None]
/// @return {Undefined}
function imgui_set_window_pos(_x, _y, cond=ImGuiCond.None) {
	return __imgui_set_window_pos(_x, _y, cond);
}

/// @func imgui_set_window_size(name, width, height, cond)
/// @argument {String} [name=]
/// @argument {Real} width
/// @argument {Real} height
/// @argument {Enum.ImGuiCond} [cond=ImGuiCond.None]
/// @return {Undefined}
function imgui_set_window_size(name="", width, height, cond=ImGuiCond.None) {
	return __imgui_set_window_size(name, width, height, cond);
}

/// @func imgui_set_window_collapsed(name, collapsed, cond)
/// @argument {String} [name=]
/// @argument {Bool} collapsed
/// @argument {Enum.ImGuiCond} [cond=ImGuiCond.None]
/// @return {Undefined}
function imgui_set_window_collapsed(name="", collapsed, cond=ImGuiCond.None) {
	return __imgui_set_window_collapsed(name, collapsed, cond);
}

/// @func imgui_set_window_focus(name)
/// @argument {String} [name=]
/// @return {Undefined}
function imgui_set_window_focus(name="") {
	return __imgui_set_window_focus(name);
}
