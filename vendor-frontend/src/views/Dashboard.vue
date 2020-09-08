<template>
  <div class="container">
    <MenuButton></MenuButton>
    <Sidebar>
     <ul class="sidebar-panel-nav">
       <img alt="MealCare logo" src="../assets/textlogo-white.png" width=150 style="margin-bottom: 20px;">
       <li><a href="#dashboard">Dashboard</a></li>
       <li><a href="#about">User Profile</a></li>
       <li><a href="#contact">Settings</a></li>
     </ul>
   </Sidebar>
    <h1>{{info.name}}</h1>
    <p>{{info.city}}</p>
    <p>{{info.address}}</p>
    <div class="table-container">
        <h2>Recent Tray Collects</h2>
        <Table></Table>
    </div>
    <div class="table-container">
        <div class="header">
            <h2>Tray Collects by Months</h2>
            <select v-model="selected" class="select-year">
                <option disabled value="">Please select the year</option>
                <option>2020</option>
                <option>2021</option>
                <option>2032</option>
                <option>2042</option>
            </select>
        </div>
        <div style="margin-right: 10%; margin-left: 10%;">
        <bar-chart 
        :chartData="getTrayCollectsPerMonth(selected)"
        :options="getOptions()"
        />
        </div>
    </div>

  </div>
</template>

<script>
    import axios from 'axios';
    import MenuButton from '../components/MenuButton.vue';
    import Sidebar from '../components/Sidebar.vue';
    import Table from '../components/widgets/Table.vue';
    import BarChart from '../components/widgets/BarChart.vue';

    export default {
        components: {
            MenuButton,
            Sidebar,
            Table, 
            BarChart,
        },
        data () {
            return {       
                info: "",
                bar: [],
                trays: [],
                selected: '2032',
            }   
        },
        methods: {
            getTrayCollectsPerMonth(year="2032") {
                var labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
                var data = [];
                for (var i = 0; i < 12; i++) {
                    data[i] = 0;
                }

                for (let i = 0; i < this.trays.length; i++) {
                    // console.log(this.trays[i])
                    if (this.trays[i].date_acquired.startsWith(year)) {
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
                const result = { 
                    labels: labels,
                    datasets: [
                        {
                        label: 'Tray Collects by Months',
                        backgroundColor: '#f87979',
                        data: data
                        }
                    ]
                }

                return result
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
            }
        },
        mounted(){
            axios
            .get("http://127.0.0.1:8000/vendors/3")
            .then(response => {
                this.info = response.data
                this.trays = response.data.trays 
                }
            )
            .catch(error => console.log(error))
        }
    }

    
</script>

<style scoped>
    .container {
        background-image:url(../assets/bg-opacity.png);
        background-repeat: repeat;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
        width:100vw;
        height:120vh;
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
        color: #fff;
        text-decoration: none;
        font-size: 1.5rem;
        display: block;
        padding-bottom: 0.5em;
    }

    .table-container {
        margin-top: 30px;
        background-color: rgb(74, 162, 90);
        width: 90%;
        margin-right: auto;
        margin-left: auto;
        display: block;
        border-radius: 1em;
        padding-top: 30px;
        padding-bottom: 30px;
    }

    .table-container h2 {
        color: white;
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
        margin-right: 5%;
    }
</style>