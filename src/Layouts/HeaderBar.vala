
public class VSCode.Layouts.HeaderBar : Gtk.HeaderBar {
    public weak VSCode.Window window { get; construct; }

    private Gtk.Button add_button;


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
        add_button =  new Gtk.Button.from_icon_name ("list-add-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
        add_button.valign = Gtk.Align.CENTER;
        add_button.can_focus = false;
        add_button.clicked.connect (on_click_add_button);
        pack_end (add_button);
    }

    private void on_click_add_button() {
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
