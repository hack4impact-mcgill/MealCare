<template>
  <div class="container">
    <div id="loginform">
        <LoginForm/>
    </div>
  </div>
</template>

<script>
    import LoginForm from "../components/LoginForm"

    export default {
        components: {
            LoginForm
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