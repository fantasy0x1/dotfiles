from libqtile import layout
from libqtile.config import Match
from utils.settings import colors

layout_theme = {
    "border_width": 2,
    "margin": 5,
    "border_focus": colors[18],
    "border_normal": colors[10],
    "font": "JetBrainsMono Nerd Font",
    "grow_amount": 1,
}

layouts = [
    layout.Bsp(**layout_theme, fair=False, border_on_single=True),
    layout.MonadTall(**layout_theme, ratio=0.6),
    layout.Columns(**layout_theme, insert_position=1, border_on_single=True),
]

floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),  
        Match(title="branchdialog"),  
        Match(title="pinentry"), 
    ],
)
