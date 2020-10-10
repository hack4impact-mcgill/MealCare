import Vue from "vue";
import VueRouter from "vue-router";
import Login from "../views/Login";
import Dashboard from "../views/Dashboard";

Vue.use(VueRouter)

const routes = [
    
    {
        path:"/",
        name:"Login",
        component: Login
    },
    {
        path:"/dashboard",
        name:"Dashboard",
        component:Dashboard
    }
]

export default new VueRouter({
    mode: 'history',
    routes
})