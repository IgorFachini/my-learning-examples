<#import "template.ftl" as layout>

<@layout.htmlLayout ; section>
  <#if section="content">
    <div class="row window-height">
              <q-img
                v-if="$q.screen.lt.sm"
                src="${url.resourcesPath}/img/the-sun-rising.jpg"
                alt="Por do sol"
              ></q-img>
              <q-img
                v-else
                src="${url.resourcesPath}/img/the-sun-rising.jpg"
                alt="Por do sol"
              ></q-img>
      <section
        :class="[{ 'fixed-left': !$q.screen.lt.sm && !$q.screen.lt.md }, 'col-xs-12 col-sm-12 col-md-7 col-lg-7 col-xl-7']"
      >

      </section>

      <section
        :class="[
          {'absolute-right flex items-center': !$q.screen.lt.sm && !$q.screen.lt.md},
          {'q-mt-xl':$q.screen.lt.sm || $q.screen.lt.md},
          'col-12 col-sm-12 col-md-5 col-lg-5 col-xl-5 full-height q-pb-xl'
        ]"
      >
        <article class="full-width q-px-xl q-gutter-y-sm">
        <q-card
                class="bg-grey-2 shadow-8 q-pa-xl full-width"
                style="border-radius: 50px;"
              >
          <div>
            <q-img
              src="${url.resourcesPath}/img/realmName1-logo.jpg"
              alt="Logo realmName1"
              style="max-width: 64px"
            ></q-img>
          </div>
          <div
            v-if="success"
            class="q-gutter-y-md"
          >
            <div class="row justify-center">
              <q-icon
                name="done"
                color="positive"
                size="150px"
              />
            </div>
            <div class="row">
              <h3 class="q-ma-none q-py-md text-bold">
                Senha alterada com sucesso
              </h3>
            </div>
            <q-btn
              class="full-width"
              label="Entrar"
              style="background:#162E3D; color:white"
              size="20px"
              no-caps
              unelevated
              @click="window.location.href='/'"
            ></q-btn>
          </div>
          <div v-else>
            <h3 class="q-ma-none text-bold">
              Criar Nova Senha
            </h3>
            <p class="font-size-18px q-py-md">
              Sua nova senha deve ser diferente das suas senhas anteriores
            </p>
          </div>

          <q-form
            v-if="!success"
            ref="form"
            action="${url.loginAction}"
            method="post"
            @submit="onSubmit"
          >
            <div class="row justify-center q-gutter-y-sm q-col-gutter-sm">
              <q-input
                v-model="form.passwordNew"
                :type="isPwd ? 'password' : 'text'"
                class="col-12 q-py-none"
                label="Senha"
                outlined
                lazy-rules
                tabindex="1"
                color="primary"
                :input-class="{ 'text-positive': isPasswordPolicyCorrect(form.passwordNew)}"
                :rules="[
                  val => isPasswordPolicyCorrect(val) || 'Sua senha precisa ter no mínimo 8 caracteres, deve conter letra maiúscula, caractere especial e número'
                ]"
                hint="Sua senha precisa ter no mínimo 8 caracteres, deve conter letra maiúscula, caractere especial e número"
              >
                <template v-slot:append>
                  <q-icon
                    :name="isPwd ? 'visibility_off' : 'visibility'"
                    class="cursor-pointer"
                    @click="isPwd = !isPwd"
                  ></q-icon>
                  <q-icon
                    v-if="form.passwordNew && isPasswordPolicyCorrect(form.passwordNew)"
                    name="done"
                    color="positive"
                  ></q-icon>
                </template>
              </q-input>

              <q-input
                v-model="form.passwordConfirm"
                :type="isPwdConfirm ? 'password' : 'text'"
                class="col-12 q-py-none"
                label="Confirmar senha"
                outlined
                lazy-rules
                tabindex="2"
                color="primary"
                :input-class="{ 'text-positive': form.passwordNew && form.passwordNew === form.passwordConfirm}"
                :rules="[ val => val && val === form.passwordNew || 'As senhas não são iguais' ]"
              >
                <template v-slot:append>
                  <q-icon
                    :name="isPwdConfirm ? 'visibility_off' : 'visibility'"
                    class="cursor-pointer"
                    @click="isPwdConfirm = !isPwdConfirm"
                  ></q-icon>
                  <q-icon
                    v-if="form.passwordConfirm && form.passwordNew === form.passwordConfirm"
                    name="done"
                    color="positive"
                  ></q-icon>
                </template>
              </q-input>

              <div class="col-12 q-mt-md">
                <q-btn
                  class="full-width"
                  type="submit"
                  label="Salvar senha"
                  size="20px"
                  no-caps
                  unelevated
                  tabindex="3"
                  :loading="loading"
                  style="background:#162E3D; color:white"
                ></q-btn>
              </div>
            </div>
          </q-form>
          </q-card>
        </article>
      </section>
    </div>
    <script>
      /*
        Example kicking off the UI. Obviously, adapt this to your specific needs.
        Assumes you have a <div id="q-app"></div> in your <body> above
       */
      new Vue({
        el: '#q-app',
        data: function () {
          return {
            loading: false,
						isPwd: true,
      			isPwdConfirm: true,
            success: false,
            form: {
              passwordNew: '',
              passwordConfirm: ''
            }
          }
        },
        methods: {
          isPasswordPolicyCorrect (password) {
            return /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})/.test(password)
          },
          serialize (obj) {
            let str = []
            for (var p in obj)
              if (obj.hasOwnProperty(p)) {
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
              }
            return str.join("&");
          },
          onSubmit () {
            let thisRef = this
            const url = this.$refs.form.$el.action
            thisRef.loading = true
            axios.post(url, this.serialize({ 'password-new': this.form.passwordNew, 'password-confirm': this.form.passwordConfirm }),
              { headers: {'Content-Type': 'application/x-www-form-urlencoded'} })
              .then(function () {
                thisRef.success = true
              })
              .catch(function () {
                thisRef.$q.notify({
                  type: 'negative',
                  message: 'Erro ao salvar senha'
                })
              })
              .finally(() => {
                thisRef.loading = false
              })
          }
        }
      })
    </script>
  </#if>
</@layout.htmlLayout>
