
public class VSCode.Layouts.Projects : Gtk.ListBox {
    public unowned VSCode.Window window { get; construct; }

    public Projects(VSCode.Window main_window) {
        Object(
            window: main_window
        );
    }

    construct {
        valign = Gtk.Align.FILL;
        halign = Gtk.Align.FILL;
        vexpand = true;
        margin = 10;
        activate_on_single_click = true;
        row_activated.connect(on_activate_project);
    }

    public void load_projects() {

        print("Projects::load_projects\n");
        var container = get_children();
        foreach (Gtk.Widget element in container)
            remove(element);
        
        try {
            var data_file = File.new_for_path(Environment.get_home_dir() + "/Develop/.vscode.pm");
            var stream_data = new DataInputStream(data_file.read());
            string line;
            int index = 0;
            while ((line = stream_data.read_line(null)) != null) {
                string[] parameters = line.split("<|>");
                if (parameters[0] == null) {
                    parameters[0] = "Unknown or Null";
                }
                if (parameters[1] == null) {
                    parameters[1] = "Unknown or Null";
                }
                if (parameters[2] == null) {
                    parameters[2] = "Unknown or Null";
                }
                if (parameters[3] == null) {
                    parameters[3] = "application";
                }

                insert(new VSCode.Layouts.Views.ProjectItem(window, index, parameters[0], parameters[1], parameters[2], parameters[3]), -1);
                index ++;
            }
        } catch (Error e) {
            error("%s", e.message);
        }
        show_all();
    }

    public void on_activate_project(Gtk.ListBoxRow row) {
        var row_clocked = row as VSCode.Layouts.Views.ProjectItem;

        print("ProjectItem::on_activate_project: %s\n", row_clocked.folder);
        Posix.system("cd '" + row_clocked.folder + "' && code .");
    }
}