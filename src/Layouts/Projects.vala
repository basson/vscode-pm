
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
        if (!project_manager.is_empty()) {
            load_projects();
        }
    }

    public void load_projects() {

        print("Projects::load_projects\n");
        for (int i = 0; i < project_manager.size(); i++) {
            VSCode.Models.Project item = project_manager.get(i);
            insert(new VSCode.Layouts.Views.ProjectItem(window, item), -1);
        }
    }

    public void update_project() {
        var container = get_children();
        foreach (Gtk.Widget element in container)
            remove(element);

        for (int i = 0; i < project_manager.size(); i++) {
            VSCode.Models.Project item = project_manager.get(i);
            insert(new VSCode.Layouts.Views.ProjectItem(window, item), -1);
        }
        
        show_all();
    }

    public void on_activate_project(Gtk.ListBoxRow row) {
        var row_item = row as VSCode.Layouts.Views.ProjectItem;

        print("ProjectItem::on_activate_project: %s\n", row_item.project.folder);
        Posix.system("cd '" + row_item.project.folder + "' && code .");
    }
}