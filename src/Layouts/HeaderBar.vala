
public class VSCode.Layouts.HeaderBar : Gtk.HeaderBar {
    public weak VSCode.Window window { get; construct; }

    private Gtk.Button add_project_button;
    private Gtk.Button settings_button;


    public bool logged_out { get; set; }

    public HeaderBar (VSCode.Window main_window) {
        Object (
            window: main_window,
            logged_out: true
        );

        set_title (APP_NAME);
        set_show_close_button (true);

        build_ui ();

    }

    private void build_ui () {
        settings_button = new Gtk.Button.from_icon_name("open-menu-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
        settings_button.valign = Gtk.Align.CENTER;
        settings_button.can_focus = false;
        pack_end (settings_button);

        add_project_button =  new Gtk.Button.from_icon_name ("list-add-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
        add_project_button.valign = Gtk.Align.CENTER;
        add_project_button.can_focus = false;
        add_project_button.clicked.connect (on_click_add_project_button);
        pack_end (add_project_button);
    }

    private void on_click_add_project_button() {
        var create_dialog = new Widgets.CreateProjectDialog(window);
        create_dialog.modal = true;
        create_dialog.show_all();
        create_dialog.destroy.connect(on_new_project);
    }

    private void on_new_project() {
        var data_file = File.new_for_path(Environment.get_home_dir() + "/Develop/.vscode.pm");
        if (data_file.query_exists()) {
            VSCode.Services.ActionManager.action_from_group(VSCode.Services.ActionManager.ACTION_SHOW_PROJECTS, window.get_action_group("win"));
        }
    }
}
