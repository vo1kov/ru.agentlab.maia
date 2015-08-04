var bundle = d3.layout.bundle();


var context2services = [];


/*****************************************
 *
 *	Event listeners
 *
 *****************************************/ 
 
dispatch.on("context_open.services", function(context) {
	socket.send(JSON.stringify({"command" : "services", "parameters" : [{"context" : context.uuid}]}));
});

dispatch.on("context_close.services", function(context) {
	var that = d3.selectAll("g.context").filter(function(d){return d.uuid === context.uuid;});
	context2services[context.uuid] = [];
	removeServices(that);
	//createServices(that, []);
});

dispatch.on("services_load_end.services", function(uuid, services) {
	var that = d3.selectAll("g.context").filter(function(d){return d.uuid === uuid;});
	context2services[uuid] = services.services;
	createServices(that, services.services);
});

dispatch.on("service_hover_start.services", function(context) {
	d3.select(this).classed("hover", true);
});

dispatch.on("context_refresh.services", function(root){
	for (var key in context2services) {
		var services = context2services[key];
		var that = d3.selectAll("g.context").filter(function(d){return d.uuid === key;});
		createServices(that, services);
	}
});


/*****************************************
 *
 *	Redirect events
 *
 *****************************************/ 
 
function onServiceMouseOver(service) {
	d3.select(this).classed("hover", true);
	//var serv = svg.selectAll(".service").filter(function(d){ return d === service; });
		//serv.classed("active", function(d){ return re.test(d.fullName) ? true : false; });
	//	serv.select("rect").style("fill", function(d){ return getTypeColor(d.type); });
		
	dispatch.service_hover_start.apply(this, arguments);
	
	//highlight(service.fullName);
	//showTooltip(service);
	d3.event.stopPropagation();
}

function onServiceMouseMove(service) {
	dispatch.service_hover_inprogress.apply(this, [d3.event.pageX + 40, d3.event.pageY - 40]);
	d3.event.stopPropagation();
}

function onServiceMouseOut(service) {
	d3.select(this).classed("hover", false);
	//highlight(null);
	//var serv = svg.selectAll(".service").filter(function(d){ return d === service; });
	//	serv.select("rect").style("fill", function(d){ return re.test(d.fullName) ? getTypeColor(d.type) : null; });
		
	dispatch.context_hover_end.apply(this, arguments);
	
	//hideTooltip();
	d3.event.stopPropagation();
}

function onServiceMouseClick(service) {
	
		$('.ui.basic.modal')
  .modal('show')
;
/*
	if (!service.children){
		bootbox.dialog({
			title: "This is a form in a modal.",
			message: '<div class="row">  ' +
				'<div class="col-md-12"> ' +
				'<form class="form-horizontal"> ' +
				'<div class="form-group"> ' +
				'<label class="col-md-4 control-label" for="name">Name</label> ' +
				'<div class="col-md-4"> ' +
				'<input id="name" name="name" type="text" placeholder="Your name" class="form-control input-md"> ' +
				'<span class="help-block">Here goes your name</span> </div> ' +
				'</div> ' +
				'<div class="form-group"> ' +
				'<label class="col-md-4 control-label" for="awesomeness">How awesome is this?</label> ' +
				'<div class="col-md-4"> <div class="radio"> <label for="awesomeness-0"> ' +
				'<input type="radio" name="awesomeness" id="awesomeness-0" value="Really awesome" checked="checked"> ' +
				'Really awesome </label> ' +
				'</div><div class="radio"> <label for="awesomeness-1"> ' +
				'<input type="radio" name="awesomeness" id="awesomeness-1" value="Super awesome"> Super awesome </label> ' +
				'</div> ' +
				'</div> </div>' +
				'</form> </div>  </div>',
			buttons: {
				success: {
					label: "Save",
					className: "btn-primary",
					callback: function () {
						var name = $('#name').val();
						var answer = $("input[name='awesomeness']:checked").val()
					   // Example.show("Hello " + name + ". You've chosen <b>" + answer + "</b>");
					}
				}
			}
		//}
		});
		d3.event.stopPropagation();
	}*/
		d3.event.stopPropagation();
}
	
