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
	titleH = 40,
	paramH = 15;

var drag = d3.behavior.drag()
    .origin(function(d) { return d; })
    .on("drag", dragmove);

var dragParam = d3.behavior.drag()
    .origin(function(d) { return d; })
    .on("drag", function(s){console.log(s);});
	
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
	
/***********************************
 *		NODE INPUTS
 ***********************************/
var inputs = 
	node.append("g")
		.attr("transform", "translate(0, " + exeSectorH + ")");
	
var input = 
	inputs.selectAll("g.input")
		.data(function(d){return d.inputs;})
		.enter()
	.append("g")
		.classed("input", true)
		.classed("parameter", true)
		.attr("transform", function(d, i){
			d.x = 0;
			d.y = exeSectorH + i * 20; 
			return "translate(0, " + i * 20 + ")";
		});

	input.append("circle")
		.style("fill", function(d) { return getTypeColor(d.type);});

	input.append("text")
		.text(function(d){return d.id;})
		.classed("left aligned", true)
		.attr("transform", function(d, i){return "translate(-10, 0)";});

/***********************************
 *		NODE OUTPUTS
 ***********************************/
var outputs = node
	.append("g")
		.attr("transform", "translate(" + (width - marginL - marginR) + ", " + exeSectorH + ")");
	
var output = outputs
	.selectAll("g.output")
		.data(function(d){return d.outputs;})
		.enter()
	.append("g")
		.classed("output parameter", true)
		.attr("transform", function(d, i){
			d.x = width - marginL - marginR;
			d.y = 80 + i * 20; 
			return "translate(0, " + i * 20 + ")";
		});

output.append("circle")
	.style("fill", function(d) { return getTypeColor(d.type);});;

output.append("text")
	.text(function(d){return d.id;})
	.classed("right aligned", true)
	.attr("transform", function(d, i){return "translate(10, 0)";});

/***********************************
 *		START CIRCLE
 ***********************************/
function drawCircle(node){
	node.attr("r", startCircleR)
	.attr("cy", exeCircleY)
	.style("fill", "rgb(32,32,32)");
}

node.append("circle")
	.call(drawCircle);

/***********************************
 *		FINISH CIRCLE
 ***********************************/
node.append("circle")
	.attr("r", finishCircleR)
	.style("fill", "lightgray")
	.style("stroke", "rgb(32,32,32)")
	.style("stroke-width", "2px")
	.attr("cx", width - marginL - marginR)
	.attr("cy", exeCircleY);
	
node.append("circle")
	.call(drawCircle)
	.attr("cx", width - marginL - marginR);
	
/***********************************
 *		STATES
 ***********************************/
var state = node
	.selectAll(".state")
		.data(function(d){return proto.states;})
		.enter()
	.append("g")
		.classed("ready state", true)
		.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"})
		.call(drag);
	
function find(array, value) {
	for (var i = 0; i < array.length; i++) {
		if (array[i].id == value) return array[i];
		}
	return undefined;
}

var rect = state
	.append("rect")
		.attr("width", function(d) { return stateWidth; })
		.attr("height", function(d) { return d.inputs.length * paramH + titleH + d.outputs.length * paramH; })
		.each(function(d){
			var parentTranslate = d3.transform(this.parentNode.getAttribute('transform')).translate;
			var x = parentTranslate[0];
			var y = parentTranslate[1];
			d.startX = x;
			d.startY = y + 15;
			d.finishX = x + parseFloat(this.getAttribute('width'));
			d.finishY = y + 15;
		});
		
var stateLabel = state.append("text")
    .attr("x", stateWidth / 2)
    .attr("y", 15)
    .text(function(d) { return d.label; });

var outputContainer = state.append("g")
	.attr("transform", function(d) { return "translate(" + stateWidth + "," + titleH + ")"});
	
var inputContainer = state.append("g")
	.attr("transform", 
	function(d) {
		return "translate(0, " + (d.outputs.length * paramH + titleH) + ")"}
	);	
var inputGroup = inputContainer
	.selectAll("g.input.parameter")
		.data(function(d) {return d.inputs; })
		.enter()
	.append("g")
		.classed("input parameter", true)
		.attr("transform", function(d, i) {
			var parentTranslateX = d3.transform(this.parentNode.getAttribute('transform')).translate[0];
			var parentTranslateY = d3.transform(this.parentNode.getAttribute('transform')).translate[1];
			var grandParentTranslateX = d3.transform(this.parentNode.parentNode.getAttribute('transform')).translate[0];
			var grandParentTranslateY = d3.transform(this.parentNode.parentNode.getAttribute('transform')).translate[1];
			d.x = 0 + parentTranslateX + grandParentTranslateX;
			d.y = (i * paramH) + parentTranslateY + grandParentTranslateY;
			return "translate(0," + (i * paramH) + ")";
		});

