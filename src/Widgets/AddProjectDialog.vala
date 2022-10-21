
public class VSCode.Widgets.AddProjectDialog : Gtk.Dialog {
    public weak VSCode.Window window { get; construct; }

    private Gtk.Label header_title;
    private Gtk.Label name_label;
    private Gtk.Label description_label;
    private Gtk.Label path_label;

    private Gtk.Entry name_entry;
    private Gtk.Entry description_entry;
    private Gtk.Entry path_entry;

    private Gtk.Button path_button;

    private Gtk.Grid grid;

    private string project_name;
    private string project_description;
    private string project_path;
    
    public AddProjectDialog(VSCode.Window? parent) {
        Object (
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

    private void build_content () {
        var body = get_content_area ();

        grid = new Gtk.Grid ();
        grid.set_row_spacing (5);
        grid.set_column_spacing (5);
        body.add (grid);

        name_label = new Gtk.Label (_("Project Name:"));
        grid.attach (name_label, 0, 0, 1, 1);

        name_entry = new Gtk.Entry ();
        name_entry.set_text (Environment.get_home_dir ());
        grid.attach (name_entry, 1, 0, 1, 1);


        description_label = new Gtk.Label (_("Project Description:"));
        grid.attach (description_label, 0, 1, 1, 1);
        description_entry = new Gtk.Entry ();
        grid.attach (description_entry, 1, 1, 1, 1);


    }
}