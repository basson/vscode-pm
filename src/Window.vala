
public class VSCode.Window : Gtk.ApplicationWindow {
    public weak VSCode.Application app { get; construct; }

    public VSCode.Layouts.Main main;
    public VSCode.Layouts.HeaderBar headerbar;
    public VSCode.Services.ActionManager action_manager;
    public Gtk.ScrolledWindow scroller;


    public Gtk.AccelGroup accel_group { get; construct; }

    public Window (VSCode.Application vscode_app) {
        Object (
            application: vscode_app,
            app: vscode_app,
            // icon_name: Constants.PROJECT_NAME
            icon_name: "com.github.basson_xvi.vscode"
        );
    }

    construct {
        set_default_size (640, 480);

        set_resizable (false);

        accel_group = new Gtk.AccelGroup ();
        add_accel_group (accel_group);



        action_manager = new VSCode.Services.ActionManager (app, this);

        scroller = new Gtk.ScrolledWindow (null, null);

        main = new VSCode.Layouts.Main (this);
        headerbar = new VSCode.Layouts.HeaderBar (this);

        build_ui ();

        show_app ();
    }

    public VSCode.Window get_instance () {
        return this;
    }

    private void build_ui () {
        Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = settings.dark_theme;

        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource ("/com/github/basson_xvi/vscode-pm/stylesheet.css");

        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );


        delete_event.connect (before_destroy);
        set_titlebar (headerbar);
        set_border_width (0);
        scroller.add (main);
        add (scroller);
    }

    public bool before_destroy () {
        app.get_active_window ().destroy ();
        return true;
    }

    public void show_app () {
        show_all ();
        show ();
        present ();
    }
}
