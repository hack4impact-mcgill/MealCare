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
          <th @click="sort('type')">
            Name
            <span
              v-if="'type' === currentSort"
              class="sort-arrow"
            >
              <i :class="[currentSortDir ==='asc' ? 'fas fa-arrow-up' : 'fas fa-arrow-down' ]" /> 
            </span> 
          </th>
          <th @click="sort('description')">
            Description
            <span
              v-if="'description' === currentSort"
              class="sort-arrow"
            >
              <i :class="[currentSortDir ==='asc' ? 'fas fa-arrow-up' : 'fas fa-arrow-down' ]" /> 
            </span>
          </th>
          <th @click="sort('date_acquired')">
            Date Acquired
            <span
              v-if="'date_acquired' === currentSort"
              class="sort-arrow"
            >
              <i :class="[currentSortDir ==='asc' ? 'fas fa-arrow-up' : 'fas fa-arrow-down' ]" /> 
            </span>
          </th>
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
    <p
      v-if="pageSize < rows.length"
    >
      <button @click="prevPage">
        Previous
      </button> 
      <button @click="nextPage">
        Next
      </button>
    </p>
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
        rows: [],
        currentSort:'type',
        currentSortDir:'asc',
        pageSize:10,
        currentPage:1
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
      })
      .sort((a,b) => {
        let modifier = 1;
        if(this.currentSortDir === 'desc') modifier = -1;
        if(a[this.currentSort] < b[this.currentSort]) return -1 * modifier;
        if(a[this.currentSort] > b[this.currentSort]) return 1 * modifier;
        return 0;
      })
      .filter((row, index) => {
        let start = (this.currentPage-1)*this.pageSize;
        let end = this.currentPage*this.pageSize;
        if(index >= start && index < end) return true;
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
    sort:function(s) {
      //if s == current sort, reverse
      if(s === this.currentSort) {
        this.currentSortDir = this.currentSortDir==='asc'?'desc':'asc';
      }
      this.currentSort = s;
    },
    nextPage:function() {
      if((this.currentPage*this.pageSize) < this.rows.length) this.currentPage++;
    },
    prevPage:function() {
      if(this.currentPage > 1) this.currentPage--;
    }
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

.sort-arrow {
  text-align: right !important;
}
</style>