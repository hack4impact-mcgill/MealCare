<template>
  <div class="card">
      <h3>{{title}}</h3>
      <h1>{{values.value}}</h1>
      <p>{{values.percentage}}</p>
      <p>Since last month</p>
  </div> 
</template>

<script>
export default {
    name: "Card",
    props: {
        title: {
            type: String,
            required: true,
        },
        values: {
            type: Object,
            required: true,
        },
    },
}
</script>

<style scoped>
.card {
    margin-top: 30px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
    background-color: rgb(255, 255, 255);
    width: 100%;
    margin-right: auto;
    margin-left: auto;
    display: block;
    border-radius: 1em;
    padding-top: 60px;
    padding-bottom: 60px;
}
</style>
