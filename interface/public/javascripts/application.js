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
