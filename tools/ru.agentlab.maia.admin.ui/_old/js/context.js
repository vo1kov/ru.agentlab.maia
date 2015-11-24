var enterDuration = 700;
var exitDuration = 700;
var x0 = [];
var y0 = [];
var kx = [];
var ky = [];
var openedContexts = [];

var counter = 0;

var partition = d3.layout.partition()
	.value(function(d) { return 1; })
	.sort(function (a, b) {return d3.ascending(a.parent.children.indexOf(a), b.parent.children.indexOf(b));})
	;

//var lastZoomed = maia.root;

function leafCount(root){
	
	
}

/*****************************************
 *
 *	Event listeners
 *
 *****************************************/ 
 
dispatch.on("context_load.partition", function(root){
	createContexts(root);
});

dispatch.on("context_refresh.partition", function(root){
	refreshContexts(root);
});

dispatch.on("context_hover_start.partition", function(context) {
	d3.select(this).classed("hover", true);
});

dispatch.on("context_hover_end.partition", function(context) {
	d3.select(this).classed("hover", false);
});

dispatch.on("context_focus.partition", function(context) {
	d3.select(this).classed("zoom", true);
	//lastZoomed = context;
	calculate(context);
	dispatch.context_refresh(maia.root);
});

dispatch.on("services_load_end.partition", function(uuid) {
	d3.selectAll("g.context").filter(function(d){return d.uuid === uuid;})
		.classed("selected", true);
});

dispatch.on("context_close.partition", function(context) {
	d3.select(this).classed("selected", false);
});

dispatch.on("context_add.partition", function(context) {
	var length = 0;
	if (context.children){
		length = context.children.length;
	} else {
		context.children = [];
	}
	context.children.splice(length, 0, {"name" : "test", "uuid" : ("_" + counter++), "type" : "task"});
	//calculate(lastZoomed);
	dispatch.context_refresh(maia.root);
	//refreshContexts(maia.root);
});

dispatch.on("context_remove.partition", function(context) {
	bootbox.confirm("Вы уверены, что хотите удалить контекст \"" + context.name + "\"?", function(result) {
		if (result){
			var index = context.parent.children.indexOf(context);
			context.parent.children.splice(index, 1);
			//calculate(lastZoomed);
			dispatch.context_refresh(maia.root);
			//refreshContexts(maia.root);
		}
	});
});
/*
var zoom = d3.behavior.zoom()
    .scaleExtent([1, 50])
    .on("zoom", zoomed);
	
function zoomed(d) {
	//console.log(d);
	//console.log(d3.event.sourceEvent.deltaY);
	
	//d.value = d3.event.scale;//d.value - (d3.event.sourceEvent.deltaY / 100);
	//console.log(d.value);
	//dispatch.context_refresh(maia.root);
	svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
}
var drag = d3.behavior.drag()
    .origin(function(d) { return d; })
    .on("dragstart", dragstarted)
    .on("drag", dragged)
    .on("dragend", dragended);
	
function dragstarted(d) {
  d3.event.sourceEvent.stopPropagation();
  d3.select(this).classed("dragging", true);
}

function dragged(d) {
  d3.select(this).attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
}

function dragended(d) {
  d3.select(this).classed("dragging", false);
}
*/

/*****************************************
 *
 *	Redirect events
 *
 *****************************************/ 

function onContextMouseOver(ctx) {
	dispatch.context_hover_start.apply(this, arguments);
	d3.event.stopPropagation();
}

function onContextMouseOut(ctx) {
	dispatch.context_hover_end.apply(this, arguments);
	d3.event.stopPropagation();
}

function onContextMouseMove(ctx) {
	dispatch.context_hover_inprogress.apply(this, [d3.event.pageX + 40, d3.event.pageY - 40]);
	d3.event.stopPropagation();
}

