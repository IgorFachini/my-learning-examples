<#macro htmlLayout>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, height=device-height, width=device-width<% if (ctx.mode.cordova || ctx.mode.capacitor) { %>, viewport-fit=cover<% } %>">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/quasar@1.15.2/dist/quasar.min.css" rel="stylesheet" type="text/css">
    <style>
      // app global css in Stylus form
      html > body {
        width 100vw
        height 100vh
        overflow-x hidden
        font-family Roboto
      }

      .over-desktop {
        position: absolute !important;
        left: 26%;
        top: 55%;
        width: 40% !important;
      }

      .over-mobile {
        position: absolute !important;
        top: 70%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 40% !important;
      }
      .q-field--outlined .q-field__control {
				border-radius: 10px !important;
			}
			.font-size-18px {
				font-size: 18px;
			}
      .q-btn--rectangle {
        border-radius: 10px !important;
      }
      .q-field__bottom--animated > .q-field__messages {
        height: auto !important;
        min-height: 12px !important;
      }

      .q-field__bottom--animated {
        transform: none !important;
        position: static !important;
      }
      .text-primary {
        color: #6cd168 !important
      }
      .bg-info-custom {
        background: #e7e7e7 !important
      }
    </style>
  </head>

  <body>
    <script src="https://cdn.jsdelivr.net/npm/vue@^2.0.0/dist/vue.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/quasar@1.15.2/dist/quasar.umd.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <div
      id="q-app"
      class="fit"
    >
      <#nested "content" />
    </div>
  </body>
  </html>
</#macro>
