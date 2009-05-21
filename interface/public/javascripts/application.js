$(document).ready(function() {
  setup_competitors();
});

function setup_competitors () {
  $('td.graph').each(function(i) {
    var competitor_id = $(this).parent().attr('id').replace('competitor-','');
    // Build an array of wave scores
    var data = [];
    var list = $(this).children('ul');
    // For each wave a new item to the array
    list.children('li').each(function() {
      data.push({
        'average': Number($(this).html()),
        'id': Number($(this).attr('id').replace('wave-',''))
      });
    });
    console.log(data);
    // Use the data collected to make a new sparkline
    new Leonardo.Sparkline('graph-'+competitor_id, 100, 30, data, { addHover: true });
    // Hide the list
    list.hide();
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
