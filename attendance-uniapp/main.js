import Vue from 'vue'
import App from './App'

Vue.config.productionTip = false

App.mpType = 'app'

// 引入全局uView
import uView from 'uview-ui'
Vue.use(uView);

 // colorui导航栏
import cuCustom from './colorui/components/cu-custom.vue'
Vue.component('cu-custom',cuCustom)

import moment from 'moment'
Vue.prototype.moment = moment;

// 时钟组件
// import clock from "components/clock/clock.vue"


const app = new Vue({
    ...App
})
app.$mount()
