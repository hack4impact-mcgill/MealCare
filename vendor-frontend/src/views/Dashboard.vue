<template>
  <div class="container">
    <MenuButton />
    <Sidebar>
      <ul class="sidebar-panel-nav">
        <img
          alt="MealCare logo"
          src="../assets/textlogo-white.png"
          width="150"
          style="margin-bottom: 20px;"
        >
        <li><a href="#dashboard">Dashboard</a></li>
        <li><a href="#about">User Profile</a></li>
        <li><a href="#contact">Settings</a></li>
      </ul>
    </Sidebar>
    <div class="store-info">
      <h1>{{ info.name }}</h1>
      <p>{{ info.city }}</p>
      <p>{{ info.address }}</p>
    </div>
    <div class="table-container">
      <div class="header">
        <h2>Recent Tray Collects</h2>
        <button 
          class="export-btn"
          @click="exportTableToCSV('food-data-' + new Date().toLocaleDateString() + '.csv')"
        >
          Export
          <i class="fas fa-download" />
        </button>
      </div>
      <SortableTable
        :rows="trays"
      />
    </div>
    <div class="flexbox">
      <div class="cards">
        <Card
          :title="'Collects'"
          :values="getCollectsThisMonth()"
        />
        <Card
          :title="'Total Weight'"
          :values="getCollectsThisMonth()"
        />
      </div>
      <div class="table-container-flex">
        <div class="header">
          <h2>Tray Collects by Months</h2>
          <select
            v-model="yearSelected"
            class="select-year"
          >
            <option
              disabled
              value=""
            >
              Please select the year
            </option>
            <option>2020</option>
            <option>2021</option>
            <option>2032</option>
            <option>2042</option>
          </select>
        </div>
        <bar-chart 
          :chart-data="getTrayCollectsPerMonth(selected)"
          :options="getOptions()"
        />
      </div>
    </div>
    <div class="table-container">
      <div class="header">
        <h2>Top Surplus Food Item</h2>
        <select
          v-model="filterTypeSelected"
          class="select-year"
        >
          <option
            disabled
            value=""
          >
            Please select the filter type
          </option>
          <option>This Week</option>
          <option>This Month</option>
          <option>This Year</option>
        </select>
      </div>
      <pie-chart 
        :chart-data="getTrayCollectsPerType()"
        :options="getOptions()"
      />
    </div>
    <div class="table-container">
      <h2>Line Chart Example</h2>
      <line-chart 
        :chart-data="getLineChartData()"
        :options="getOptions()"
      />
    </div>
    <hr>
  </div>
</template>

