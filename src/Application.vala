namespace  VSCode {
    public VSCode.Services.Settings settings;
    public VSCode.Services.ProjectManager project_manager;
}


public class VSCode.Application : Gtk.Application {
    public GLib.List <Window> windows;

    construct {
        application_id = Constants.PROJECT_NAME;
        flags |= ApplicationFlags.HANDLES_OPEN;

        settings = new VSCode.Services.Settings ();
        project_manager = new VSCode.Services.ProjectManager ();

        //  schema = new Secret.Schema (Constants.PROJECT_NAME, Secret.SchemaFlags.NONE,
        //                           "id", Secret.SchemaAttributeType.INTEGER,
        //                           "schema", Secret.SchemaAttributeType.STRING);


        windows = new GLib.List <Window> ();
    }

    //  public void new_window () {
    //      new VSCode.Window (this).present ();
    //  }

    //  public override void window_added (Gtk.Window window) {
    //      windows.append (window as Window);
    //      base.window_added (window);
    //  }


    public override void window_removed (Gtk.Window window) {
        windows.remove (window as Window);
        base.window_removed (window);
    }

    protected override void activate () {
        Gtk.IconTheme.get_default().add_resource_path ("com/github/basson_xvi/vscode-pm/icons");
        //  this.add_new_window ();
        var window = new VSCode.Window (this);
        this.add_window (window);

    }
}
