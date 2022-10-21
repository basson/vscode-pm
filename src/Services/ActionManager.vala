/*
 * Copyright (c) 2011-2018 Alecaddd (http://alecaddd.com)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: Alessandro "Alecaddd" Castellani <castellani.ale@gmail.com>
 */

public class VSCode.Services.ActionManager : Object {


    public weak VSCode.Application app { get; construct; }
    public weak VSCode.Window window { get; construct; }

    public SimpleActionGroup actions { get; construct; }

    public const string ACTION_PREFIX = "win.";
    public const string ACTION_SHOW_PROJECTS = "action_show_projects";
    public const string ACTION_QUIT = "action_quit";

    private const ActionEntry[] ACTION_ENTRIES = {
        { ACTION_SHOW_PROJECTS, action_show_projects },
        { ACTION_QUIT, action_quit }
    };

    public ActionManager(VSCode.Application vscode_app, VSCode.Window main_window) {
        Object(
            app: vscode_app,
            window: main_window
        );
    }


    construct {
        actions = new SimpleActionGroup();
        actions.add_action_entries(ACTION_ENTRIES, this);
        window.insert_action_group("win", actions);
    }

    public static void action_from_group(string action_name, ActionGroup ? action_group) {
        action_group.activate_action(action_name, null);
    }

    private void action_quit() {
        window.before_destroy();
    }

    private void action_show_projects() {
        print("action show project\n");
        window.main.show_projects();
    }
}