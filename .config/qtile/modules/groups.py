from libqtile.config import Group, Key, Match, ScratchPad, DropDown
from libqtile.lazy import lazy
from utils.settings import workspace_names
from modules.keys import keys, mod, shift

workspaces = [
    {"name": workspace_names[0], "key": "1", "matches": [], "lay": "bsp"},
    {"name": workspace_names[1], "key": "2", "matches": [Match(wm_class="code")], "lay": "bsp"},
    {"name": workspace_names[2], "key": "3", "matches": [], "lay": "bsp"},
    {"name": workspace_names[3], "key": "4", "matches": [Match(wm_class="discord")], "lay": "bsp"},
    {"name": workspace_names[4], "key": "5", "matches": [Match(wm_class="spotify")], "lay": "bsp"},
    {"name": workspace_names[5], "key": "6", "matches": [], "lay": "bsp"},
    {"name": workspace_names[6], "key": "7", "matches": [Match(wm_class="brave")], "lay": "bsp"},
    {"name": workspace_names[7], "key": "8", "matches": [], "lay": "bsp"},
    {"name": workspace_names[8], "key": "9", "matches": [Match(wm_class="ferdium")], "lay": "bsp"},
    {"name": workspace_names[9], "key": "0", "matches": [Match(wm_class="osu-wine")], "lay": "bsp"},
]

groups = []

for workspace in workspaces:
    matches = workspace["matches"] if "matches" in workspace else None
    groups.append(Group(workspace["name"], matches=matches, layout=workspace["lay"]))
    keys.append(
        Key(
            [mod],
            workspace["key"],
            lazy.group[workspace["name"]].toscreen(toggle=True),
            desc="Focus this group",
        )
    )

    keys.append(
        Key(
            [mod, shift],
            workspace["key"],
            *(
                lazy.window.togroup(workspace["name"]),
                lazy.group[workspace["name"]].toscreen(toggle=True),
            ),
            desc="Move focused window to another group",
        )
    )

groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                'term',
                '/usr/bin/alacritty',
                opacity=0.8,
                x=0.1,
                y=0.13,
                width=0.8,
                height=0.7,
                on_focus_lost_hide=True,
            ),
            DropDown(
                'brws',
                ['/usr/bin/firefox', '--new-instance'],
                opacity=0.8,
                x=0.1,
                y=0.08,
                width=0.8,
                height=0.8,
                on_focus_lost_hide=True,
                ),
        ],
    )
)
