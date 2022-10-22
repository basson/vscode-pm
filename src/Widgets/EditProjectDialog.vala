
public class VSCode.Widgets.EditProjectDialog : Gtk.Dialog {
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

    private Gtk.ComboBox icon_combobox;
    private Gtk.ListStore icon_liststore;
    private Gtk.TreeIter icon_iter;
    private Gtk.CellRendererPixbuf icon_pixbuf_renderer;
    private Gtk.CellRendererText icon_text_renderer;


    private Gtk.Grid grid;
    private Gtk.Box horizontal_box;

    public string project_name { get; set; }
    public string project_description { get; set; }
    public string project_path { get; set; }
    public string project_icon { get; set; }

    public EditProjectDialog(VSCode.Window ? parent, string name, string description, string path, string icon) {
        Object(
            border_width: 5,
            deletable: false,
            resizable: false,
            title: _("Create new VSCode project"),
            transient_for: parent,
            window: parent,
            project_name: name,
            project_description: description,
            project_path: path,
            project_icon: icon
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
        name_entry.set_text(project_name);
        grid.attach(name_entry, 1, 0, 1, 1);


        description_label = new Gtk.Label(_("Project Description:"));
        description_label.set_halign(Gtk.Align.END);
        grid.attach(description_label, 0, 1, 1, 1);

        description_entry = new Gtk.Entry();
        description_entry.set_text(project_description);
        grid.attach(description_entry, 1, 1, 1, 1);


        path_label = new Gtk.Label(_("Project Directory:"));
        path_label.set_halign(Gtk.Align.END);
        
        grid.attach(path_label, 0, 2, 1, 1);

        path_button = new Gtk.FileChooserButton(_("Choise"), Gtk.FileChooserAction.SELECT_FOLDER);
        path_button.set_hexpand(true);
        path_button.set_title("Choise VSCode Project Directory");
        path_button.set_current_folder(project_path);
        path_button.file_set.connect(on_choise_path);
        grid.attach(path_button, 1, 2, 1, 1);


        icon_label = new Gtk.Label(_("Project Icon:"));
        icon_label.set_halign(Gtk.Align.END);
        grid.attach(icon_label, 0, 3, 1, 1);


        icon_liststore = new Gtk.ListStore(2, typeof (Gdk.Pixbuf), typeof (string));
        set_icon_liststore();

        icon_pixbuf_renderer = new Gtk.CellRendererPixbuf();
        icon_text_renderer = new Gtk.CellRendererText();

        icon_combobox = new Gtk.ComboBox();
        icon_combobox.set_popup_fixed_width(true);
        icon_combobox.set_hexpand(false);
        icon_combobox.active = 5;
        icon_combobox.set_model(icon_liststore);
        icon_combobox.pack_start(icon_pixbuf_renderer, true);
        icon_combobox.pack_end(icon_text_renderer, true);
        icon_combobox.add_attribute(icon_pixbuf_renderer, "pixbuf", 0);
        icon_combobox.add_attribute(icon_text_renderer, "text", 1);
        icon_combobox.changed.connect(on_icon_combobox_changed);

        grid.attach(icon_combobox, 1, 3, 1, 1);


        horizontal_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 5);
        horizontal_box.set_halign(Gtk.Align.END);
        horizontal_box.set_valign(Gtk.Align.END);
        horizontal_box.set_baseline_position(Gtk.BaselinePosition.BOTTOM);
        horizontal_box.margin_top = 30;
        grid.attach(horizontal_box, 0, 4, 2, 1);

        create_button = new Gtk.Button();
        create_button.set_label(_("Create"));
        create_button.set_halign(Gtk.Align.END);
        create_button.clicked.connect(on_create_button_clicked);
        horizontal_box.pack_start(create_button, false, false, 5);


        cancel_button = new Gtk.Button();
        cancel_button.set_label(_("Cancel"));
        cancel_button.set_halign(Gtk.Align.END);
        cancel_button.clicked.connect(on_cancel_button_clicked);
        horizontal_box.pack_end(cancel_button, false, false, 5);
    }

    private void on_choise_path(Gtk.FileChooserButton filechooserbutton) {
        project_path = filechooserbutton.get_filename();
    }

    private void on_icon_combobox_changed() {
        Gtk.TreeIter iter;
        Value icon_name;
        icon_combobox.get_active_iter(out iter);
        icon_liststore.get_value(iter, 1, out icon_name);
        project_icon = (string) icon_name;
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
            stream_data.put_string(project_name + "<|>" + project_description + "<|>" + project_path + "<|>" + project_icon + "\n");
            stream_data.close();
            destroy();
        } catch (Error e) {
            error("%s", e.message);
        }
    }

    private void on_cancel_button_clicked(Gtk.Button button) {
        destroy();
    }

    private void set_icon_liststore() {
        Gtk.IconTheme icon_theme = Gtk.IconTheme.get_default();
        Gdk.Pixbuf pixbuf;
        try {

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("addon", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "addon");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("alchemy", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "alchemy");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("alien", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "alien");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("android", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "android");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("app-image", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "app-image");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("application", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "application");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("arduino", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "arduino");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("powers", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "powers");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("builder", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "builder");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("database", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "database");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("game", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "game");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("hardware", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "hardware");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("hwinfo", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "hwinfo");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("php", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "php");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("power", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "power");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("servers", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "servers");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("stack", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "stack");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("studio", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "studio");

            icon_liststore.append(out icon_iter);
            pixbuf = icon_theme.load_icon("systems", 20, 0);
            icon_liststore.set(icon_iter, 0, pixbuf, 1, "systems");
        } catch {
            assert_not_reached();
        }
    }
}
