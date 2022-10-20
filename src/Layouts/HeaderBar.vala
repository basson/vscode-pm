
public class VSCode.Layouts.HeaderBar : Gtk.HeaderBar {
    public weak VSCode.Window window { get; construct; }

    //  private Gtk.Button logout_button;
    //  private Gtk.Button new_db_button;
    //  private Gtk.Button delete_db_button;
    //  private Gtk.Button edit_db_button;
    //  private Granite.ModeSwitch mode_switch;
    //  private Gtk.Popover menu_popover;

    public bool logged_out { get; set; }

    public HeaderBar (VSCode.Window main_window) {
        Object (
            window: main_window,
            logged_out: true
        );

        set_title (APP_NAME);
        set_show_close_button (true);

        build_ui ();

    }

    private void build_ui () {
        
    }
}
