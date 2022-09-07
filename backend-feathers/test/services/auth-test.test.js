const assert = require('assert');
const app = require('../../src/app');

describe('\'auth-test\' service', () => {
  it('registered the service', () => {
    const service = app.service('auth-test');

    assert.ok(service, 'Registered the service');
  });
});
