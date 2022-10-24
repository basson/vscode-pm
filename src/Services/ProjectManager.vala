public class VSCode.Services.ProjectManager : Object {

    private string path = Environment.get_home_dir() + "/Develop/.vscode.pm";

    private GLib.Array<VSCode.Models.Project> projects;

    private bool empty = true;

    public ProjectManager() {
        projects = new GLib.Array<VSCode.Models.Project> ();
        load();
    }

    public void load() {
        var data_file = File.new_for_path(path);
        if (data_file.query_exists()) {
            empty = false;
        } else {
            return;
        }
        try {
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
                projects.append_val(new VSCode.Models.Project(index, parameters[0], parameters[1], parameters[2], parameters[3]));
                index++;
            }
        } catch (Error e) {
            error("%s", e.message);
        }
    }

    public void save() {
        try {
            empty = false;
            var data_file = File.new_for_path(path);
            var stream_data = new DataOutputStream(data_file.replace(null, false, GLib.FileCreateFlags.NONE));
            for (int i = 0; i < projects.length; i++) {
                var project = projects.index(i);
                stream_data.put_string(project.title + "<|>" + project.description + "<|>" + project.folder + "<|>" + project.icon + "\n");
            }
            stream_data.close();
        } catch (Error e) {
            error("%s", e.message);
        }
    }

    public new VSCode.Models.Project ? get(int position) {
        if (projects.length < position) {
            return null;
        }
        return projects.index(position);
    }

    public new void set(VSCode.Models.Project project) {
        if (projects.length == 0) {
            project.index = 0;
        } else {
            project.index = (int) projects.length + 1;
        }

        projects.append_val(project);
        save();
    }

    public void remove(VSCode.Models.Project project) {
        projects.remove_index(project.index);
        if (projects.length != 0) {
            for (var i = project.index; i < projects.length; i++) {
                projects.index(i).index = i;
            }
        }
        save();
    }

    public void update(VSCode.Models.Project project) {
        projects.remove_index(project.index);
        projects.insert_val(project.index, project);
        save();
    }

    public int size() {
        return (int) projects.length;
    }

    public bool is_empty() {
        return empty;
    }
}