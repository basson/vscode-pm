public class VSCode.Layouts.Views.ProjectItem : Gtk.ListBoxRow {
    public unowned VSCode.Window window { get; construct; }

    private Gtk.Label name_label;
    private Gtk.Label description_label;
    private Gtk.Label path_label;

    private Gtk.Button edit_button;
    private Gtk.Button delete_button;

    private Gtk.Image project_icon;

    private Gtk.Grid grid;

    public VSCode.Models.Project project { get; construct; }


    public ProjectItem (VSCode.Window main_window, VSCode.Models.Project model) {
        Object (
            window: main_window,
            project: model
        );
    }

    construct {

        // valign = Gtk.Align.FILL;
        // halign = Gtk.Align.FILL;
        // vexpand = true;
        // hexpand = true;

        margin_bottom = 10;


        grid = new Gtk.Grid ();
        grid.set_row_spacing (1);
        grid.set_column_spacing (10);
        // grid.set_hexpand(true);
        // grid.set_halign(Gtk.Align.FILL);
        grid.expand = true;
        grid.margin = 5;
        add (grid);

        // project_icon = new Gtk.Image.from_icon_name ("utilities-system-monitor", Gtk.IconSize.LARGE_TOOLBAR);
        project_icon = new Gtk.Image.from_icon_name (project.icon, Gtk.IconSize.LARGE_TOOLBAR);
        project_icon.pixel_size = 80;
        grid.attach (project_icon, 0, 0, 1, 3);

        name_label = new Gtk.Label (project.title);
        name_label.get_style_context ().add_class ("project-name");
        name_label.set_halign (Gtk.Align.START);
        name_label.set_hexpand (true);
        grid.attach (name_label, 1, 0, 1, 1);

        description_label = new Gtk.Label (project.description);
        description_label.get_style_context ().add_class ("project-description");
        description_label.set_halign (Gtk.Align.START);
        description_label.set_hexpand (true);
        grid.attach (description_label, 1, 1, 3, 1);

        path_label = new Gtk.Label (project.folder);
        path_label.get_style_context ().add_class ("project-path");
        path_label.set_halign (Gtk.Align.START);
        path_label.set_hexpand (true);
        grid.attach (path_label, 1, 2, 3, 1);

        edit_button = new Gtk.Button.from_icon_name ("document-edit-symbolic", Gtk.IconSize.BUTTON);
        edit_button.set_halign (Gtk.Align.END);
        edit_button.set_can_focus (false);
        edit_button.clicked.connect (on_edit_button_clicked);
        grid.attach (edit_button, 2, 0, 1, 1);

        delete_button = new Gtk.Button.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.BUTTON);
        delete_button.set_halign (Gtk.Align.START);
        delete_button.set_can_focus (false);
        delete_button.clicked.connect (on_delete_button_clicked);
        grid.attach (delete_button, 3, 0, 1, 1);



        // activate.connect (on_activate_project);
    }

    private void on_edit_button_clicked (Gtk.Button button) {
        var edit_dialog = new Widgets.EditProjectDialog (window, project);
        edit_dialog.modal = true;
        edit_dialog.show_all ();
    }

    private void on_delete_button_clicked (Gtk.Button button) {
        var confirm_dialog = new Gtk.MessageDialog (window, Gtk.DialogFlags.MODAL, Gtk.MessageType.QUESTION, Gtk.ButtonsType.YES_NO, _("You a realy delete project?"));
        confirm_dialog.response.connect (on_confirm_delete);
        confirm_dialog.show_all ();
    }

    public void on_confirm_delete (Gtk.Dialog dialog, int response_id) {
        switch (response_id) {
            case Gtk.ResponseType.YES:
                project_manager.remove (project);
                VSCode.Services.ActionManager.action_from_group (VSCode.Services.ActionManager.ACTION_SHOW_PROJECTS, window.get_action_group ("win"));
                break;
            case Gtk.ResponseType.NO:
            case Gtk.ResponseType.DELETE_EVENT:
                break;
        }
        dialog.destroy ();
    }
}
