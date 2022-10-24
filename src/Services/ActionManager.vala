

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

    public ActionManager (VSCode.Application vscode_app, VSCode.Window main_window) {
        Object (
            app: vscode_app,
            window: main_window
        );
    }


    construct {
        actions = new SimpleActionGroup ();
        actions.add_action_entries (ACTION_ENTRIES, this);
        window.insert_action_group ("win", actions);
    }

    public static void action_from_group (string action_name, ActionGroup ? action_group) {
        action_group.activate_action (action_name, null);
    }

    private void action_quit () {
        window.before_destroy ();
    }

    private void action_show_projects () {
        print ("action show project\n");
        window.main.projects.update_project ();
        window.main.show_projects ();
    }
}
