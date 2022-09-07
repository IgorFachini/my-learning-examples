// Initializes the `auth-test` service on path `/auth-test`
const { AuthTest } = require('./auth-test.class');
const hooks = require('./auth-test.hooks');

module.exports = function (app) {
  const options = {
    paginate: app.get('paginate')
  };

  // Initialize our service with any options it requires
  app.use('/auth-test', new AuthTest(options, app));

  // Get our initialized service so that we can register hooks
  const service = app.service('auth-test');

  service.hooks(hooks);
};
