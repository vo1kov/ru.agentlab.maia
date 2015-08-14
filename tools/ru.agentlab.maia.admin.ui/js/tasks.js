//	Layout variables
var width = 1200,
    height = 600,
	marginL = 100,
	marginT = 10,
	marginR = 100,
	marginB = 10;

//	Node variables
var nodeStartCircleR = 10,
	nodeFinishCircleR = 15,
	exeSectorH = 80,
	exeCircleY = exeSectorH / 2;

//	State variables
var stateWidth = 150,
	titleH = 30,
	paramH = 15;
	
var selectedNode = null;
var draggingNode = null;


/***********************************
 *		DRAG MOVE NODE
 ***********************************/
var drag = d3.behavior.drag()
    .origin(function(d) { return d; })
	.on("dragstart", function(d) {
		d3.event.sourceEvent.stopPropagation();
		d3.select(this).style("cursor", "move");
	})
    .on("drag", function(d) {
		d3.event.sourceEvent.stopPropagation();
		
		d.x += d3.event.dx;
		d.y += d3.event.dy;
		d.start.x += d3.event.dx;
		d.start.y += d3.event.dy;
		d.finish.x += d3.event.dx;
		d.finish.y += d3.event.dy;
		d3.select(this)
			.attr("transform", "translate(" + d.x + "," + d.y + ")")
		d3.select(this).selectAll("g.parameter")
			.each(function(d){
				d.x += d3.event.dx;
				d.y += d3.event.dy;
			})
		d3.select(this).selectAll("g.exception")
			.each(function(d){
				d.x += d3.event.dx;
				d.y += d3.event.dy;
			})
		node.selectAll("path.link").attr("d", diagonal);
	})
	.on("dragend", function(d){
		d3.event.sourceEvent.stopPropagation();
		d3.select(this).style("cursor", null);
	});

/***********************************
 *		DRAG ADD DATAFLOW LINK
 ***********************************/
var newLink = {};
var newData = {};
var drag3 = d3.behavior.drag()
    .origin(function(d) { return d; })
    .on("dragstart", function(d) {
		d3.event.sourceEvent.stopPropagation(); 
		draggingNode = d;
		selectedNode = null;
		newData = {source:draggingNode, target:{x : d.x, y : d.y}};
		newLink = node
			.insert("path", "g")
			.data([newData])
			.classed("dataflow link new", true)
			.attr("d", diagonal)
			.style("stroke", function(s) { return getTypeColor(d.type);})
			.call(hover)
			.call(drag2)
	})
    .on("drag", function(d) {
		d3.event.sourceEvent.stopPropagation();
		newData.target.x += d3.event.dx;
		newData.target.y += d3.event.dy;
		newLink.attr("d", diagonal);
	})
	.on("dragend", function(d) {
		d3.event.sourceEvent.stopPropagation();
		if (selectedNode){
			newData.target = selectedNode;
			newLink
				.data([newData])
				.classed("new", false)
				.attr("d", diagonal)
		} else {
			newLink.remove();
		}
		draggingNode = null;
	});

/***********************************
 *		DRAG ADD WORKFLOW LINK
 ***********************************/
var newWorkLink = {};
var newWorkData = {};
var drag4 = d3.behavior.drag()
    .origin(function(d) { return d; })
    .on("dragstart", function(d) {
		d3.event.sourceEvent.stopPropagation(); 
		draggingNode = d;
		selectedNode = null;
		newWorkData = {source:draggingNode, target:{x : d.x, y : d.y}};
		newWorkLink = node
			.insert("path", "g")
			.data([newWorkData])
			.classed("workflow link new", true)
			.attr("d", diagonal)
			.attr("marker-end", "url(#arrow)")
			.call(hover)
			.call(drag2)
	})
    .on("drag", function(d) {
		d3.event.sourceEvent.stopPropagation();
		newWorkData.target.x += d3.event.dx;
		newWorkData.target.y += d3.event.dy;
		newWorkLink.attr("d", diagonal);
	})
	.on("dragend", function(d) {
		d3.event.sourceEvent.stopPropagation();
		if (selectedNode){
			newWorkData.target = selectedNode;
			newWorkLink
				.data([newWorkData])
				.classed("new", false)
				.attr("d", diagonal)
		} else {
			newWorkLink.remove();
		}
		draggingNode = null;
	});
 
