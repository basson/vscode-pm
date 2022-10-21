public class VSCode.Layouts.Views.ProjectItem : Gtk.ListBoxRow {
    public unowned VSCode.Window window { get; construct; }

    private Gtk.Label name_label;
    private Gtk.Label description_label;
    private Gtk.Label path_label;
    
    private Gtk.Image project_icon;

    private Gtk.Grid grid;


    public string title  { get; construct; }
    public string description  { get; construct; }
    public string folder { get; construct; }


    public ProjectItem(VSCode.Window main_window, string name_text, string description_text, string path_text) {
        Object(
            window: main_window,
            title: name_text,
            description: description_text,
            folder: path_text
        );
    }

    construct {
        valign = Gtk.Align.FILL;
        halign = Gtk.Align.FILL;
        vexpand = true;
        margin_bottom = 10;


        grid = new Gtk.Grid();
        grid.set_row_spacing(1);
        grid.set_column_spacing(20);
        grid.margin = 5;
        add(grid);

        project_icon = new Gtk.Image.from_icon_name ("utilities-system-monitor", Gtk.IconSize.LARGE_TOOLBAR);
        project_icon.pixel_size = 80;
        grid.attach (project_icon, 0, 0, 1, 3);

        name_label = new Gtk.Label(title);
        name_label.margin_top = 10;
        name_label.set_halign (Gtk.Align.START);
        grid.attach (name_label, 1, 0, 1, 1);

        description_label = new Gtk.Label(description);
        description_label.set_halign (Gtk.Align.START);
        grid.attach (description_label, 1, 1, 1, 1);

        path_label = new Gtk.Label(folder);
        path_label.set_halign (Gtk.Align.START);
        grid.attach (path_label, 1, 2, 1, 1);


        print("ProjectItem::construct\n");

        // activate.connect (on_activate_project);
    }
}