var outputGroup = outputContainer
	.selectAll("g.output.parameter")
		.data(function(d) { return d.outputs; })
		.enter()
	.append("g")
		.classed("output parameter", true)
		.attr("transform", function(d, i) { 
			var parentTranslateX = d3.transform(this.parentNode.getAttribute('transform')).translate[0];
			var parentTranslateY = d3.transform(this.parentNode.getAttribute('transform')).translate[1];
			var grandParentTranslateX = d3.transform(this.parentNode.parentNode.getAttribute('transform')).translate[0];
			var grandParentTranslateY = d3.transform(this.parentNode.parentNode.getAttribute('transform')).translate[1];
			d.x = 0 + parentTranslateX + grandParentTranslateX;
			d.y = (i * paramH) + parentTranslateY + grandParentTranslateY;
			return "translate(0," + (i * paramH) + ")";
		});

var inputCircle = inputGroup.append("circle")
	.style("fill", function(d) { return getTypeColor(d.type);})
    .call(dragParam);
	
var inputText = inputGroup.append("text")
	.text(function(d) { return d.id; })
	.classed("right aligned", true)
	.attr("x", 10);
	
var outputCircle = outputGroup.append("circle")
	.style("fill", function(d) { return getTypeColor(d.type);});

var outputText = outputGroup.append("text")
	.text(function(d) { return d.id; })
	.classed("left aligned", true)
	.attr("x", -10);


/***********************************
 *		LINKS
 ***********************************/
var links = [];

var workflowLinkGenerator = d3.svg.diagonal()
    .source(function(d) { return {"x":d.source.finishY, "y":d.source.finishX}; })            
    .target(function(d) { return {"x":d.target.startY, "y":d.target.startX}; })
    .projection(function(d) { return [d.y, d.x]; });

function findState(id){
	for(var i = 0; i < proto.states.length; i++){
		if(proto.states[i].id === id){
			return proto.states[i];
		}
	}
}

proto.workflow.forEach(function(d, i) {
	var fromID = d[0];
	var toID = d[1];
	if (fromID != null){
		var from = findState(fromID);
	} else {
		var from = {finishX : startCircleR, finishY : exeCircleY};
	}
	if (toID != null){
		var to = findState(toID);
	} else {
		var to = {startX : (width -marginL - marginR - finishCircleR), startY : exeCircleY};
	}
	links.push({source:from, target:to});
});

console.log(links);

var workflowLink = node
	.selectAll(".workflow.link")
        .data(links)
        .enter()
	.insert("path", ":first-child")
		.classed("workflow link", true)
        .attr("d", workflowLinkGenerator)
    .attr("marker-end", "url(#arrow)");
	

var dataflowLinkGenerator = d3.svg.diagonal()
    .source(function(d) { return {"x":d.source.y, "y":d.source.x}; })            
    .target(function(d) { return {"x":d.target.y, "y":d.target.x}; })
    .projection(function(d) { return [d.y, d.x]; });
	
var datalinks = [];

function findState2(arr, id){
	for(var i = 0; i < arr.length; i++){
		if(arr[i].id === id){
			return arr[i];
		}
	}
}

function parse(str){
	var split = str.split("#");
	var first = split[0];
	var second = split[1];
	if (!second){
		var param = findState2(proto.inputs, first);
		if(!param){
			var param = findState2(proto.outputs, first);
		}
		return param;
	} else {
		var state = findState2(proto.states, first);
		var param = findState2(state.inputs, second);
		if(!param){
			var param = findState2(state.outputs, second);
		}
		return param;
	}
}

proto.dataflow.forEach(function(d, i) {
	datalinks.push({source:parse(d[0]), target:parse(d[1])});
});

var dataflowLink = node
	.selectAll(".dataflow.link")
        .data(datalinks)
		.enter()
	.insert("path", ":first-child")
		.classed("dataflow link", true)
		.attr("d", dataflowLinkGenerator)
		.style("stroke", function(d) { return getTypeColor(d.source.type);});

var newLink = {};

function dragstartParam(d){
	console.log(d);
	newLink = node.select(".linkNew")
        .data([{source:{finishX : d.startX, finishY : d.startY}, target:{startX : d.startX, startY : d.startY}}])
        .enter().append("path")
		.classed("linkNew", true)
        .attr("d", workflowLinkGenerator)
		.style("stroke", function(d) { return getTypeColor(d.source.type);})
    //.attr("marker-end", "url(#arrow)")
	;
}

function dragmoveParam(d){
	console.log(d3.event);
	d3.event.stopPropagation();
}

function dragmove(d) {
            d3.event.sourceEvent.stopPropagation();
	var deltaX = d3.event.x - d.x;
	var deltaY = d3.event.y - d.y;
	
	d.x += d3.event.dx;
	d.y += d3.event.dy;
	d.startX += d3.event.dx;
	d.startY += d3.event.dy;
	d.finishX += d3.event.dx;
	d.finishY += d3.event.dy;
	
	d3.select(this)
		.attr("transform", "translate(" + d.x + "," + d.y + ")")
	
	d3.select(this).selectAll("g.parameter")
		.each(function(d){
			d.x += d3.event.dx;
			d.y += d3.event.dy;
		})
		
	workflowLink.attr("d", workflowLinkGenerator);
	dataflowLink.attr("d", dataflowLinkGenerator);
}

	function zoom() {
		node.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
	}

    // define the zoomListener which calls the zoom function on the "zoom" event constrained within the scaleExtents
    var zoomListener = d3.behavior.zoom().scaleExtent([0.1, 3]).on("zoom", zoom);
//svg.call(zoomListener);