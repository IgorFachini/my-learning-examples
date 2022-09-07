const { Service } = require('feathers-mongodb');

exports.File = class File extends Service {
  constructor (options, app) {
    super(options);

    app.get('mongoClient').then(({ db }) => {
      this.Model = db.collection('file');
    });
  }

  async create (data, params) {
    data.file = {
      file: params.file.buffer,
      name: params.file.originalname,
      size: params.file.size,
      type: params.file.mimetype || 'application/octet-stream'
    };
    return super.create(data.file, { attributes: ['id'] }).then(({ _id, name }) => ({ _id, name }));
  }
};