/***********************************
 *		DRAG REMOVE LINK
 ***********************************/
var delta = 0;
var drag2 = d3.behavior.drag()
    .origin(function(d) { return d; })
    .on("dragstart", function(d) { 
		delta = 0;
	})
    .on("drag", function(d) { 
		delta += d3.event.dx;
		delta += d3.event.dy;
	})
	.on("dragend", function(d) {
		if(Math.abs(delta) > 20){
			d3.select(this).remove();
		} 
		delta = 0;
	});

/***********************************
 *		SVG
 ***********************************/
var svg = d3.select("#body")
	.append("svg")
		.attr("width", width)
		.attr("height", height);

	svg.append("defs")
		.selectAll("marker")
			.data(["arrow"])
			.enter()
		.append("marker")
			.attr("id", function(d) { return d; })
			.attr("viewBox", "0 -5 10 10")
			.attr("refX", 10)
			.attr("refY", 0)
			.attr("markerWidth", 6)
			.attr("markerHeight", 4)
			.attr("orient", "auto")
			.style("fill", "rgb(32,32,32)")
		.append("path")
			.attr("d", "M0,-5L10,0L0,5");
			

/***********************************
 *		COMMON
 ***********************************/
	
function getOffset(elem){
	var offset = [0, 0];
	var sel = $(elem).parentsUntil( $(".node") );
	sel.each(function(index) {
		var translateString = $(this).attr("transform");
		var translate = d3.transform(translateString).translate;
		offset[0] += translate[0];
		offset[1] += translate[1];
	});
	return offset;
}

function find(array, id){
	for (var i = 0; i < array.length; i++) {
		if (array[i].id === id) return array[i];
	}
	console.log("NOT FOUND " + id + " in")
	console.log(array)
	return undefined;
}

function storeCoords(d, i){
	//console.log(i);
	var offset = getOffset(this);
	var local = [0, 0];
	d.x = offset[0] + local[0];
	d.y = offset[1] + local[1];
}

function storeCoords2(d, i){
	//console.log(i);
	var offset = getOffset(this);
	var local = [0, i * paramH];
	d.x = offset[0] + local[0];
	d.y = offset[1] + local[1];
}
	
/***********************************
 *		COMMON EXECUTION START
 ***********************************/
function updateStart(container, coords){
	var start = container.append("g")
		.datum(function(d) {
			return d.start;
		})
		.classed("execution start", true)
		.attr("transform", "translate(" + coords[0] + ", " + coords[1] + ")" );
	
	start.append("circle")
		.classed("start", true)
		.each(storeCoords)
		.call(hover)
		.call(drag4);
}

/***********************************
 *		COMMON EXECUTION FINISH
 ***********************************/
function updateFinish(container, coords){
	var finish = container.append("g")
		.datum(function(d){
			return d.finish;
		})
		.classed("execution finish", true)
		.attr("transform", "translate(" + coords[0] + ", " + coords[1]+ ")");
		
	finish.append("circle")
		.classed("finish outer", true)
		.each(storeCoords)
		.call(hover)
		.call(drag4);
		
	finish.append("circle")
		.classed("finish inner", true);
}

/***********************************
 *		COMMON EXECUTION EXCEPTIONS
 ***********************************/
function updateExceptions(container, isRoot, coords){
	var exceptions = container.append("g")
		.classed("execution exceptions", true)
		.attr("transform", function(d) { return "translate(" + coords(d)[0] + ", " + coords(d)[1] + ")";});
		
	var exception = exceptions
		.selectAll("g.exception")
			.data(function(d) {return d.exceptions; })
			.enter()
		.append("g")
			.classed("exception", true)
			.each(storeCoords2)
			.attr("transform", function(d, i) {
				return "translate(" + 0 + ", " + i * paramH + ")";
			});
			
	exception.append("circle")
		.call(hover)
		.call(drag4);	

	var exceptionText = exception.append("text")
		.text(function(d){return d.id;});
		
	if (isRoot){
		exceptionText.attr("x", 10);
	} else {
		exceptionText.attr("x", -10);
	}
}

/***********************************
 *		COMMON DATA OUTPUTS
 ***********************************/
