
public class VSCode.Layouts.Welcome : Granite.Widgets.Welcome {
    public unowned VSCode.Window window { get; construct; }

    public Welcome (VSCode.Window main_window) {
        Object (
            window: main_window,
            title: _("Welcome to VSCode PM"),
            subtitle: _("Manage your VSCode Project")
        );
    }

    construct {
        valign = Gtk.Align.FILL;
        halign = Gtk.Align.FILL;
        vexpand = true;

        append ("folder-new", _("Add VSCode Project"), _("Add VSCode project directory"));
        append ("open-menu", _("Select VScode PM data files"), _("Select exitsts data files on VSCode Project Manager"));

        activated.connect (index => {
            switch (index) {
                case 0:
                    add_project ();
                    break;
                case 1:
                    import_data_file ();
                    break;
            }
        });
    }

    private void add_project () {
        var add_dialog = new Widgets.AddProjectDialog (window);
        add_dialog.modal = true;
        add_dialog.show_all ();
        add_dialog.destroy.connect (on_new_project);
    }

    private void on_new_project () {
        var data_file = File.new_for_path (Environment.get_home_dir () + "/Develop/.vscode.pm");
        if (data_file.query_exists ()) {
            VSCode.Services.ActionManager.action_from_group (VSCode.Services.ActionManager.ACTION_SHOW_PROJECTS, window.get_action_group ("win"));
        }
    }

    private void import_data_file () {
        var dialog = new Gtk.FileChooserNative ("Select .vscode.pm file", window, Gtk.FileChooserAction.OPEN, _("Import"), _("Cancel"));
        dialog.local_only = true;
        dialog.modal = true;
        dialog.response.connect (on_import_projects);
        dialog.run ();
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
