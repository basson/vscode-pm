
public class VSCode.Layouts.Main : Gtk.Paned {
    public weak VSCode.Window window { get; construct; }



    public VSCode.Layouts.Welcome welcome;
    public VSCode.Layouts.Projects projects;

    public Gtk.Stack main_stack;

    public Main(VSCode.Window main_window) {
        Object(
            orientation: Gtk.Orientation.HORIZONTAL,
            window: main_window
        );
    }

    construct {
        main_stack = new Gtk.Stack();
        welcome = new VSCode.Layouts.Welcome(window);
        projects = new VSCode.Layouts.Projects(window);

        main_stack.add_named(welcome, "welcome");
        main_stack.add_named(projects, "projects");
        main_stack.set_visible_child_full("welcome", Gtk.StackTransitionType.UNDER_RIGHT);

        var data_file = File.new_for_path(Environment.get_home_dir() + "/Develop/.vscode.pm");
        if (data_file.query_exists()) {
            show_projects();
        }
        
        build_main();
    }

    public void build_main() {
        pack1(main_stack, true, false);
    }

    public void show_projects() {
        main_stack.remove(welcome);
        projects.load_projects();
        main_stack.set_visible_child_full ("projects", Gtk.StackTransitionType.SLIDE_LEFT);
        print("Main::show_projects\n");
    }
}
