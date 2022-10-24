public class VSCode.Models.Icons : GLib.Object {

    public string[] list;

    public Icons() {
        list = {
            "addon",
            "alchemy",
            "alien",
            "android",
            "app-image",
            "application",
            "arduino",
            "powers",
            "builder",
            "database",
            "game",
            "hardware",
            "hwinfo",
            "php",
            "power",
            "servers",
            "stack",
            "studio",
            "systems",
        };
    }

    public int get_index(string name) {
        for (var i = 0; i < list.length; i++) {
            if (list[i] == name)
                return i;
        }
        return 0;
    }

    public new string ? get(int index) {
        if (index > list.length)
            return null;
        return list[index];
    }

    public int size() {
        return list.length;
    }
}