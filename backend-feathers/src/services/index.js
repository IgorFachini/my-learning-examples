const authTest = require('./auth-test/auth-test.service.js');
// eslint-disable-next-line no-unused-vars
module.exports = function (app) {
  app.configure(authTest);
};
