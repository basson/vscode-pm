
public class VSCode.Layouts.Welcome : Granite.Widgets.Welcome {
    public unowned VSCode.Window window { get; construct; }

    public Welcome (VSCode.Window main_window) {
        Object (
            window: main_window,
            title: _("Welcome to Sequeler"),
            subtitle: _("Connect to Any Local or Remote Database.")
        );
    }

    construct {
        valign = Gtk.Align.FILL;
        halign = Gtk.Align.FILL;
        vexpand = true;

        append ("bookmark-new", _("Add a New Database"), _("Connect to a Database and Save It in Your Library"));
        append ("window-new", _("New Window"), _("Open a New Sequeler Window"));
        append ("folder-download", _("Import Connections"), _("Import Previously Exported Sequeler Connections"));

        activated.connect ( index => {
            switch (index) {
                case 0:
                    //  Sequeler.Services.ActionManager.action_from_group (Sequeler.Services.ActionManager.ACTION_NEW_CONNECTION, window.get_action_group ("win"));
                break;
                case 1:
                    //  Sequeler.Services.ActionManager.action_from_group (Sequeler.Services.ActionManager.ACTION_NEW_WINDOW, window.get_action_group ("win"));
                break;
                case 2:

                break;
            }
        });
    }
}