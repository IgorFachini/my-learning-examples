
const { NotImplemented } = require('@feathersjs/errors');
module.exports = {
  before: {
    all: [],
    find: [() => { throw new NotImplemented(); }],
    get: [],
    create: [() => { throw new NotImplemented(); }],
    update: [() => { throw new NotImplemented(); }],
    patch: [() => { throw new NotImplemented(); }],
    remove: [() => { throw new NotImplemented(); }]
  },

  after: {
    all: [],
    find: [],
    get: [],
    create: [],
    update: [],
    patch: [],
    remove: []
  },

  error: {
    all: [],
    find: [],
    get: [],
    create: [],
    update: [],
    patch: [],
    remove: []
  }
};
