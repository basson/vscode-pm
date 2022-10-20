schema_path = '/com/github/basson_xvi/vscode-pm/'
if get_option('profile') == 'development'
	schema_path += 'Devel/'
endif

schema_conf = configuration_data()
schema_conf.set('appid', application_id)
schema_conf.set('schema-path', schema_path)

configure_file(
	input: '@0@.gschema.xml.in'.format(meson.project_name()),
	output: '@0@.gschema.xml'.format(application_id),
	install: true,
	install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas'),
	configuration:schema_conf
)