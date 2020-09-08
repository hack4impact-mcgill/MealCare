<script>
import { Pie, mixins } from 'vue-chartjs'

export default {
  extends: Pie,
  mixins: [mixins.reactiveProp],
  props: ['chartData', 'options'],
  mounted () {
    this.renderChart(this.chartData, this.options)
  },

  updated () {
      this.renderChart(this.chartData, this.options)
  }
}
</script>