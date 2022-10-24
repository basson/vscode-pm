icondir = join_paths(get_option('datadir'), 'icons/hicolor')

install_data(
  '@0@.svg'.format(application_id),
  install_dir: join_paths(icondir, 'scalable/apps'),
)

install_data(
  'com.github.basson.vscode-pm.svg',
  install_dir: join_paths(icondir, 'symbolic/apps'),
  rename: '@0@-symbolic.svg'.format(application_id),
)