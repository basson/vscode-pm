
public class VSCode.Widgets.AddProjectDialog : Gtk.Dialog {
    public weak VSCode.Window window { get; construct; }

    
    public AddProjectDialog(VSCode.Window? parent) {
        Object (
            border_width: 5,
            deletable: false,
            resizable: false,
            title: _("Create new VSCode project"),
            transient_for: parent,
            window: parent
        );
    }

    construct {
        build_content();

    }

    private void build_content () {
        //  var body = get_content_area ();


    }
}