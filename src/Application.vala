namespace VSCode {
    public VSCode.Services.Settings settings;
    public VSCode.Services.ProjectManager project_manager;
}

public class VSCode.Application : Gtk.Application {
    public GLib.List<Window> windows;
    public VSCode.Window window;

    construct {
        application_id = Constants.PROJECT_NAME;
        flags |= ApplicationFlags.REPLACE;

        settings = new VSCode.Services.Settings ();
        project_manager = new VSCode.Services.ProjectManager ();

        windows = new GLib.List<Window> ();
    }

    public override void window_removed (Gtk.Window window) {
        windows.remove (window as Window);
        base.window_removed (window);
        quit ();
    }

    protected override void activate () {
        if(window != null)
        {
            active_window.present ();
            return;
        }

        Gtk.IconTheme.get_default ().add_resource_path ("com/github/basson/vscode-pm/icons");

        window = new VSCode.Window (this);
        this.add_window (window);
    }
}
