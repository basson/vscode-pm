
public class VSCode.Models.Project : Object {
    public int index { get; set; }
    public string title  { get; set; }
    public string description  { get; set; }
    public string folder { get; set; }
    public string icon  { get; set; }
    public bool select { get; set; }

    public Project(int index, string title, string description, string folder, string icon)
    {
        select = false;
        this.index = index;
        this.title = title;
        this.description = description;
        this.folder = folder;
        this.icon = icon;
    }
}