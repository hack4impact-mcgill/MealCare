import Vue from "vue";
import VueRouter from "vue-router";
import Login from "../views/Login";

Vue.use(VueRouter)

const routes = [
    {
        path:"/",
        name:"Login",
        component: Login
    }
]

export default new VueRouter({
    routes
})