function onContextMouseClick(ctx) {
	// Shift + Click
	if (d3.event.shiftKey && !d3.event.altKey && !d3.event.ctrlKey){
		// Focus on context
		dispatch.context_focus.apply(this, arguments);
	}
	// Alt + Click
	if (!d3.event.shiftKey && d3.event.altKey && !d3.event.ctrlKey){
		// Remove context
		dispatch.context_remove.apply(this, arguments);
	}
	// Click
	if (!d3.event.shiftKey && !d3.event.altKey && !d3.event.ctrlKey){
		var index = openedContexts.indexOf(ctx.uuid);
		if (index == -1) {
			// Load context services
			dispatch.context_open.apply(this, arguments);
			openedContexts.push(ctx.uuid);
		} else {
			// Unload context services
			dispatch.context_close.apply(this, arguments);
			openedContexts.splice(index, 1);
		}
	}
	// Ctrl + Click
	if (!d3.event.shiftKey && !d3.event.altKey && d3.event.ctrlKey){
		// Add child context
		dispatch.context_add.apply(this, arguments);
	}
	d3.event.stopPropagation();
}

/*****************************************
 *
 *	Functions
 *
 *****************************************/ 
 
function createContexts(root) {
	maia.root = root;
	var contextNodes = partition.nodes(root);
	//contextNodes.forEach(function(d){d.value = 1;});
	var context = svg.selectAll("g.context")
		.data(contextNodes, function(d){return d.uuid;});

	calculate(maia.root);

	var contextEnter = context.enter()
		.append("svg:g")
		.attr("class", function(d){return d.type;})
		.attr("transform", function(d) {return "translate(" + x(d) + "," + y(d) + ")"; })
		.classed("context", true)
		.style("opacity", 0)
		.on("mouseover", onContextMouseOver)
		.on("mousemove", onContextMouseMove)
		.on("mouseout", onContextMouseOut)
		.on("click", onContextMouseClick);

	contextEnter.append("svg:rect")
		.attr("width", function(d) { return width(d); })
		.attr("height", function(d) { return height(d); });

	contextEnter.append("svg:text")
		.attr("transform", "translate(10, 15)")
		.text(function(d){ return d.name.substring(0, width(d) / 6);})
		//.text(function(d) { return d.name; })
		;

	var contextUpdate = context.transition()
		.duration(enterDuration)
		.style("opacity", 1)
		.each("end", updateCoordinates)
		.transition()
		.style("opacity", null);
};

