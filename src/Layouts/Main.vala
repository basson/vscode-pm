
public class VSCode.Layouts.Main : Gtk.Paned {
    public weak VSCode.Window window { get; construct; }



    public VSCode.Layouts.Welcome welcome;


    public Gtk.Stack sidebar_stack;
    public Gtk.Stack main_stack;

    public Main (VSCode.Window main_window) {
        Object (
            orientation: Gtk.Orientation.HORIZONTAL,
            window: main_window
        );
    }

    construct {
       

        main_stack = new Gtk.Stack ();
        welcome = new VSCode.Layouts.Welcome (window);
        main_stack.add_named (welcome, "welcome");

        build_sidebar ();
        build_main ();
    }

    public void build_sidebar () {
        pack1 (sidebar_stack, false, false);
    }

    public void build_main () {
        pack2 (main_stack, true, false);
    }
}
