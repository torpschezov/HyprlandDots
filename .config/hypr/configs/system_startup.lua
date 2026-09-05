-- ==================================================
--  KoolDots (2026)
--  Project URL: https://github.com/LinuxBeginnings
--  License: GNU GPLv3
--  SPDX-License-Identifier: GPL-3.0-or-later
-- ==================================================

-- System defaults migrated from configs/Startup_Apps.conf (auto-generated).
-- Add commands with exec_once("your command")
-- Example:
-- exec_once("swaync")

local session = os.getenv("HYPRLAND_INSTANCE_SIGNATURE") or "default"

local function shell_quote(value)
  return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

local function exec_once(cmd)
  local key = cmd:gsub("[^%w_.-]", "_"):sub(1, 80)
  local marker = "/tmp/hypr-lua-system-exec-once-" .. session .. "-" .. key
  local log = "/tmp/hypr-lua-system-startup-" .. key .. ".log"
  local readiness = "runtime=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}; export XDG_RUNTIME_DIR=\"$runtime\"; for _ in $(seq 1 60); do if [ -n \"$WAYLAND_DISPLAY\" ] && [ -S \"$runtime/$WAYLAND_DISPLAY\" ]; then break; fi; for sock in \"$runtime\"/wayland-[0-9]*; do [ -S \"$sock\" ] || continue; case \"$(basename \"$sock\")\" in *awww*) continue ;; esac; export WAYLAND_DISPLAY=\"$(basename \"$sock\")\"; break; done; sleep 0.1; done; if [ -n \"$HYPRLAND_INSTANCE_SIGNATURE\" ]; then for hypr_sock in \"$runtime/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket.sock\" \"$runtime/hypr/.socket.sock\"; do [ -S \"$hypr_sock\" ] && break; done; sleep 0.1; fi"
  local inner = readiness .. "; " .. cmd
  local script = "[ -e " .. shell_quote(marker) .. " ] || { touch " .. shell_quote(marker) .. " && sh -lc " .. shell_quote(inner) .. " >>" .. shell_quote(log) .. " 2>&1 & }"
  os.execute("sh -lc " .. shell_quote(script))
end

-- Converted from configs/Startup_Apps.conf
local startup_commands = {
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
  "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
  "/home/torpschez/.config/hypr/scripts/WaybarStartup.sh",
  "sh -c 'sleep 1; /home/torpschez/.config/hypr/scripts/WallpaperDaemon.sh & /home/torpschez/.config/hypr/scripts/ApplyThemeMode.sh'",
  "/home/torpschez/.config/hypr/scripts/Polkit.sh",
  "nm-applet",
  "swaync",
  "/home/torpschez/.config/hypr/scripts/PortalHyprland.sh",
  "sh -c 'sleep 0.3; hyprctl setcursor \"${HYPRCURSOR_THEME:-Bibata-Modern-Ice}\" \"${HYPRCURSOR_SIZE:-24}\"'",
  "qs --log-rules \"qt.qpa.wayland.textinput.warning=false\" -c overview",
  "qs --log-rules \"qt.qpa.wayland.textinput.warning=false\" -p ~/.config/quickshell/qs-hyprview &",
  "hypridle",
  "/home/torpschez/.config/hypr/scripts/LuaAutoReload.sh",
  "/home/torpschez/.config/hypr/scripts/Hyprsunset.sh init",
  "/home/torpschez/.config/hypr/scripts/Dropterminal.sh --startup kitty",
  "wl-paste --type text --watch cliphist store",
  "wl-paste --type image --watch cliphist store",
  "blueman-applet",
  "/home/torpschez/.config/hypr/scripts/KeybindsLayoutInit.sh",
  "ags",
  "qs --log-rules \"qt.qpa.wayland.textinput.warning=false\"",
  "qs -c overview",
  "/home/torpschez/.config/hypr/scripts/Polkit-NixOS.sh",
}

local function run_startup_commands()
  for _, cmd in ipairs(startup_commands) do
    exec_once(cmd)
  end
end

if hl and hl.on then
  hl.on("hyprland.start", run_startup_commands)
else
  run_startup_commands()
end
