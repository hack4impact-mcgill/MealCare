<template>
  <div class="container">
    <a
      href="https://www.mealcare.org"
      target="_blank"
    >
      <img
        alt="MealCare logo"
        src="../assets/textlogo-white.png"
      >
    </a>
    <form
      action=""
      method="POST"
    >
      <div class="inputcontainer">
        <label for="uname">Username</label>
        <input
          type="text"
          name="uname"
          required
        >
      </div>
      <div class="inputcontainer">
        <label for="psw">Password</label>
        <input
          type="password"
          name="psw"
          required
        >
      </div>
      <button type="submit">
        LOGIN
      </button>
      <label>
        <input
          type="checkbox"
          checked="checked"
          name="remember"
        > Remember me
      </label>
    </form>
  </div>
</template>

<script>
    export default {

    }
</script>

<style scoped>
    .inputcontainer {
        margin:2em;
    }

    label {
        padding:1em
    }

    input {
        background-color: transparent;
        border:none;
        border-bottom-style: solid;
        border-width: 2px;
        border-bottom-color: white;
    }

    input:focus{
        outline:none;
    }

    img {
        margin-top:20vh;
        width:200px
    }

    label {
        color:white;
    }

    button {
        color:white;
        border: 2px solid white;
        background-color:transparent;
        cursor: pointer;
        padding: 10px 20px;
        transition-duration: 0.25s;
    }

    button:hover {
        background-color:white;
        color:black;
        transition-duration: 0.25s;
    }
</style>