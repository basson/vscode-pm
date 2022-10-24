
public class VSCode.Widgets.AddProjectDialog : Gtk.Dialog {
    public weak VSCode.Window window { get; construct; }

    // private Gtk.Label header_title;
    private Gtk.Label name_label;
    private Gtk.Label description_label;
    private Gtk.Label path_label;
    private Gtk.Label icon_label;

    private Gtk.Entry name_entry;
    private Gtk.Entry description_entry;

// private Gtk.Button path_button;
    private Gtk.Button create_button;
    private Gtk.Button cancel_button;

    private Gtk.FileChooserButton path_button;

    private VSCode.Models.Icons icons;
    private Gtk.ComboBox icon_combobox;
    private Gtk.ListStore icon_liststore;
    private Gtk.TreeIter icon_iter;
    private Gtk.CellRendererPixbuf icon_pixbuf_renderer;
    private Gtk.CellRendererText icon_text_renderer;


    private Gtk.Grid grid;
    private Gtk.Box horizontal_box;

    private string project_name;
    private string project_description;
    private string project_path;
    private string project_icon;

    public AddProjectDialog (VSCode.Window ? parent) {
        Object (
            border_width: 5,
            deletable: false,
            resizable: false,
            title: _("Add VSCode Project"),
            transient_for: parent,
            window: parent
        );
    }

    construct {
        project_icon = "application";
        build_content ();
    }

    private void build_content () {
        var body = get_content_area ();

        grid = new Gtk.Grid ();
        grid.set_row_spacing (5);
        grid.set_column_spacing (5);
        body.add (grid);

        name_label = new Gtk.Label (_("Project Name:"));
        name_label.set_halign (Gtk.Align.END);
        grid.attach (name_label, 0, 0, 1, 1);

        name_entry = new Gtk.Entry ();
        grid.attach (name_entry, 1, 0, 1, 1);


        description_label = new Gtk.Label (_("Project Description:"));
        description_label.set_halign (Gtk.Align.END);
        grid.attach (description_label, 0, 1, 1, 1);

        description_entry = new Gtk.Entry ();
        grid.attach (description_entry, 1, 1, 1, 1);


        path_label = new Gtk.Label (_("Project Directory:"));
        path_label.set_halign (Gtk.Align.END);
        grid.attach (path_label, 0, 2, 1, 1);

        path_button = new Gtk.FileChooserButton (_("Choise"), Gtk.FileChooserAction.SELECT_FOLDER);
        path_button.set_hexpand (true);
        path_button.set_title ("Choise VSCode Project Directory");
        path_button.file_set.connect (on_choise_path);
        grid.attach (path_button, 1, 2, 1, 1);


        icon_label = new Gtk.Label (_("Project Icon:"));
        icon_label.set_halign (Gtk.Align.END);
        grid.attach (icon_label, 0, 3, 1, 1);


        icons = new VSCode.Models.Icons ();
        icon_liststore = new Gtk.ListStore (2, typeof (Gdk.Pixbuf), typeof (string));
        set_icon_liststore ();

        icon_pixbuf_renderer = new Gtk.CellRendererPixbuf ();
        icon_text_renderer = new Gtk.CellRendererText ();

        icon_combobox = new Gtk.ComboBox ();
        icon_combobox.set_popup_fixed_width (true);
        icon_combobox.set_hexpand (false);
        icon_combobox.active = 5;
        icon_combobox.set_model (icon_liststore);
        icon_combobox.pack_start (icon_pixbuf_renderer, true);
        icon_combobox.pack_end (icon_text_renderer, true);
        icon_combobox.add_attribute (icon_pixbuf_renderer, "pixbuf", 0);
        icon_combobox.add_attribute (icon_text_renderer, "text", 1);
        icon_combobox.changed.connect (on_icon_combobox_changed);

        grid.attach (icon_combobox, 1, 3, 1, 1);


        horizontal_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 5);
        horizontal_box.set_halign (Gtk.Align.END);
        horizontal_box.set_valign (Gtk.Align.END);
        horizontal_box.set_baseline_position (Gtk.BaselinePosition.BOTTOM);
        horizontal_box.margin_top = 30;
        grid.attach (horizontal_box, 0, 4, 2, 1);

        create_button = new Gtk.Button ();
        create_button.set_label (_("Create"));
        create_button.set_halign (Gtk.Align.END);
        create_button.clicked.connect (on_create_button_clicked);
        horizontal_box.pack_start (create_button, false, false, 5);


        cancel_button = new Gtk.Button ();
        cancel_button.set_label (_("Cancel"));
        cancel_button.set_halign (Gtk.Align.END);
        cancel_button.clicked.connect (on_cancel_button_clicked);
        horizontal_box.pack_end (cancel_button, false, false, 5);
    }

    private void on_choise_path (Gtk.FileChooserButton filechooserbutton) {
        project_path = filechooserbutton.get_filename ();
    }

    private void on_icon_combobox_changed () {
        Gtk.TreeIter iter;
        Value icon_name;
        icon_combobox.get_active_iter (out iter);
        icon_liststore.get_value (iter, 1, out icon_name);
        project_icon = (string) icon_name;
    }

    private void on_create_button_clicked (Gtk.Button button) {
        project_name = name_entry.get_text ();
        project_description = description_entry.get_text ();

        if (project_name == "" || project_description == "" || project_path == null) {
            var alert_dialog = new Gtk.MessageDialog (this, Gtk.DialogFlags.MODAL, Gtk.MessageType.ERROR, Gtk.ButtonsType.NONE, "Fill all fields!");
            alert_dialog.run ();
            return;
        }
        project_manager.set (new VSCode.Models.Project (project_manager.size () + 1, project_name, project_description, project_path, project_icon));

        VSCode.Services.ActionManager.action_from_group (VSCode.Services.ActionManager.ACTION_SHOW_PROJECTS, window.get_action_group ("win"));

        destroy ();
    }

    private void on_cancel_button_clicked (Gtk.Button button) {
        destroy ();
    }

    private void set_icon_liststore () {
        Gtk.IconTheme icon_theme = Gtk.IconTheme.get_default ();
        Gdk.Pixbuf pixbuf;
        try {
            for (var i = 0; i < icons.size (); i++) {
                icon_liststore.append (out icon_iter);
                pixbuf = icon_theme.load_icon (icons.get (i), 20, 0);
                icon_liststore.set (icon_iter, 0, pixbuf, 1, icons.get (i));
            }
        } catch {
            assert_not_reached ();
        }
    }
}
