<#import "template.ftl" as layout>

<@layout.htmlLayout ; section>
  <#if section="content">
    <div
      v-show="loading"
      class="row fixed-center q-my-md"
    >
      <q-spinner-dots
        color="primary"
        size="40px"
      />
    </div>
    <div v-show="!loading">
      <#if skipLink??>
      <#else>
        <#if pageRedirectUri?has_content>
            <p style="display: none;"><a ref="link" href="${pageRedirectUri}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
        <#elseif actionUri?has_content>
            <p style="display: none;"><a ref="link" href="${actionUri}">${kcSanitize(msg("proceedWithAction"))?no_esc}</a></p>
        <#elseif (client.baseUrl)?has_content>
            <p style="display: none;"><a ref="link" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
        </#if>
      </#if>
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
            loading: true
          }
        },
        mounted () {
          if (this.$refs.link) {
            this.$refs.link.click()
          }


          if (this.isVerifyEmail()) {
            window.location.href = '/'
          }

          this.loading = false
        },
        methods: {
          isVerifyEmail () {
            const url = new URL(window.location.href)
            const action = url.searchParams.get('execution')
            return action === 'VERIFY_EMAIL'
          }
        }
      })
    </script>
  </#if>
</@layout.htmlLayout>
