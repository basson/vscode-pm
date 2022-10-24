namespace VSCode {
    public VSCode.Services.Settings settings;
    public VSCode.Services.ProjectManager project_manager;
}

public class VSCode.Application : Gtk.Application {
    public GLib.List<Window> windows;

    construct {
        application_id = Constants.PROJECT_NAME;
        flags |= ApplicationFlags.FLAGS_NONE;

        settings = new VSCode.Services.Settings ();
        project_manager = new VSCode.Services.ProjectManager ();

        windows = new GLib.List<Window> ();
    }

    public override void window_removed (Gtk.Window window) {
        windows.remove (window as Window);
        base.window_removed (window);
    }

    protected override void activate () {
        Gtk.IconTheme.get_default ().add_resource_path ("com/github/basson_xvi/vscode-pm/icons");

        var window = new VSCode.Window (this);
        this.add_window (window);
    }
}