<script>
    import axios from 'axios';
    import MenuButton from '../components/MenuButton.vue';
    import Sidebar from '../components/Sidebar.vue';
    import SortableTable from '../components/widgets/SortableTable.vue';
    import BarChart from '../components/widgets/BarChart.vue';
    import LineChart from '../components/widgets/LineChart.vue';
    import PieChart from '../components/widgets/PieChart.vue';
    import Card from '../components/widgets/Card.vue';
    import exportTableToCSV from '../helpers/csv-helpers.js'

    export default {
        components: {
            MenuButton,
            Sidebar,
            SortableTable, 
            BarChart,
            LineChart,
            PieChart,
            Card,
        },
        data () {
            return {
                exportTableToCSV,
                info: "",
                bar: [],
                trays: [],
                yearSelected: '2032',
                filterTypeSelected: 'This Week',
            }   
        },
        mounted(){
            axios
            .get("http://127.0.0.1:8000/vendors/3")
            .then(response => {
                this.info = response.data
                this.trays = response.data.trays 
                console.log(response.data)
                }
            )
            .catch(error => console.log(error))
        },
        methods: {
            getTrayCollectsPerMonth(year="2032") {
                var labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                var data = [];
                for (var i = 0; i < 12; i++) {
                    data[i] = 0;
                }

                for (let i = 0; i < this.trays.length; i++) {
                    var traysDate = new Date(this.trays[i].date_acquired)

                    if (traysDate.getFullYear() == year) {
                        data[traysDate.getMonth()] += 1
                    }
                }
                console.log(data)
                const result = { 
                    labels: labels,
                    datasets: [
                        {
                        label: 'Tray Collects',
                        backgroundColor: '#4AA25A',
                        data: data
                        }
                    ]
                }

                return result
            },
            getTrayCollectsPerType() {
                /*
                var dict = {};

                for (let i = 0; i < this.trays.length; i++) {
                    // console.log(this.trays[i])
                    if !(this.trays[i].type in dict) {
                        let month
                        if (this.trays[i].date_acquired[5] === "0") {
                            month = parseInt(this.trays[i].date_acquired.slice(6, 7))
                        }
                        else {
                            month = parseInt(this.trays[i].date_acquired.slice(5, 7))
                        }

                        data[month-1] += 1
                    }
                }
                console.log(data)
                */
                const result = {
                    labels: ['Beef', 'Bread', 'Cheese', 'Chicken'],
                    datasets: [
                        {
                        backgroundColor: [
                            '#41B883',
                            '#E46651',
                            '#00D8FF',
                            '#DD1B16'
                        ],
                        data: [40, 20, 80, 10]
                        }
                    ]
                }

                return result
            },
            getLineChartData() {
                return {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                    datasets: [
                        {
                        label: 'Data One',
                        backgroundColor: '#4AA25A',
                        data: [40, 39, 10, 40, 39, 80, 40]
                        }
                    ]
                }
            },

            getOptions() {
                return {
                    responsive: true, 
                    maintainAspectRatio: false,
                    scales: {
                        yAxes: [{
                            ticks: {
                                stepSize: 1
                            }
                        }]
                    },
                }
            },

            getCollectsThisMonth() {
                const today = new Date()
                const currentMonth = today.getMonth()
                const currentYear = today.getYear()

                var counter = 0;
                var previousMonth = 0;
                var percentage;

                for (let i = 0; i < this.trays.length; i++) {
                    var traysDate = new Date(this.trays[i].date_acquired)
                    if (traysDate.getMonth() == currentMonth && traysDate.getYear() == currentYear) {
                        counter++;
                    }

                    if (traysDate.getMonth() == currentMonth - 1 && traysDate.getYear() == currentYear) {
                        previousMonth++;
                    }
                }
                if (previousMonth) {
                    percentage = (counter - previousMonth) / previousMonth
                }
                else {
                    percentage = "± N/A"
                }

                const results = {
                    value: counter,
                    percentage: percentage,
                }

                console.log(results)
                return results;
            }
        }
    }

    
</script>

<style scoped>
    .container {
        background-color: #ffffff;
        background-image: linear-gradient(315deg, #ffffff 0%, #d7e1ec 74%);
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
    }

    .store-info {
        margin: auto;
        display: block;
    }

    .main-nav {
        display: flex;
        justify-content: space-between;
        padding: 0.5rem 0.8rem;
    }

    ul.sidebar-panel-nav {
        list-style-type: none;
        padding-inline-start: 0 !important;
    }

    ul.sidebar-panel-nav > li > a {
        color: black;
        text-decoration: none;
        font-size: 1.5rem;
        display: block;
        padding-bottom: 0.5em;
    }

    .table-container {
        margin-top: 30px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
        background-color: rgb(255, 255, 255);
        width: 90%;
        margin-right: auto;
        margin-left: auto;
        display: block;
        border-radius: 1em;
        padding: 2.5%;
    }

    .table-container-flex {
      margin-top: 30px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
      background-color: rgb(255, 255, 255);
      width: 65%;
      border-radius: 1em;
      padding: 30px;
    }

    .table-container h2 {
        color: black;
        text-align: left;
        margin-left: 5%;
    }

    .header {
        display: flex;
        justify-content: space-between;
    }

    .select-year {
        width: 20%;
        padding: 12px 20px;
        display: inline-block;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    hr {
        margin-top: 3rem;
        width: 80%;
        border: 0;
        border-top: 1px solid rgba(0,0,0,.1);
    }

    .flexbox {
      display: flex;
      justify-content: space-between;
      width: 95%;
      margin: auto;
      padding: 30px 0;
    }

    .cards {
      width: 25%;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .pie-chart, .line-chart, .bar-chart {
      margin: auto;
      display: block;
    }

    .export-btn {
      cursor: pointer;
      border: none;
      background-color: white;
      margin-right: 5%;
      font-size: 15px;
      color: rgb(74, 162, 90);
    }

    .export-btn:hover {
      opacity: 0.5;
    }
</style>