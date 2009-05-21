if(!window.Leonardo) { var Leonardo = {}; }
(function () {
	Leonardo.Sparkline = function (target_element, width, height, data) {
		settings = $.extend({
			sparkColour: '#036',
			addHover: false
		}, (arguments[4] || {}));
		
		init(target_element, width, height, data);
	};
	
	//
	// == Private methods
	//
	init = function (target_element, width, height, data, settings) {
		target = target_element;
		dimensions = {width: width, height: height};
		particulars = data;
		graph = null;
		
		drawCanvas();
		drawSpark();
	};
	
	drawCanvas = function () {
		graph = Raphael(target, dimensions.width, dimensions.height);
	};
	
	drawSpark = function () {
    var f = "";
    var circle = false;
		// Drop the pen
		path = graph.path({stroke: settings.sparkColour}).moveTo(0, dimensions.height);
		for (var i = 0; i < particulars.length; i++) {
	    f = (i==0) ? "moveTo" : "lineTo";
	    var average = Number(particulars[i].average);
	    var x = (i * (dimensions.width/particulars.length));
	    var y = dimensions.height - (percentageOfRange(average)/dimensions.height)*10;
      if (settings.addHover) {
        var rect = graph.rect(x-8, y-8, 16, 16).attr({stroke: "none", fill: "#ff0000", opacity: 0});
        $(rect[0]).data("id",particulars[i].id);
        (function(canvas,x,y) {
          // Show a marker on hover
          $(rect[0]).mouseover(function() {
            circle = canvas.circle(x, y, 3).attr({stroke: "none", fill: "#ff0000", opacity: 1});
            $(this).css('cursor','pointer');
            canvas.safari();
          });
          // Remove marker on mouseout
          $(rect[0]).mouseout(function() {
            circle.remove();
          });
          // Show a dialog on click
          $(rect[0]).toggle(function(event) {
            $('div.wave.dialog').remove();
            var self = this;
            // Do an http request for wave data for this wave $(this).data('id')
            $.get('/waves/'+$(this).data('id'),function(markup) {
              $(markup).appendTo($(rect[0]).parent().parent());
              $('div.wave.dialog').click(function() { $(this).remove(); });
              // Turn this into a bar graph with simple graph
              var data = get_data_for_graph();
              $("div.wave.dialog div").simplegraph(data.scores, data.labels,
                  {height: 90, width: 300, drawBars: true, barColor: '#004080', drawLine: false, drawPoints: false, drawGrid: false, barWidth: 20 });
            });
          }, 
          function() {  $('div.wave.dialog').remove();  });
        })(graph,x,y);
      }
			path[f](x, y);
		}
	};
	
	insertCurrentData = function () {
		$("#"+target).text(particulars[particulars.length-1]);
	};
	
	percentageOfRange = function (value) {
		return ((value/particulars.sum())*100);
	};
})();

// Extend array class
Array.prototype.sum = function () {
  var sum = 0;
  for(var i = 0; i < this.length; i++){
     sum += Number(this[i].average);
  }
  return sum;
};