function updateOutput(container, isRoot, coords){	
	var outputs = container.append("g")
		.classed("data outputs", true)
		.attr("transform", function(d) { return "translate(" + coords(d)[0] + ", " + coords(d)[1] + ")";});

	var output = outputs
		.selectAll("g.output.parameter")
			.data(function(d){return d.outputs;})
			.enter()
		.append("g")
			.classed("output parameter", true)
			.each(storeCoords2)
			.attr("transform", function(d, i) {
				return "translate(" + 0 + ", " + i * paramH + ")";
			});

	output.append("circle")
		.style("fill", function(d) { return getTypeColor(d.type);})
		.call(hover)
		.call(drag3);

	var outputText = output.append("text")
		.text(function(d){return d.id;});
	
	if (isRoot){
		outputText.attr("x", 10);
	} else {
		outputText.attr("x", -10);
	}
}

/***********************************
 *		COMMON DATA INPUTS
 ***********************************/
function updateInput(container, isRoot, coords){	
	var inputs = container.append("g")
		.classed("data inputs", true)
		.attr("transform", function(d) { return "translate(" + coords(d)[0] + ", " + coords(d)[1] + ")";});
	
	var input = inputs
		.selectAll("g.input.parameter")
			.data(function(d){return d.inputs;})
			.enter()
		.append("g")
			.classed("input parameter", true)
			.each(storeCoords2)
			.attr("transform", function(d, i) {
				return "translate(" + 0 + ", " + i * paramH + ")";
			});

	input.append("circle")
		.style("fill", function(d) { return getTypeColor(d.type);})
		.call(hover)
		.call(drag3);

	var inputText = input.append("text")
		.text(function(d){return d.label ? d.label : d.id;});
	
	if (isRoot){
		inputText.attr("x", -10);
	} else {
		inputText.attr("x", 10);
	}
}

/***********************************
 *		NODE
 ***********************************/
proto.start = {};
proto.finish = {};

var node = svg.selectAll("g.node")
		.data([proto]).enter()
	.append("g")
		.classed("node", true)
		.attr("transform", "translate(" + marginL + ", " + marginT + ")");
		
var nodeBody = node.append("rect")
		.attr("width", width - marginL - marginR)
		.attr("height", height - marginT - marginB);
		
var nodeLabel = node.append("text")
    .attr("x", (width - marginL - marginR) / 2)
    .attr("y", titleH / 2)
    .text(function(d) { return d.label; });

updateStart(node, [0, exeCircleY]);
updateFinish(node, [(width - marginL - marginR), exeCircleY]);
updateExceptions(node, true, function(d){
	return [(width - marginL - marginR), exeSectorH];
});
updateOutput(node, true, function(d){
	return [(width - marginL - marginR), (d.exceptions.length * paramH + exeSectorH + 10)];
});
updateInput(node, true, function(d){
	return [0, exeSectorH];
});

/***********************************
 *		NODE STATES
 ***********************************/
var state = node
	.selectAll(".state")
		.data(function(d){return proto.states;})
		.enter()
	.append("g")
		.classed("ready state", true)
		.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"})
		.call(drag)
		.each(function(d){d.start = {};d.finish = {};})
	.on("dblclick",function(d){ 
		console.log(d);
		d3.select(this).transition()
			.duration(700)
			.attr("transform", function(d) { return "translate(" + 0 + "," + 0 + ")"})
			.attr("class", "node")
			.select("rect")
				.attr("width", width - marginL - marginR)
				.attr("height", height - marginT - marginB);
	});

state.append("rect")
	.attr("width", function(d) { return stateWidth; })
	.attr("height", function(d) { 
		return (titleH + (d.exceptions.length - 1) * paramH + d.outputs.length * paramH + d.inputs.length * paramH + 25); 
	})
	.each(function(d){
		var parentTranslate = d3.transform(this.parentNode.getAttribute('transform')).translate;
		var x = parentTranslate[0];
		var y = parentTranslate[1];
		d.startX = x;
		d.startY = y + 15;
		d.finishX = x + parseFloat(this.getAttribute('width'));
		d.finishY = y + 15;
	});
		
state.append("text")
    .attr("x", stateWidth / 2)
    .attr("y", titleH / 2)
    .text(function(d) { return d.label; });
		