function imports(nodes) {
	var map = {},
		imports = [];

	// Compute a map from name to node.
	nodes.forEach(function(d) {
		map[d.name] = d;
	});

	// For each import, construct a link from the source to target node.
	nodes.forEach(function(d) {
		if (d.imports) d.fields.forEach(function(i) {
			imports.push({source: map[d.name], target: map[i]});
		});
	});

	return imports;
}
  
var line = d3.svg.line()
	.interpolate("bundle")
	.tension(.85)
	.x(function(d) { return d.x + d.dx / 2; })
	.y(function(d) { return d.y + d.dy / 2; });

function reassemble(root){
	var result = {};
	result.name = "root";
	result.children = [];
	if (!root || root.length == 0) {
		return null;
	}

	function find(array, name){
		if (array instanceof Array){
			for (var i = 0; i < array.length; i++){
				if (array[i].name == name){
					return array[i];
				}
			}
		}
		return null;
	}

	for(var i = 0; i < root.length; i++){
		var service = root[i];
		var type = service.key;
		var slices = type.split(".");
		var current = result.children;
		var fqn = slices[0];
		for (var j = 0; j < slices.length; j++){
			if (j > 0){
				fqn = fqn + "." + slices[j];
			}
			var slice = slices[j];
			var found = find(current, slice);
			if (found){
				var current = found.children;
			} else {
				var n = {"name" : slice, "fullName" : fqn};
				if(j != (slices.length - 1)){
					n.children = [];
				} else {
					n.type = root[i].type;
					n.value = root[i].value;
				}
				current.push(n);
				var current = n.children;
			}
		}
	}
	return result;
}

function x_context(d, c){
	return x0[c.depth](d.y);
}

function height_ctx(d, c){
	return d.dx * ky[c.depth];
}

function highlight(type) {
	var serv = svg.selectAll(".service");
	if (type == null) {
		serv.classed("active", function(d){ return re.test(d.fullName) ? true : false; });
		serv.select("rect").style("fill", function(d){ return re.test(d.fullName) ? getTypeColor(d.type) : null; });
	} else {
		var resServ = serv.filter(function(da){return da.fullName === type;});
		resServ.classed("active", true);
		resServ.select("rect").style("fill", function(d){ return getTypeColor(d.type); });
	}
}

function inputChanged(value){
	//
	var serv = d3.selectAll(".service");
	var contexts = d3.selectAll(".context");
	if (value.length > 0){
		var c = value.replace(/,/g, "|");
		console.log(c);
		re = new RegExp(c);
		contexts.classed("z", true);
	} else {
		re = new RegExp("^$");
		contexts.classed("z", false);
	}
	serv.classed("active", function(d){ return re.test(d.fullName); });
	//serv.select("rect").style("fill", function(d){ return re.test(d.fullName) ? getTypeColor(d.type) : null; });
	for (var key in context2services) {
		var services = context2services[key];
		var that = d3.selectAll("g.context").filter(function(d){return d.uuid === key;});
		createServices(that, services);
	}
}

function refreshServices(context, services){
	ctx_h = height(context[0][0].__data__) - 25; 
	ctx_w = width(context[0][0].__data__) - 5;

}

var layouts = d3.map();

var treemap = d3.layout.treemap()
	.round(false)
	.sticky(true)
	.value(function(d) { return re.test(d.fullName) ? 20 : 1; })
	.sort(function (a, b) {return d3.ascending(a.parent.children.indexOf(a), b.parent.children.indexOf(b));});

