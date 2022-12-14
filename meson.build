# project name and programming language
project('com.github.basson.vscode-pm', 'vala', 'c',
    version: '0.0.1')

cc = meson.get_compiler('c')
m_dep = cc.find_library('m', required: true)

vala_args = ['--pkg', 'posix']

add_project_arguments(
    language: 'vala'
)

application_id = meson.project_name()


linux_dep = meson.get_compiler('vala').find_library('linux')

# Include the translations module
i18n = import('i18n')

# Include the gnome module
gnome = import('gnome')
asresources = gnome.compile_resources(
    'as-resources', 'data/assets.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language: 'c')

vala_lint = find_program('io.elementary.vala-lint', required : false)
if vala_lint.found()
    test (
        'Vala lint',
        vala_lint,
        args: ['-d', join_paths(meson.source_root(), 'src')]
    )
endif

subdir('src')
subdir('data')
subdir('po')
subdir('schemas')

meson.add_install_script('build-aux/meson/postinstall.py')
