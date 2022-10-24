
public class VSCode.Layouts.Main : Gtk.Paned {
    public weak VSCode.Window window { get; construct; }



    public VSCode.Layouts.Welcome welcome;
    public VSCode.Layouts.Projects projects;

    public VSCode.Widgets.EditProjectDialog edit_dialog;

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

        //  main_stack.add_named(welcome, "welcome");
        main_stack.add_named(welcome, "welcome");
        main_stack.add_named(projects, "projects");
        main_stack.set_visible_child_full("welcome", Gtk.StackTransitionType.UNDER_RIGHT);
        main_stack.set_visible_child_full("projects", Gtk.StackTransitionType.SLIDE_LEFT);

            show_projects();
        

        build_main();
    }

    public void build_main() {
        pack1(main_stack, true, false);
    }

    public void show_projects() {
        if (project_manager.size() == 0 || project_manager.is_empty()) {
            print("Main::show_projects welcome %d\n", project_manager.size());
            projects.set_visible(false);
            welcome.set_visible(true);
        } else {
            print("Main::show_projects project %d\n", project_manager.size());
            projects.set_visible(true);
            welcome.set_visible(false);
        }
        //  show_all();
        
    }
}
