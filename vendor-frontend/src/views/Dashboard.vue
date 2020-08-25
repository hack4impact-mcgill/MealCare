<template>
  <div class="container">
    <MenuButton></MenuButton>
    <Sidebar>
     <ul class="sidebar-panel-nav">
       <li><a href="#home">Dashboard</a></li>
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
        <h2>Tray Collects by Months</h2>
        <BarChart
        class="chart"
        :data-set="getTrayCollectsPerMonth('2032')"
        :margin-left="40"
        :margin-top="40"
        :tick-count="5"
        :bar-padding="0.1"
        />
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
            BarChart
        },
        data () {
            return {       
                info: "",
                bar: [],
                trays: [],
            }   
        },
        methods: {
            getTrayCollectsPerMonth(year) {
                var dict = {}
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

                        if (!(month in dict)) {
                            dict[month] = 1
                        }
                        else {
                            dict[month] += 1
                        }
                    }
                }
                console.log(dict)
                var values = [["January", 0], ["February", 0], ["March", 0], ["April", 0], ["May", 0], ["June", 0],
                ["July", 0], ["August", 0], ["September", 0], ["October", 0], ["November", 0], ["December", 0]];

                for (var key in dict) {
                    values[key - 1][1] = dict[key]
                }
                return values
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
        background-repeat: repeat-y;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
        width:100vw;
        height:100vh;
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
</style>