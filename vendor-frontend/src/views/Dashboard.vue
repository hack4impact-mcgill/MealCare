<template>
  <div class="container">
    <p>Dashboard</p>
    <p>{{info.id}}</p>
    <p>{{info.name}}</p>
    <p>{{info.city}}</p>
    <p>{{info.address}}</p>
      
    <ul id="example-1">
        <li v-for="(tray, index) in info.trays" :key="index">
            {{tray.description}} - {{index}}
        </li>
    </ul>
  </div>
</template>

<script>
    import axios from 'axios'

    export default {
        data () {
            return {       
                info: "",
            }   
        },
        mounted(){
            axios
            .get("http://127.0.0.1:8000/vendors/1")
            .then(response => this.info = response.data)
            .catch(error => console.log(error))
        }
    }

    
</script>

<style scoped>
    .container {
        background-image:url(../assets/bg-opacity.png);
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
        width:100vw;
        height:100vh;
    }
</style>