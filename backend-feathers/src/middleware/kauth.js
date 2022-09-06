const jwtDecode = require('jwt-decode')

function kauth (req, res, next) {
  if (req.authentication && req.authentication.accessToken) {
    const kauth = jwtDecode(req.authentication.accessToken)

    const hasRole = name => kauth.realm_access.roles.includes(name)
    const isBoss = hasRole('bosses')
    const isCustomer = hasRole('customers')

    req.feathers.kauth = {
      hasRole,
      ...kauth,
      isBoss,
      isCustomer
    }
  }

  next()
}

module.exports = kauth
