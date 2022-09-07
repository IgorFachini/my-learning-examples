const KcAdminClient = require('@keycloak/keycloak-admin-client').default;
(async () => {
  const kcAdminClient = new KcAdminClient({
    baseUrl: 'http://turbina/auth',
    realmName: 'realmName1'
  })

  await kcAdminClient.auth({
    grantType: 'client_credentials',
    clientId: 'backend-cli',
    clientSecret: '243e3814-6435-4ea3-8d15-db7b745994ce'
  })

  const users = [
    {
      name: 'user1 user1',
      username: 'user1',
      groups: [
        '/Group1'
      ],
      senha: 'user1'
    }
  ]

  const createUser = ({ username, password, groups, firstName, lastName }) => {
    console.log('groups', username, groups)
    return kcAdminClient.users.create({
      username,
      firstName,
      lastName,
      groups,
      enabled: true,
      emailVerified: true,
      credentials: [{
        type: 'password',
        value: password,
        temporary: false
      }]
    }).then(() => {
      console.log('created', username)
    })
  }

  const getFirstLastName = (name) => {
    const [firstName, ...lastName] = name.split(' ')

    return {
      firstName,
      lastName: lastName.join(' ')
    }
  }
  await Promise.all(
    users.map((user) => {
      const { firstName, lastName } = getFirstLastName(user.name)

      return createUser({
        firstName,
        lastName,
        username: user.username,
        password: user.password,
        groups: user.groups
      }).catch((e) => {
        console.log(e.response?.data, user.username)
        return {}
      })
    })
  )
})()
