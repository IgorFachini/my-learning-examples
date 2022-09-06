// Initializes the `file` service on path `/files`
const { File } = require('./file.class')
const hooks = require('./file.hooks')
const hooksDownload = require('./file-download.hooks')

const multer = require('multer')
const multipartMiddleware = multer()

module.exports = function (app) {
  const options = {
    paginate: app.get('paginate')
  }

  app.use(
    '/files-mongo/download',
    new File(options, app),
    (req, res, next) => {
      try {
        res.setHeader('Content-Type', res.data.type || 'application/octet-stream')

        res.setHeader(
          'Content-Disposition',
          `attachment; filename=${res.data.name}`
        )
        return res.end(res.data.file.buffer)
      } catch (error) {
        next(error)
      }
      next()
    }
  )

  app.use(
    '/files-mongo',
    multipartMiddleware.single('uri'),
    (req, res, next) => {
      req.feathers.file = req.file
      next()
    },
    new File(options, app),
    (req, res, next) => {
      if (req.method === 'GET') {
        try {
          if (Array.isArray(res.data.data)) {
            res.data.data = res.data.data
              .map(res => res.file ? ({ ...res, file: `data:${res.type};base64,${res.file.toString('base64')}` }) : res)
            return res.json(res.data)
          }

          if (res.data.file) {
            return res.json({
              ...res.data,
              file: `data:${res.data.type};base64,${res.data.file.toString('base64')}`
            })
          }

          return res.json(res.data)
        } catch (error) {
          next(error)
        }
      }

      next()
    }
  )
  const filesService = app.service('files-mongo')
  const filesDownloadService = app.service('/files-mongo/download')

  filesService.hooks(hooks)
  filesDownloadService.hooks(hooksDownload)
}
