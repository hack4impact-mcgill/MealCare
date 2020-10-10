<template>
  <div id="table-body">
    <input
      v-model="filter"
      type="text"
      placeholder="Filter by Name or Description" 
    >
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
          <th>Date Acquired</th>
        </tr>
      </thead>
      <tbody>
        <tr 
          v-for="(row, index) in filteredRows" 
          :key="`employee-${index}`"
        >
          <td> {{ row.type }} </td>
          <td> {{ row.description }} </td>
          <td> {{ row.date_acquired }} </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "SortableTable",
  props: {
  },
  
  data() {
    return {
        filter: "",
        rows: []
    }
  },
  computed: {
    filteredRows() {
      return this.rows.filter(row => {
        const name = row.type.toString().toLowerCase();
        const description = row.description.toLowerCase();
        const searchTerm = this.filter.toLowerCase();

        return (
          name.includes(searchTerm) || description.includes(searchTerm)
        );
      });
    }
  },
  mounted(){
    axios
    .get("http://127.0.0.1:8000/vendors/3")
    .then(response => this.rows = response.data.trays)
    .catch(error => console.log(error))
  },
  methods: {
  },
};

</script>

<style scoped>
#table-body {
    width: 90%;
    margin-right: auto;
    margin-left: auto;
    display: block;
}
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid black;
  background-color: white;
  text-align: left;
  padding: 8px;
}

th {
  background-color: #dddddd;
}

input[type=text] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 25px;
}
</style>