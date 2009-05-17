$(document).ready(function() {
  setup_competitors();
});

function setup_competitors () {
  $('tbody tr').each(function(i) {
    var competitor_id = $(this).attr('id').replace('competitor-','');
    $.getJSON('/competitors/'+competitor_id+'/wave_averages',function(json) {
      new Leonardo.Sparkline('graph-'+competitor_id, 100, 30, json, {
        addHover: true
      });
    });
  });
}

function get_data_for_graph () {
  var temp_labels = [], temp_data = [];
  $("div.wave.dialog table tfoot th").each(function () {
      temp_labels.push($(this).html());
  });
  $("div.wave.dialog table tbody td").each(function () {
      temp_data.push($(this).html());
  });
  return {
    'labels': temp_labels,
    'scores': temp_data
  };
}
