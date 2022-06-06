import Chart from "chart.js/auto"
import { replaceDuplicates } from "webpack/lib/ModuleFilenameHelpers";

const displayChart = () => {
    var ctx_before = document.getElementById('myChart');
    if (ctx_before) {
      var ctx = ctx_before.getContext('2d');
      var myChart = new Chart(ctx, {
        type: 'line',
        data: {
          // labels: JSON.parse(ctx.canvas.dataset.labels),
          datasets: [{
            data: JSON.parse(ctx.canvas.dataset.data),
            fill: true,
            borderColor: 'rgb(75, 192, 192)',
            backgroundColor: 'rgb(255, 99, 132)',
          }]
        },
      });
    }

}


// export default displayChart;
