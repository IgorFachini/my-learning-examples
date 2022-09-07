<#import "template.ftl" as layout>

<@layout.htmlLayout ; section>
  <#if section="content">
  <div class="row window-height">
    <q-img
      src="${url.resourcesPath}/img/example-image.jpg"
      alt="Example image"
    ></q-img>
      <section
        :class="col-12 flex items-center full-height q-pb-xl"
      >
        <article class="full-width q-px-xl q-gutter-y-sm">
         <q-card
            class="bg-grey-2 shadow-8 q-pa-xl full-width"
            style="border-radius: 50px;"
          >
            <div>
              <h3 class="q-ma-none text-bold">
                Sorry
              </h3>
              <p class="font-size-18px q-py-md">
                An error has occurred, please log in again through your app.
              </p>
              <q-btn
                class="full-width"
                label="ack to application"
                color="positive"
                size="20px"
                no-caps
                unelevated
                @click="window.location.href='/'"
              ></q-btn>
            </div>
          </q-card>
        </article>
      </section>
    </div>

    <script>
      new Vue({
        el: '#q-app',
        data: function () {
          return {
          }
        }
      })
    </script>
  </#if>
</@layout.htmlLayout>
