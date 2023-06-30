from libqtile.config import Key
from libqtile.lazy import lazy
import os

mod = "mod4"
control = "control"
shift = "shift"
alt = "mod1"
terminal = "alacritty"
home = os.path.expanduser('~')

# resize functions
def resize(qtile, direction):
    layout = qtile.current_layout
    child = layout.current
    parent = child.parent

    while parent:
        if child in parent.children:
            layout_all = False
            if (direction == "left" and parent.split_horizontal) or (
                direction == "up" and not parent.split_horizontal
            ):
                parent.split_ratio = max(5, parent.split_ratio - layout.grow_amount)
                layout_all = True
            elif (direction == "right" and parent.split_horizontal) or (
                direction == "down" and not parent.split_horizontal
            ):
                parent.split_ratio = min(95, parent.split_ratio + layout.grow_amount)
                layout_all = True
            if layout_all:
                layout.group.layout_all()
                break

        child = parent
        parent = child.parent

@lazy.function
def resize_left(qtile):
    current = qtile.current_layout.name
    layout = qtile.current_layout
    if current == "bsp":
        resize(qtile, "left")
    elif current == "columns":
        layout.cmd_grow_left()

@lazy.function
def resize_right(qtile):
    current = qtile.current_layout.name
    layout = qtile.current_layout
    if current == "bsp":
        resize(qtile, "right")
    elif current == "columns":
        layout.cmd_grow_right()


@lazy.function
def resize_up(qtile):
    current = qtile.current_layout.name
    layout = qtile.current_layout
    if current == "bsp":
        resize(qtile, "up")
    elif current == "columns":
        layout.cmd_grow_up()

@lazy.function
def resize_down(qtile):
    current = qtile.current_layout.name
    layout = qtile.current_layout
    if current == "bsp":
        resize(qtile, "down")
    elif current == "columns":
        layout.cmd_grow_down()

keys = [
    # main
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "q", lazy.window.kill(), desc="Kill active window"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle forward layout"),
    Key([mod, shift], "Tab", lazy.prev_layout(), desc="Toggle last layout"),
    Key([mod, shift], "b", lazy.hide_show_bar("top"), desc="Hide qtile bar"),
    Key([mod], "space", lazy.spawn(f"./.config/qtile/scripts/kb-switcher.sh"), desc="Keyboard layout switcher"),

    # qtile
    Key([mod, shift], "r", lazy.reload_config(), desc="Reload Qtile config"),
    Key([mod, shift], "y", lazy.restart(), desc="Restart Qtile"),
    Key([mod, shift], "q", lazy.shutdown(), desc="Quit Qtile"),
    
    # rofi
    Key([mod], "e", lazy.spawn("rofi -show drun -theme ~/.config/rofi/launchers/type-2/config.rasi"), desc="Launch Rofi"),
    Key([mod, shift], "e", lazy.spawn(f"{home}/.config/rofi/powermenu/type-2/powermenu.sh"), desc="Power Menu"),
    Key([mod, shift], "s", lazy.spawn(f"{home}/.config/rofi/music/music"), desc="Music Player Menu"),
    
    # focus, move windows and screens
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down in current stack pane"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up in current stack pane"),
    Key([mod], "Left", lazy.layout.left(), desc="Move focus left in current stack pane"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus right in current stack pane",),
    Key([mod, shift], "Down", lazy.layout.shuffle_down(), lazy.layout.move_down(), desc="Move windows down in current stack",),
    Key([mod, shift], "Up", lazy.layout.shuffle_up(), lazy.layout.move_up(), desc="Move windows up in current stack",),
    Key([mod, shift], "Left", lazy.layout.shuffle_left(), lazy.layout.move_left(), desc="Move windows left in current stack",),
    Key([mod, shift], "Right", lazy.layout.shuffle_right(), lazy.layout.move_right(), desc="Move windows right in the current stack",),
    Key([mod], "x", lazy.next_screen(), desc="Move focus to next monitor",),    # TODO find a better hotkey
    Key([mod, control], "Left", lazy.screen.prev_group(), desc="Move to previous group"),
    Key([mod, control], "Right", lazy.screen.next_group(), desc="Move to next group"),
    Key([alt], "Tab", lazy.screen.toggle_group()),
    
    # window resizing
    Key([mod, alt], "Left", resize_left, desc="Resize window left"),
    Key([mod, alt], "Right", resize_right, desc="Resize window Right"),
    Key([mod, alt], "Up", resize_up, desc="Resize windows upward"),
    Key([mod, alt], "Down", resize_down, desc="Resize windows downward"),
    Key([mod, alt], "n", lazy.layout.normalize(), desc="Normalize window size ratios"),
    
    # window states
    Key([mod], "m", lazy.window.toggle_maximize(), desc="Toggle window between minimum and maximum sizes",),
    Key([mod, shift], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "i", lazy.window.toggle_floating(), desc="Toggle floating mode for a window"),
    
    # launchers
    Key([mod, control], "f", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "c", lazy.spawn("kitty"), desc="Launch Kitty"),
    Key([mod], "n", lazy.spawn("nemo"), desc="Launch Nemo"),
    Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod], "f", lazy.group["scratchpad"].dropdown_toggle("brws")),

    # screenshot
    Key([], "Print", lazy.spawn("flameshot gui"), desc="Print Screen"),

    # audio stuff
    Key([], "XF86AudioRaiseVolume", lazy.spawn("./.config/qtile/scripts/temp_vol.sh upn"), desc="Increase volume",),
    Key([], "XF86AudioLowerVolume", lazy.spawn("./.config/qtile/scripts/temp_vol.sh down"), desc="Decrease volume",),
    Key([], "XF86AudioMute", lazy.spawn("./.config/qtile/scripts/temp_vol.sh mute"), desc="Toggle volume mute",),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Play last audio",),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Play next audio"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Toggle play/pause audio"),
]

def show_keys():
    key_help = ""
    for k in keys:
        mods = ""
        for m in k.modifiers:
            if m == "mod4":
                mods += "Super + "
            else:
                mods += m.capitalize() + " + "

        if len(k.key) > 1:
            mods += k.key.capitalize()
        else:
            mods += k.key
        key_help += "{:<25} {}".format(mods, k.desc + "\n")
    return key_help

keys.extend(
    [
        Key(
            [mod],
            "a",
            lazy.spawn(
                "sh -c 'echo \""
                + show_keys()
                + '" | rofi -dmenu -theme ~/.config/rofi/helpmenu/configTall.rasi -i -p ""\''
            ),
            desc="Print keyboard bindings",
        ),
    ]
)

