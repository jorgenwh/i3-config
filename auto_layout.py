#!/usr/bin/env python3

import i3ipc

i3 = i3ipc.Connection(auto_reconnect=True)


def set_split_horizontal(i3):
    i3.command("split h")

def set_split_vertical(i3):
    i3.command("split v") 


def on_window_new(i3, e):
    workspace = i3.get_tree().find_focused().workspace()
    windows = [n for n in workspace.leaves() if n.window is not None]
    count = len(windows)

    print(count)
    if count >= 2:
        set_split_vertical(i3)
    else:
        set_split_horizontal(i3)


def on_window_close(i3, e):
    workspace = i3.get_tree().find_focused().workspace()
    windows = [n for n in workspace.leaves() if n.window is not None]
    count = len(windows)

    print(count)
    if count >= 2:
        set_split_vertical(i3)
    else:
        set_split_horizontal(i3)


i3.on("window::new", on_window_new)
i3.on("window::close", on_window_close)
i3.main()

