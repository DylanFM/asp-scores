$(document).ready(function() {
  setup_competitors();
});

function setup_competitors () {
  $('tbody tr').each(function(i) {
    var competitor_id = $(this).attr('id').replace('competitor-','');
    $.getJSON('/competitors/'+competitor_id,function(json) {
      var data = jQuery.map(json, function(score) {
        return Number(score);
      });
      new Leonardo.Sparkline('graph-'+competitor_id, 100, 30, data);
    });
  });
}
