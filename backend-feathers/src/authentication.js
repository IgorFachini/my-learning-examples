const { AuthenticationService, JWTStrategy } = require('@feathersjs/authentication');
const { OidcStrategy } = require('feathers-authentication-oidc');

module.exports = function (app) {
  const authentication = new AuthenticationService(app);

  authentication.register('jwt', new JWTStrategy());
  authentication.register('oidc', new OidcStrategy());

  app.use('/authentication', authentication);
};
