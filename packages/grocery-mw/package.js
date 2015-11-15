Package.describe({
  name: 'grocery-mw',
  version: '1.0.0',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.use('session');
  api.use('rserve-meteor-client');
  api.versionsFrom('1.2.0.2');
  api.addFiles(['grocery-mw.js', 'auto-rserve.js'], 'server');
  api.export('grocery_mw');
});
