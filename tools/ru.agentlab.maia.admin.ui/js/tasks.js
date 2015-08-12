//	Layout variables
var width = 1200,
    height = 600,
	marginL = 100,
	marginT = 10,
	marginR = 100,
	marginB = 10;

//	Node variables
var startCircleR = 10,
	finishCircleR = 15,
	exeSectorH = 80,
	exeCircleY = exeSectorH / 2;

//	State variables
var stateWidth = 150,
	titleH = 30,
	paramH = 15;
	
var selectedNode = null;
var draggingNode = null;

var drag = d3.behavior.drag()
    .origin(function(d) { return d; })
    .on("drag", dragmove);
	
function getGrandParentCoords(node){
	var parent = node.parentNode;
	var grandparent = node.parentNode.parentNode;
	var parentTranslateX = d3.transform(parent.getAttribute('transform')).translate[0];
	var parentTranslateY = d3.transform(parent.getAttribute('transform')).translate[1];
	var grandParentTranslateX = d3.transform(grandparent.getAttribute('transform')).translate[0];
	var grandParentTranslateY = d3.transform(grandparent.getAttribute('transform')).translate[1];
	return [(parentTranslateX + grandParentTranslateX), (parentTranslateY + grandParentTranslateY)];
}	
function getParentCoords(node){
	var parent = node.parentNode;
	return [d3.transform(parent.getAttribute('transform')).translate[0], d3.transform(parent.getAttribute('transform')).translate[1]];
}
	
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
 *		NODE
 ***********************************/
	
var node = 
	svg.selectAll("g.node")
		.data([proto]).enter()
	.append("g")
		.classed("node", true)
		.attr("transform", "translate(" + marginL + ", " + marginT + ")");
		
var nodeBody = 
	node.append("rect")
		.attr("width", width - marginL - marginR)
		.attr("height", height - marginT - marginB);
		
var nodeLabel = node.append("text")
    .attr("x", (width - marginL - marginR) / 2)
    .attr("y", titleH / 2)
    .text(function(d) { return d.label; });
 	
var newLink = {};
var newData = {};
var drag3 = d3.behavior.drag()
    .origin(function(d) { return d; })
    .on("dragstart", function(d) {
		d3.event.sourceEvent.stopPropagation(); 
		draggingNode = d;
		//console.log(d3.select(".node"));
		//console.log(d.type);
		newData = {source:draggingNode, target:{x : d.x, y : d.y}};
		newLink = node
			.insert("path", "g")
			.data([newData])
			.classed("dataflow link new", true)
			.attr("d", diagonal)
			.style("stroke", function(s) { return getTypeColor(d.type);})
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
		//console.log(selectedNode);
	});

/***********************************
 *		NODE EXECUTION START
 ***********************************/
var nodeStart = node.append("g")
	.classed("execution start", true)
	.attr("transform", "translate(" + 0 + ", " + exeCircleY + ")")
	.each(function(d) {
		var coords = getGrandParentCoords(this);
		d.start = {
			x : 0, 
			y : exeCircleY
		}; 
	});

nodeStart.append("circle")
	.classed("start", true);

/***********************************
 *		NODE EXECUTION FINISH
 ***********************************/
var nodeFinish = node.append("g")
	.classed("execution finish", true)
	.attr("transform", "translate(" + (width - marginL - marginR) + ", " + exeCircleY + ")")
	.each(function(d) {
		var coords = getGrandParentCoords(this);
		d.finish = {
			x : (width - marginL - marginR), 
			y : exeCircleY
		}; 
	});
	
nodeFinish.append("circle")
	.classed("finish outer", true);
	
nodeFinish.append("circle")
	.classed("finish inner", true);
	
/***********************************
 *		NODE EXECUTION EXCEPTIONS
 ***********************************/
var nodeExceptionsContainer = 
	node.append("g")
		.classed("execution exceptions", true)
		.attr("transform", "translate(" + (width - marginL - marginR) + ", " + exeSectorH + ")");

var nodeException = nodeExceptionsContainer
	.selectAll("g.exception")
		.data(function(d) {return d.exceptions; })
		.enter()
	.append("g")
		.classed("exception", true)
		.attr("transform", function(d, i) {
			d.x = (width - marginL - marginR);
			d.y = (i * paramH) + exeSectorH;
			return "translate(0," + (i * paramH) + ")";
		});
		
nodeException.append("circle");	

nodeException.append("text")
	.text(function(d){return d.id;})
	.attr("x", 10);

/***********************************
 *		NODE DATA OUTPUTS
 ***********************************/
var nodeOutputs = node
	.append("g")
		.classed("data outputs", true)
		.attr("transform", function(d) { return "translate(" + (width - marginL - marginR) + ", " + (d.exceptions.length * paramH + exeSectorH + 10) + ")";});
	
var output = nodeOutputs
	.selectAll("g.output.parameter")
		.data(function(d){return d.outputs;})
		.enter()
	.append("g")
		.classed("output parameter", true)
		.attr("transform", function(d, i){
			d.x = width - marginL - marginR;
			d.y = getParentCoords(this)[1] + i * 20; 
			return "translate(0, " + i * 20 + ")";
		});

