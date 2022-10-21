
public class VSCode.Widgets.CreateProjectDialog : Gtk.Dialog {
    public weak VSCode.Window window { get; construct; }

    private Gtk.Label header_title;
    private Gtk.Label name_label;
    private Gtk.Label description_label;
    private Gtk.Label path_label;

    private Gtk.Entry name_entry;
    private Gtk.Entry description_entry;

// private Gtk.Button path_button;
    private Gtk.Button create_button;
    private Gtk.Button cancel_button;

    private Gtk.FileChooserButton path_button;


    private Gtk.Grid grid;
    private Gtk.Box horizontal_box;

    private string project_name;
    private string project_description;
    private string project_path;

    public CreateProjectDialog(VSCode.Window ? parent) {
        Object(
            border_width: 5,
            deletable: false,
            resizable: false,
            title: _("Create new VSCode project"),
            transient_for: parent,
            window: parent
        );
    }

    construct {
        build_content();
    }

    private void build_content() {
        var body = get_content_area();

        grid = new Gtk.Grid();
        grid.set_row_spacing(5);
        grid.set_column_spacing(5);
        body.add(grid);

        name_label = new Gtk.Label(_("Project Name:"));
        name_label.set_halign(Gtk.Align.END);
        grid.attach(name_label, 0, 0, 1, 1);

        name_entry = new Gtk.Entry();
        grid.attach(name_entry, 1, 0, 2, 1);


        description_label = new Gtk.Label(_("Project Description:"));
        description_label.set_halign(Gtk.Align.END);
        grid.attach(description_label, 0, 1, 1, 1);

        description_entry = new Gtk.Entry();
        grid.attach(description_entry, 1, 1, 2, 1);


        path_label = new Gtk.Label(_("Project Directory:"));
        path_label.set_halign(Gtk.Align.END);
        grid.attach(path_label, 0, 2, 1, 1);

        path_button = new Gtk.FileChooserButton(_("Choise"), Gtk.FileChooserAction.SELECT_FOLDER);
        path_button.set_title("Choise VSCode Project Directory");
        path_button.file_set.connect(on_choise_path);
        grid.attach(path_button, 1, 2, 1, 1);


        horizontal_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 5);
        horizontal_box.set_halign(Gtk.Align.END);
        grid.attach(horizontal_box, 0, 3, 2, 2);

        create_button = new Gtk.Button();
        create_button.set_label(_("Create"));
        create_button.set_halign(Gtk.Align.START);
        create_button.clicked.connect(on_create_button_clicked);
        horizontal_box.add(create_button);


        cancel_button = new Gtk.Button();
        cancel_button.set_label(_("Cancel"));
        cancel_button.set_halign(Gtk.Align.END);
        cancel_button.clicked.connect(on_cancel_button_clicked);
        horizontal_box.add(cancel_button);
    }

    private void on_choise_path(Gtk.FileChooserButton filechooserbutton) {
        project_path = filechooserbutton.get_filename();
    }

    private void on_create_button_clicked(Gtk.Button button) {
        project_name = name_entry.get_text();
        project_description = description_entry.get_text();

        if (project_name == "" || project_description == "" || project_path == null) {
            var alert_dialog = new Gtk.MessageDialog(this, Gtk.DialogFlags.MODAL, Gtk.MessageType.ERROR, Gtk.ButtonsType.NONE, "Fill all fields!");
            alert_dialog.run();
            return;
        }
        try {
            var data_file = File.new_for_path(Environment.get_home_dir() + "/Develop/.vscode.pm");
            var stream_data = new DataOutputStream(data_file.append_to(GLib.FileCreateFlags.NONE));
            stream_data.put_string(project_name + "<|>" + project_description + "<|>" + project_path + "\n");
            stream_data.close();
            destroy();
        } catch (Error e) {
            error("%s", e.message);
        }
    }

    private void on_cancel_button_clicked(Gtk.Button button) {
        destroy();
    }
}
