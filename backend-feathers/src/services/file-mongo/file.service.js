// Initializes the `file` service on path `/files`
const { File } = require('./file.class');
const hooksDownload = require('./file-download.hooks');

const multer = require('multer');
const multipartMiddleware = multer();
const { Parser } = require('json2csv');

class FileExportar {
  async find () {
    return [];
  }

  async get () { }
  async create () { }
  async update () { }
  async patch () { }
  async remove () { }
  setup () { }
}

module.exports = function (app) {
  const options = {
    paginate: app.get('paginate')
  };

  app.use(
    '/files-mongo/download',
    new File(options, app),
    (req, res, next) => {
      try {
        res.setHeader('Content-Type', res.data.type || 'application/octet-stream');

        res.setHeader(
          'Content-Disposition',
          `attachment; filename=${res.data.name}`
        );
        return res.end(res.data.file.buffer);
      } catch (error) {
        next(error);
      }
      next();
    }
  );

  app.use(
    '/files-mongo',
    multipartMiddleware.single('uri'),
    (req, res, next) => {
      req.feathers.file = req.file;
      next();
    },
    new File(options, app),
    (req, res, next) => {
      if (req.method === 'GET') {
        try {
          if (Array.isArray(res.data.data)) {
            res.data.data = res.data.data
              .map(res => res.file ? ({ ...res, file: `data:${res.type};base64,${res.file.toString('base64')}` }) : res);
            return res.json(res.data);
          }

          if (res.data.file) {
            return res.json({
              ...res.data,
              file: `data:${res.data.type};base64,${res.data.file.toString('base64')}`
            });
          }

          return res.json(res.data);
        } catch (error) {
          next(error);
        }
      }

      next();
    }
  );

  app.use(
    '/files-mongo/exportar',
    new FileExportar(),
    (req, res) => {
      res.setHeader('Content-Type', 'text/csv; charset=utf-8');
      res.setHeader('Content-type', 'application/csv');
      res.setHeader(
        'Content-Disposition',
        'attachment; filename=file-mongo.csv'
      );
      app.get('mongoClient').then(async ({ db }) => {
        try {
          const json2csvParser = new Parser({  fields: {} , escapedQuote: true, quote: '"', delimiter: ';', header: false });

          const coll = db.collection('atendimento');
          const query = req.query;
          delete query.$mongoNative;

          const aggCursor = coll.aggregate([{}]);
          // const columns = fields.map(f => f.label).map(c => `"${c}"`).join(';')
          // res.write(`${columns}\n`);
          for await (const doc of aggCursor) {
            res.write(json2csvParser.parse(doc) + '\n');
            res.flush();
          }
          res.end();
        } catch (error) {
          console.log('error export file', error);
          if (error.code) {
            res.status(error.code).json(error);
          }
          res.end();
        }
      });
    }
  );
  const filesDownloadService = app.service('/files-mongo/download');
  filesDownloadService.hooks(hooksDownload);
};