state.append("line")
	.attr("x1", 0 )
	.attr("y1", titleH )
	.attr("x2", stateWidth )
	.attr("y2", titleH );
	
state.append("line")
	.attr("x1", 0 )
	.attr("y1", function(d) { return (d.exceptions.length - 1) * paramH + titleH + 20; })
	.attr("x2", stateWidth )
	.attr("y2", function(d) { return (d.exceptions.length - 1) * paramH + titleH + 20; });
		
updateStart (state, [0, titleH / 2]);
updateFinish(state, [stateWidth, titleH / 2]);
updateExceptions(state, false, function(d){
	return [stateWidth, (titleH + 10)];
});
updateOutput(state, false, function(d){
	return [stateWidth, (titleH + (d.exceptions.length - 1) * paramH + 30)];
});
updateInput(state, false, function(d){
	return [0, (titleH + (d.exceptions.length - 1) * paramH + d.outputs.length * paramH + 30)];
});

/***********************************
 *		LINKS
 ***********************************/
var workLinks = [];	
var datalinks = [];
	
var diagonal = d3.svg.diagonal()
    .source(function(d) { return {"x":d.source.y, "y":d.source.x}; })            
    .target(function(d) { return {"x":d.target.y, "y":d.target.x}; })
    .projection(function(d) { return [d.y, d.x]; });

proto.workflow.forEach(function(d, i) {
	var fromId = d[0].split("#");
	var toId = d[1].split("#");
	if (fromId[0].length == 0 || fromId[0] === "this"){
		if (fromId[1] === "start"){
			var source = proto.start;
		} else {
			console.log("WRONG");
		}
	} else {
		var state = find(proto.states, fromId[0]);
		if (fromId[1] === "finish"){
			var source = state.finish;
		} else {
			var source = find(state.exceptions, fromId[1]);
			var type = "exception";
		}
	}
	source.fqn = d[0];
	if (toId[0].length == 0 || toId[0] === "this"){
		if (toId[1] === "finish"){
			var target = proto.finish;
		} else {
			var target = find(proto.exceptions, toId[1]);
		}
	} else {
		var state = find(proto.states, toId[0]);
		if (toId[1] === "start"){
			var target = state.start;
		} else {
			console.log("WRONG");
		}
	}
	target.fqn = d[1];
	workLinks.push({source : source, target : target, type : type});
});

proto.dataflow.forEach(function(d, i) {
	var fromId = d[0].split("#");
	var toId = d[1].split("#");
	if (fromId[0].length == 0 || fromId[0] === "this"){
		var source = find(proto.inputs, fromId[1]);
	} else {
		var state = find(proto.states, fromId[0]);
		var source = find(state.outputs, fromId[1]);
	}
	if (toId[0].length == 0 || toId[0] === "this"){
		var target = find(proto.outputs, toId[1]);
	} else {
		var state = find(proto.states, toId[0]);
		var target = find(state.inputs, toId[1]);
	}
	datalinks.push({source:source, target:target});
});

function prepare(proto){
	var result = jQuery.extend(true, {}, proto);
	result.start = {};
	result.finish = {};
}

function hover(d){
	d.on("mouseover", function(d) { 
		selectedNode = d;
		d3.select(this).classed("hover",true);
	})
	.on("mouseout", function(d) {
		selectedNode = null;
		d3.select(this).classed("hover",false);
	})
}

var workflowLink = node
	.selectAll(".workflow.link")
        .data(workLinks)
        .enter()
	.insert("path", "g")
		.classed("workflow link", true)
        .attr("d", diagonal)
		.each(function(d){
			if (d.type === "exception"){
				d3.select(this).classed("exception", true);
			}
		})
		.attr("marker-end", "url(#arrow)")
		.call(hover)
		.call(drag2);
	
var dataflowLink = node
	.selectAll(".dataflow.link")
        .data(datalinks)
		.enter()
	.insert("path", "g")
		.classed("dataflow link", true)
		.attr("d", diagonal)
		.style("stroke", function(d) { return getTypeColor(d.source.type);})
		.call(hover)
		.call(drag2);

function zoom() {
	node.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
}

// define the zoomListener which calls the zoom function on the "zoom" event constrained within the scaleExtents
var zoomListener = d3.behavior.zoom().scaleExtent([0.1, 3]).on("zoom", zoom);
//svg.call(zoomListener);