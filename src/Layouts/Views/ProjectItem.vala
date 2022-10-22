public class VSCode.Layouts.Views.ProjectItem : Gtk.ListBoxRow {
    public unowned VSCode.Window window { get; construct; }

    private Gtk.Label name_label;
    private Gtk.Label description_label;
    private Gtk.Label path_label;

    private Gtk.Button edit_button;
    private Gtk.Button delete_button;

    private Gtk.Image project_icon;

    private Gtk.Grid grid;

    public int index { get; construct; }
    public string title  { get; construct; }
    public string description  { get; construct; }
    public string folder { get; construct; }
    public string icon  { get; construct; }
    public bool select {get; set;}


    public ProjectItem(VSCode.Window main_window, int index, string name_text, string description_text, string path_text, string icon_name) {
        Object(
            window: main_window,
            index: index,
            title: name_text,
            description: description_text,
            folder: path_text,
            icon: icon_name
        );
    }

    construct {
        select = false;

        valign = Gtk.Align.FILL;
        halign = Gtk.Align.FILL;
        vexpand = true;
        hexpand = true;
        margin_bottom = 10;


        grid = new Gtk.Grid();
        grid.set_row_spacing(1);
        grid.set_column_spacing(10);
        grid.set_hexpand(true);
        grid.set_halign(Gtk.Align.FILL);
        grid.margin = 5;
        add(grid);

        // project_icon = new Gtk.Image.from_icon_name ("utilities-system-monitor", Gtk.IconSize.LARGE_TOOLBAR);
        project_icon = new Gtk.Image.from_icon_name(icon, Gtk.IconSize.LARGE_TOOLBAR);
        project_icon.pixel_size = 80;
        grid.attach(project_icon, 0, 0, 1, 3);

        name_label = new Gtk.Label(title);
        name_label.get_style_context().add_class("project-name");
        name_label.set_halign(Gtk.Align.START);
        grid.attach(name_label, 1, 0, 1, 1);

        description_label = new Gtk.Label(description);
        description_label.get_style_context().add_class("project-description");
        description_label.set_halign(Gtk.Align.START);
        grid.attach(description_label, 1, 1, 3, 1);

        path_label = new Gtk.Label(folder);
        path_label.get_style_context().add_class("project-path");
        path_label.set_halign(Gtk.Align.START);
        grid.attach(path_label, 1, 2, 3, 1);

        edit_button = new Gtk.Button.from_icon_name("document-edit-symbolic", Gtk.IconSize.BUTTON);
        edit_button.set_halign(Gtk.Align.END);
        edit_button.set_can_focus(false);
        edit_button.clicked.connect(on_edit_button_clicked);
        grid.attach(edit_button, 2, 0, 1, 1);

        delete_button = new Gtk.Button.from_icon_name("edit-delete-symbolic", Gtk.IconSize.BUTTON);
        delete_button.set_halign(Gtk.Align.START);
        delete_button.set_can_focus(false);
        delete_button.clicked.connect(on_delete_button_clicked);
        grid.attach(delete_button, 3, 0, 1, 1);


        print("ProjectItem::construct\n");

        // activate.connect (on_activate_project);
    }

    private void on_edit_button_clicked(Gtk.Button button) {
        select = true;
        VSCode.Services.ActionManager.action_from_group(VSCode.Services.ActionManager.ACTION_EDIT_PROJECT, window.get_action_group("win"));
    }

    private void on_delete_button_clicked(Gtk.Button button) {
        select = true;
        VSCode.Services.ActionManager.action_from_group(VSCode.Services.ActionManager.ACTION_DELETE_PROJECT, window.get_action_group("win"));
    }
}