function refreshContexts(root) {
	var contextNodes = partition.nodes(root);
	//contextNodes.forEach(function(d){d.value = 1;});
	var context = svg.selectAll("g.context")
		.data(contextNodes, function(d){return d.uuid;});

	var contextEnter = context.enter()
		.append("svg:g")
		.attr("class", function(d){return d.type;})
		.style("opacity", 0)
		.attr("transform", function(d) {return "translate(" + x_subling_before(d) + "," + y_subling_before(d) + ")";})
		.classed("context", true)
		.on("mouseover", onContextMouseOver)
		.on("mousemove", onContextMouseMove)
		.on("mouseout", onContextMouseOut)
		.on("click", onContextMouseClick);

	contextEnter.append("svg:rect")
		.attr("width", function(d) {
			var index = d.parent.children.indexOf(d);
			var previous = d.parent.children[index - 1];
			if (previous) {
				return width(d); 
			} else {
				return 0;
			}
		})
		.attr("height", function(d) { 
			var index = d.parent.children.indexOf(d);
			var previous = d.parent.children[index - 1];
			if (previous) {
				return 0; 
			} else {
				return height(d);
			}
		});

	contextEnter.append("svg:text")
		.attr("transform", function(d) { return "translate(10, 5)"; })
		.text(function(d){ return d.name.substring(0, width(d) / 6);})
		//.text(function(d) { return d.name; })
		;

	var contextUpdate = context.transition()
		.duration(enterDuration)
		.style("opacity", 1)
		.attr("transform", function(d) { return "translate(" + x(d) + "," + y(d) + ")"; });

	contextUpdate.select("rect")
		.attr("width", function(d) { return width(d); })
		.attr("height", function(d) { return height(d); })
		.attr("transform", function(d) { return "translate(0, 0)"; })
		;

	contextUpdate.select("text")
		.style("opacity", function(d) { if (width(d) < 15){return 0;} else {return 1;}})
		.text(function(d){ return d.name.substring(0, width(d) / 6);})
		.attr("transform", function(d) { return "translate(10, 15)"; });

	function findPrev(d){
		var delta = 10000;
		var previous = {};
		for (var i = 0; i < d.parent.children.length; i++){
			var ch = d.parent.children[i];
			var newDelta = d.x - (ch._x + ch._dx);
			console.log(newDelta);
			if (newDelta < delta){
				previous = ch;
			}
		}
	}

	var contextExit = context.exit()
		.attr("opacity", 1)
		.transition()
		.duration(exitDuration)
		.attr("opacity", 0)
		.attr("transform", function(d) {
			var child = undefined;
			for (var i = 0; i < d.parent.children.length; i++){
				var ch = d.parent.children[i];
				var delta = d.x - (ch._x + ch._dx);
				if (delta == 0){
					child = ch;
					break
				}
			}
			if (d.parent.children.length > 0){
				if (child){
					var xRes = x0[d.depth](child.y);
					var yRes = y0[d.depth](child.x + child.dx);
				} else {
					var xRes = x0[d.depth](d.y);
					var yRes = y0[d.depth](d.parent.x);
				}				
			} else {
				var xRes = x0[d.depth](d.parent.y + d.parent.dy);
				var yRes = y0[d.depth](d.x);
			}
			return "translate(" + xRes + "," + yRes + ")"; })
		.remove();

	contextExit.select("rect")
		.attr("height", function(d) {
			if (d.parent.children.length > 0){
				return 0;
			} else {
				return height(d);
			}
		})
		.attr("width", function(d) {
			if (d.parent.children.length > 0){
				return width(d);
			} else {
				return 0;
			}
		});

	contextExit.select("text")
		.attr("opacity", 0);

	contextUpdate
		.each("end", updateCoordinates);
}

function calculate(ctx) {
	var d = ctx;
	for (var i = ctx.depth; i >= 0; i--){
		kx[d.depth] = w / maia.root.dx;
		ky[d.depth] = h / d.dx;
		x0[d.depth] = d3.scale.linear().range([0, w]);
		y0[d.depth] = d3.scale.linear().range([0, h]).domain([d.x, d.x + d.dx]);
		if (i == ctx.depth){
			for(var j = ctx.depth; j < maxDepth; j++){
				kx[j] = kx[d.depth];
				ky[j] = ky[d.depth];
				x0[j] = x0[d.depth];
				y0[j] = y0[d.depth];
			}
		}
		d = d.parent;
	}
}

function x(d){
	return x0[d.depth](d.y);
}

function x_subling_before(d){
	var index = d.parent.children.indexOf(d);
	var previous = d.parent.children[index - 1];
	if (previous) {
		if (previous._y){
			return x0[d.depth](previous._y);
		} else {
			return x0[d.depth](previous.y);
		}
	} else {
		if (d.parent._y){
			return x0[d.depth](d.parent._y + d.parent._dy);
		} else {
			return x0[d.depth](d.parent.y + d.parent.dy);
		}
		
	}
}

function y(d){
	return y0[d.depth](d.x);
}

function y_subling_before(d){
	var index = d.parent.children.indexOf(d);
	var previous = d.parent.children[index - 1];
	if (previous) {
		if (previous._x){
			return y0[d.depth](previous._x + previous._dx);
		} else {
			return y0[d.depth](previous.x + previous.dx);
		}
	} else {
		if (d.parent._x){
			return y0[d.depth](d.parent._x);
		} else {
			return y0[d.depth](d.parent.x);
		}	
	}
}

function width(d){
	return d.dy * kx[d.depth];
}

function height(d){
	return d.dx * ky[d.depth];
}

function updateCoordinates(d){
	d._x = d.x;
	d._y = d.y;
	d._dx = d.dx;
	d._dy = d.dy;
}