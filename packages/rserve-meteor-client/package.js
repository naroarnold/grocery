Package.describe({
  name: 'rserve-meteor-client',
  version: '0.3.4',
  // Brief, one-line summary of the package.
  summary: 'A  dead-simple wrapper around rserve-client.js to remove the callbacks.',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.0.2');
  api.addFiles('rserve-meteor-client.js', 'server');
  api.export('rserve_client', 'server');
});

Npm.depends({'rserve-client':'0.3.4'});
