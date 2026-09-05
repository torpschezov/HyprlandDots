-- ==================================================
--  KoolDots (2026)
--  Project URL: https://github.com/LinuxBeginnings
--  License: GNU GPLv3
--  SPDX-License-Identifier: GPL-3.0-or-later
-- ==================================================

-- User settings overrides (auto-generated).
-- This file is intentionally split from other user overrides.
-- Add only user-specific Lua overrides here.
-- Example:
-- hl.config({ general = { gaps_in = 4, gaps_out = 8 } })

-- Source reference from UserSettings.conf (hyprlang):
-- input {
-- kb_layout = us
-- kb_variant =
-- kb_model = pc105+inet
-- }

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "pc105+inet",
		kb_options = "",
		kb_rules = "",
		repeat_rate = 50,
		repeat_delay = 300,
		sensitivity = 0.1,
		numlock_by_default = true,
		left_handed = false,
		follow_mouse = 1,
		float_switch_override_focus = false,
		touchpad = {
			disable_while_typing = false,
			natural_scroll = true,
			clickfinger_behavior = false,
			middle_button_emulation = false,
			tap_to_click = true,
			drag_lock = false,
		},
		touchdevice = {
			enabled = true,
		},
		tablet = {
			transform = 0,
			left_handed = 0,
		},
	},
})
