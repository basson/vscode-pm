public const string APP_NAME = "VSCode PM";
public const string TERMINAL_NAME = "codepm";

public static int main (string[] args) {
    Environment.set_application_name ("VSCode PM");
    Environment.set_prgname ("VSCode PM");

    var application = new VSCode.Application ();

    return application.run (args);
}
