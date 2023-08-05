import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import MessageView from '../views/MessageView.vue'
import ReturnView from '../views/ReturnView.vue'
import DetailView from '../views/DetailView.vue'
import RecordView from '../views/RecordView.vue'
import InfoView from '../views/InfoView.vue'
import AlterView from '../views/AlterView.vue'
import AdmLogin from "../views/AdmLogin.vue"
import AdmInfo from "../views/AdmInfo.vue"
import UserInfo from "../views/UserInfo.vue"
import AdmHome from "../views/AdmHome.vue"
import BookManage from "../views/BookManage.vue"

Vue.use(VueRouter)

const routes = [
  {
    path: '/home',
    name: 'home',
    component: HomeView
  },
  {
    path: '/message',
    name: 'message',
    component:MessageView
  },
  {
    path: '/',
    redirect: '/home',
  },
  {
    path: '/return',
    name: 'return',
    component:ReturnView
  },
  {
    path:'/detail',
    name:'detail',
    component:DetailView
  },
  {
    path: '/record',
    name: 'record',
    component:RecordView
  },
  {
    path: '/info',
    name: 'info',
    component:InfoView
  },
  {
    path: '/alter',
    name: 'alter',
    component:AlterView
  },
  {
    path:'/admLogin',
    name:'admLogin',
    component:AdmLogin
  },
  {
    path:'/admhome',
    name:"admhome",
    component:AdmHome
  },
  {
    path:"/bookmanage",
    name:"bookmanage",
    component:BookManage
  },
  {
    path:"/adminfo",
    name:"adminfo",
    component:AdmInfo
  },
  {
    path:"/userinfo",
    name:"userinfo",
    component:UserInfo
  }

]

const router = new VueRouter({
  routes
})

export default router
