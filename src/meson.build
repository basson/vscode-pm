conf_data = configuration_data()
conf_data.set('PROJECT_NAME', application_id)
conf_data.set('GETTEXT_PACKAGE', meson.project_name())
conf_data.set('VERSION', meson.project_version())

config_header = configure_file(
    input: 'config.vala.in',
    output: 'config.vala',
    configuration: conf_data
)


# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    application_id,
    'Main.vala',
    'Application.vala',
    'Window.vala',

    'Layouts/HeaderBar.vala',
    'Layouts/Main.vala',
    'Layouts/Welcome.vala',
    'Layouts/Projects.vala',
    'Layouts/Views/ProjectItem.vala',

    'Widgets/CreateProjectDialog.vala',
    'Widgets/AddProjectDialog.vala',
    'Widgets/EditProjectDialog.vala',

    'Models/Project.vala',
    'Models/Icon.vala',

    'Services/ActionManager.vala',
    'Services/Settings.vala',
    'Services/ProjectManager.vala',

    asresources,
    config_header,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('granite', version: '>= 0.5.1'),
        dependency('glib-2.0'),
        dependency('gee-0.8'),
        dependency('gobject-2.0'),
        dependency('libxml-2.0'),
        dependency('libgda-5.0'),
        m_dep,
        linux_dep
    ],
        vala_args: vala_args,
    install: true
)