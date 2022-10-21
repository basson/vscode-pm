
public class VSCode.Layouts.Welcome : Granite.Widgets.Welcome {
    public unowned VSCode.Window window { get; construct; }

    public Welcome(VSCode.Window main_window) {
        Object(
            window: main_window,
            title: _("Welcome to VSCode PM"),
            subtitle: _("Manage your VSCode Project")
        );
    }

    construct {
        valign = Gtk.Align.FILL;
        halign = Gtk.Align.FILL;
        vexpand = true;

        append("folder-new", _("Add a exist VSCode Project"), _("Add a exists VSCode project directory"));
        append("list-add", _("Create New VSCode Project"), _("Create new directory on VSCode project"));
        append("open-menu", _("Select VScode PM data files"), _("Select exitsts data files on VSCode Project Manager"));

        activated.connect(index => {
            switch (index) {
                case 0:
                    new_project();
                    break;
                case 1:
                    add_project();
                    break;
                case 2:
                    import_data_file();
                    break;
            }
        });
    }

    private void new_project() {
        var create_dialog = new Widgets.CreateProjectDialog(window);
        create_dialog.modal = true;
        create_dialog.show_all();
        create_dialog.destroy.connect(on_new_project);
        // create_dialog.destroy.connect(owned Gtk.Widget.destroy handler)
    }

    private void add_project() {
        var add_dialog = new Widgets.AddProjectDialog(window);
        add_dialog.modal = true;
        add_dialog.show_all();
    }


    private void on_new_project() {
        var data_file = File.new_for_path(Environment.get_home_dir() + "/Develop/.vscode.pm");
        if (data_file.query_exists()) {
            VSCode.Services.ActionManager.action_from_group(VSCode.Services.ActionManager.ACTION_SHOW_PROJECTS, window.get_action_group("win"));
        }
    }

    private void import_data_file() {
        var open_dialog = new Gtk.FileChooserNative(_("Select a data file"), window, Gtk.FileChooserAction.OPEN, _("Select"), _("Channel"));
        open_dialog.local_only = true;
        open_dialog.modal = true;
        open_dialog.response.connect(open_data_file);
        open_dialog.run();
    }

    private void open_data_file(Gtk.NativeDialog dialog, int response_id) {
        var open_dialog = dialog as Gtk.FileChooserNative;
        switch (response_id) {
            case Gtk.ResponseType.ACCEPT:
                var file = open_dialog.get_file();

                break;
            case Gtk.ResponseType.CANCEL:
                break;
        }
    }
}