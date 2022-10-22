
public class VSCode.Layouts.HeaderBar : Gtk.HeaderBar {
    public weak VSCode.Window window { get; construct; }

    private Granite.ModeSwitch mode_switch;
    private Gtk.Button add_project_button;
    private Gtk.Button import_button;
    private Gtk.Button export_button;


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
        mode_switch = new Granite.ModeSwitch.from_icon_name ("display-brightness-symbolic", "weather-clear-night-symbolic");
        mode_switch.primary_icon_tooltip_text = _("Light background");
        mode_switch.secondary_icon_tooltip_text = _("Dark background");
        mode_switch.valign = Gtk.Align.CENTER;
        mode_switch.bind_property ("active", settings, "dark-theme");
        mode_switch.notify.connect (() => {
            Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = settings.dark_theme;
        });
        pack_start (mode_switch);

        if (settings.dark_theme) {
            mode_switch.active = true;
        }

        import_button = new Gtk.Button.from_icon_name("document-open-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        import_button.valign = Gtk.Align.CENTER;
        import_button.can_focus = false;
        import_button.set_tooltip_text(_("Configure"));
        pack_end (import_button);
        
        export_button = new Gtk.Button.from_icon_name("document-save-as-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        export_button.valign = Gtk.Align.CENTER;
        export_button.can_focus = false;
        export_button.set_tooltip_text(_("Configure"));
        pack_end (export_button);

        add_project_button =  new Gtk.Button.from_icon_name ("list-add-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        add_project_button.valign = Gtk.Align.CENTER;
        add_project_button.can_focus = false;
        add_project_button.set_tooltip_markup(_("Add New Project"));
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