function createServices(context, services){
	//console.log(context[0][0].__data__.dx); 
	//console.log(services);
	var ctx = context[0][0].__data__;
	ctx_h = height(ctx) - 20; 
	ctx_w = width(ctx) - 0;
	
	//var treemap = layouts[ctx.uuid];
	if (!layouts.has(ctx.uuid)){
		layouts.set(ctx.uuid, d3.layout.treemap()
			.round(false)
			.sticky(true)
			.value(function(d) { return re.test(d.fullName) ? 50 : 1; })
			.sort(function (a, b) {return d3.ascending(a.parent.children.indexOf(a), b.parent.children.indexOf(b));}));
	}
	
	//console.log(layouts);
	
	var serviceNodes = layouts.get(ctx.uuid).nodes(reassemble(services));
	
	//console.log(serviceNodes);
	//serviceNodes.shift();
	var service = context
		.selectAll("g.service")
		.data(serviceNodes.filter(function(d){return !d.children;}), function(d){ return d.fullName; });
	
	var serviceEnter = service.enter()
		.append("svg:g")
		.classed("service", true)
		.classed("active", function(d){ return re.test(d.fullName); })
		.attr("transform", function(d) { return "translate(" + (d.y * ctx_w + 0) + ", " + (d.x * ctx_h + 20) + ")"; })
		.style("opacity", 0)
		.on("mouseover", onServiceMouseOver)
		.on("mousemove", onServiceMouseMove)
		.on("click", onServiceMouseClick)
		.on("mouseout", onServiceMouseOut);

	serviceEnter.append("svg:rect")
		.attr("width", function(d) { return d.dy * ctx_w; })
		.attr("height", function(d) { return d.dx * ctx_h; })
		.style("fill", function(d){ return getTypeColor(d.type); })
		//.style("stroke", function(d){ return (!d.children && re.test(d.fullName)) ? getTypeColor(d.type) : null; })
		;
		
	serviceEnter.filter(function(d){return !d.children;}).append("svg:text")
		.attr("transform", "translate(4, 4)")
		.text(function(d){return d.name.substring(0, d.dy * ctx_w / 4.5);});
		
	var serviceUpdate = service.transition()
		.duration(700)
		.style("opacity", 1)
		.attr("transform", function(d) { return "translate(" + (d.y * ctx_w + 0) + ", " + (d.x * ctx_h + 20) + ")"; })
		//.each("end", updateCoordinates);
	
	serviceUpdate.select("rect")
		.attr("width", function(d) { return d.dy * ctx_w; })
		.attr("height", function(d) { return d.dx * ctx_h - 0; });
		
	serviceUpdate.select("text")
		.style("opacity", function(d) { if (d.dx * ctx_h < 15){return 0;} else {return 1;}})
		.text(function(d){return d.name.substring(0, d.dy * ctx_w / 4.5 - 1);});
		
	//for (var s in service.exit()[0]){
		//console.log(s);
	//}
	
	service.exit()
		.transition()
		.duration(500)
		.each("end", function(d){console.log(d);})
		.style("opacity", 0)
		//.transition()
		.remove()
		;
}

function removeServices(context){
	//console.log(layouts);
	var ctx = context[0][0].__data__;
	/*
	var serviceNodes = layouts[ctx.uuid].nodes([]);
	
	console.log(serviceNodes);
	//serviceNodes.shift();
	var service = context
		.selectAll("g.service")
		.data(serviceNodes.filter(function(d){return !d.children;}), function(d){ return d.fullName; });
	var e = service.exit()
		.transition()
		.duration(500)
		//.each("end", function(d){console.log(d);})
		//.style("opacity", 0)
		.style("fill", "red")
		//.transition()
		//.remove()
		;
	console.log(e);*/
	//layouts[ctx.uuid] = undefined;
	//var index = layouts.indexOf(ctx.uuid);
	layouts.remove(ctx.uuid);
	
	context
		.selectAll("g.service")
		.transition()
		.duration(500)
		.style("opacity", 0)
		//.each("end", function(d){console.log(d);})
		.remove();
}