output.append("circle")
	.style("fill", function(d) { return getTypeColor(d.type);})
	.call(hover)
	.call(drag3);

output.append("text")
	.text(function(d){return d.id;})
	.attr("x", 10);
	
/***********************************
 *		NODE DATA INPUTS
 ***********************************/
var nodeInputs = 
	node.append("g")
		.classed("data inputs", true)
		.attr("transform", "translate(0, " + exeSectorH + ")");
	
var input = nodeInputs
	.selectAll("g.input.parameter")
		.data(function(d){return d.inputs;})
		.enter()
	.append("g")
		.classed("input parameter", true)
		.attr("transform", function(d, i){
			d.x = 0;
			d.y = exeSectorH + i * 20; 
			return "translate(0, " + i * 20 + ")";
		});

input.append("circle")
	.style("fill", function(d) { return getTypeColor(d.type);})
	.call(hover)
	.call(drag3);

input.append("text")
	.text(function(d){return d.id;})
	.attr("x", -10);
	
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
		return (titleH + (d.exceptions.length - 1) * paramH + d.outputs.length * paramH + d.inputs.length * paramH + 25); })
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
	
state.append("g")
		.classed("execution start", true)
		.attr("transform", "translate(0, " + titleH / 2 + ")" )
	.append("circle")
		.classed("start", true)
		.each(function(d) {
			var coords = getGrandParentCoords(this);
			d.start = {
				x : coords[0], 
				y : coords[1]
			}; 
		});
		
state.append("g")
		.classed("execution finish", true)
		.attr("transform", "translate(" + stateWidth + ", " + titleH / 2 + ")" )
	.append("circle")
		.classed("finish", true)
		.each(function(d) {
			var coords = getGrandParentCoords(this);
			d.finish = {
				x : coords[0], 
				y : coords[1]
			}; 
		});

var exception = state.append("g")
		.classed("execution exceptions", true)
		.attr("transform", function(d) { return "translate(" + stateWidth + "," + (titleH + 10) + ")"})
	.selectAll("g.exception")
		.data(function(d) {return d.exceptions; })
		.enter()
	.append("g")
		.classed("exception", true)
		.attr("transform", function(d, i) {
			var coords = getGrandParentCoords(this);
			d.x = 0 + coords[0];
			d.y = (i * paramH) + coords[1];
			return "translate(0," + (i * paramH) + ")";
		});
		
exception.append("circle");

exception.append("text")
	.text(function(d) { return d.id; })
	.attr("x", -10);

var outputGroup = state
	.append("g")
		.classed("data outputs", true)
		.attr("transform", function(d) { return "translate(" + stateWidth + "," + (titleH + (d.exceptions.length - 1) * paramH + 30) + ")"})
	.selectAll("g.output.parameter")
		.data(function(d) { return d.outputs; })
		.enter()
	.append("g")
		.classed("output parameter", true)
		.attr("transform", function(d, i) { 
			var coords = getGrandParentCoords(this);
			d.x = 0 + coords[0];
			d.y = (i * paramH) + coords[1];
			return "translate(0," + (i * paramH) + ")";
		});
	
outputGroup.append("circle")
	.style("fill", function(d) { return getTypeColor(d.type);})
	.call(hover)
	.call(drag3);

outputGroup.append("text")
	.text(function(d) { return d.id; })
	.attr("x", -10);
	
var inputGroup = state
	.append("g")
		.classed("data inputs", true)
		.attr("transform", function(d) { return "translate(0, " + (titleH + (d.exceptions.length - 1) * paramH + d.outputs.length * paramH + 30) + ")"})
	.selectAll("g.input.parameter")
		.data(function(d) {return d.inputs; })
		.enter()
	.append("g")
		.classed("input parameter", true)
		.attr("transform", function(d, i) {
			var coords = getGrandParentCoords(this);
			d.x = 0 + coords[0];
			d.y = (i * paramH) + coords[1];
			return "translate(0," + (i * paramH) + ")";
		});

inputGroup.append("circle")
	.style("fill", function(d) { return getTypeColor(d.type);})
	.call(hover)
	.call(drag3);
	
inputGroup.append("text")
	.text(function(d) { return d.id; })
	.attr("x", 10);

/***********************************
 *		LINKS
 ***********************************/
var workLinks = [];
	
var datalinks = [];
	
var diagonal = d3.svg.diagonal()
    .source(function(d) { return {"x":d.source.y, "y":d.source.x}; })            
    .target(function(d) { return {"x":d.target.y, "y":d.target.x}; })
    .projection(function(d) { return [d.y, d.x]; });

function find(array, id){
	for (var i = 0; i < array.length; i++) {
		if (array[i].id === id) return array[i];
	}
	console.log("NOT FOUND " + id + " in")
	console.log(array)
	return undefined;
}

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

function dragmoveParam(d){
	console.log(d3.event);
	d3.event.stopPropagation();
}

function dragmove(d) {
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
}

	function zoom() {
		node.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
	}

    // define the zoomListener which calls the zoom function on the "zoom" event constrained within the scaleExtents
    var zoomListener = d3.behavior.zoom().scaleExtent([0.1, 3]).on("zoom", zoom);
//svg.call(zoomListener);