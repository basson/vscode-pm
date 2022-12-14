
public class VSCode.Layouts.HeaderBar : Gtk.HeaderBar {
    public weak VSCode.Window window { get; construct; }

    private Granite.ModeSwitch mode_switch;
    private Gtk.Button add_project_button;
    private Gtk.Button import_button;
    private Gtk.Button export_button;
    private Gtk.MenuButton config_button;

    private Gtk.Label exec_label;
    private Gtk.Label window_title_label;
    private Gtk.Entry exec_entry;
    private Gtk.Entry window_title_entry;


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
        mode_switch = new Granite.ModeSwitch.from_icon_name ("display-brightness-symbolic",
                                                             "weather-clear-night-symbolic");
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



        config_button = new Gtk.MenuButton ();
        config_button.set_image (new Gtk.Image.from_icon_name ("preferences-system-symbolic", Gtk.IconSize.SMALL_TOOLBAR));
        config_button.valign = Gtk.Align.CENTER;
        config_button.can_focus = false;
        config_button.set_tooltip_markup (_("Set Exec CMD"));
        
        exec_label = new Gtk.Label (_("Exec:"));
        exec_label.valign = Gtk.Align.END;
        exec_label.margin_end = 5;
        exec_label.margin_bottom = 5;

        exec_entry = new Gtk.Entry ();
        exec_entry.set_text (settings.exec);
        exec_entry.width_chars = 30;
        exec_entry.height_request = 5;
        exec_entry.margin_bottom = 5;

        window_title_label = new Gtk.Label (_("Title:"));
        window_title_label.valign = Gtk.Align.END;
        window_title_label.margin_end = 5;

        window_title_entry = new Gtk.Entry ();
        window_title_entry.set_text (settings.window_title);
        window_title_entry.width_chars = 30;
        window_title_entry.height_request = 5;

        var config_grid = new Gtk.Grid ();
        config_grid.expand = true;
        config_grid.margin = 10;
        config_grid.orientation = Gtk.Orientation.VERTICAL;
        config_grid.attach (exec_label, 0, 1, 1, 1);
        config_grid.attach (exec_entry, 1, 1, 1, 1);
        config_grid.attach (window_title_label, 0, 2, 1, 1);
        config_grid.attach (window_title_entry, 1, 2, 1, 1);
        config_grid.show_all ();

        var config_popover = new Gtk.Popover (config_button);
        config_popover.add (config_grid);
        config_popover.closed.connect (on_close_exec_popover);
        config_button.popover = config_popover;
        config_button.valign = Gtk.Align.CENTER;
        pack_end (config_button);

        import_button = new Gtk.Button.from_icon_name ("document-open-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        import_button.valign = Gtk.Align.CENTER;
        import_button.can_focus = false;
        import_button.set_tooltip_text (_("Import Projects"));
        import_button.clicked.connect (on_click_import_button);
        pack_end (import_button);

        export_button = new Gtk.Button.from_icon_name ("document-save-as-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        export_button.valign = Gtk.Align.CENTER;
        export_button.can_focus = false;
        export_button.set_tooltip_text (_("Export Projects"));
        export_button.clicked.connect (on_click_export_button);
        pack_end (export_button);

        add_project_button = new Gtk.Button.from_icon_name ("list-add-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        add_project_button.valign = Gtk.Align.CENTER;
        add_project_button.can_focus = false;
        add_project_button.set_tooltip_markup (_("Add Project"));
        add_project_button.clicked.connect (on_click_add_project_button);
        pack_end (add_project_button);
    }

    private void on_click_add_project_button () {
        var add_dialog = new Widgets.AddProjectDialog (window);
        add_dialog.modal = true;
        add_dialog.show_all ();
    }

    private void on_click_import_button () {
        var dialog = new Gtk.FileChooserNative ("Select .vscode.pm file", window, Gtk.FileChooserAction.OPEN, _("Import"), _("Cancel"));
        dialog.local_only = true;
        dialog.modal = true;
        dialog.response.connect (on_import_projects);
        dialog.run ();
    }

    private void on_click_export_button () {
        var dialog = new Gtk.FileChooserNative ("Save VSCode PM config file", window, Gtk.FileChooserAction.SAVE, _("Save"), _("Cancel"));
        dialog.local_only = true;
        dialog.modal = true;
        dialog.response.connect (on_export_projects);
        dialog.run ();
    }

    private void on_close_exec_popover () {
        settings.exec = exec_entry.get_text ();
        settings.window_title = window_title_entry.get_text ();
        window.set_title (settings.window_title);
    }

    private void on_import_projects (Gtk.NativeDialog dialog, int response_id) {
        var open_dialog = dialog as Gtk.FileChooserNative;
        bool is_import = false;
        switch (response_id) {
            case Gtk.ResponseType.ACCEPT:
                var file = open_dialog.get_file ();
                var path = open_dialog.get_filename ();
                print ("Import path : %s\n", path);
                try {
                    var file_info = file.query_info ("*", GLib.FileQueryInfoFlags.NONE);
                    print ("Content Type: %s\n", file_info.get_content_type ());
                    if (file_info.get_content_type () == "application/x-perl") {
                        is_import = project_manager.import (path);
                    }
                } catch (Error e) {
                    print ("%s", e.message);
                }
                break;
            case Gtk.ResponseType.CANCEL:
            case Gtk.ResponseType.DELETE_EVENT:
                is_import = true;
                break;
        }
        if (!is_import) {
            somtime_when_wrong (_("Filed import!"));
        } else {
            VSCode.Services.ActionManager.action_from_group (VSCode.Services.ActionManager.ACTION_SHOW_PROJECTS, window.get_action_group ("win"));
        }
        dialog.destroy ();
    }

    private void on_export_projects (Gtk.NativeDialog dialog, int response_id) {
        var open_dialog = dialog as Gtk.FileChooserNative;
        bool is_export = false;
        switch (response_id) {
            case Gtk.ResponseType.ACCEPT:
                var path = open_dialog.get_filename ();
                print ("Export path : %s\n", path);
                is_export = project_manager.export (path);
                break;
            case Gtk.ResponseType.CANCEL:
            case Gtk.ResponseType.DELETE_EVENT:
                is_export = true;
                break;
        }
        if (!is_export) {
            somtime_when_wrong (_("Filed export!"));
        } else {
            VSCode.Services.ActionManager.action_from_group (VSCode.Services.ActionManager.ACTION_SHOW_PROJECTS, window.get_action_group ("win"));
        }
        dialog.destroy ();
    }

    private void somtime_when_wrong (string message) {
        var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (_("Unable to Import/Export config"), message, "dialog-error", Gtk.ButtonsType.NONE);
        message_dialog.transient_for = window;

        var suggested_button = new Gtk.Button.with_label (_("Close"));
        message_dialog.add_action_widget (suggested_button, Gtk.ResponseType.ACCEPT);

        message_dialog.show_all ();
        if (message_dialog.run () == Gtk.ResponseType.ACCEPT) {
        }

        message_dialog.destroy ();
    }
}
