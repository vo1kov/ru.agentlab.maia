//	Layout variables
var width = 600,
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
 *		NODE
 ***********************************/

/*
var main = d3.select(".basic.segment")
	.append("div")
	.classed("ui two column stackable grid container", true);

var leftContainer = main
	.append("div")
	.classed("two wide column", true);
	
var content = main
	.append("div")
	.classed("fourteen wide column", true)

var palette = leftContainer
	.append("div")
	.classed("ui fluid left inverted vertical menu", true);

var group = palette.selectAll("div.header.item")
	.data([{}, {}, {}, {}, {}, {}, {}, {}, {}]).enter()
	.append("div")
	.text("test")
	.classed("header", true);

var item = group.selectAll("a.item")
	.data([{}, {}, {}, {}, {}, {}, {}, {}, {}]).enter()
	.append("div").classed("menu", true).append("a")
	.text("test")
	.classed("item", true);
*/
/***********************************
 *		SVG
 ***********************************/
var svg = d3.select(".basic.segment")
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





var proto = {
	"uuid" : "2662a202-136f-4d45-a13f-25fedc0814e6",
	"label" : "FIPA Request",
	"initiator" : {
		"uuid" : "beba8402-6d10-4024-89d0-6d41539904b0",
		"label" : "Initiator"
	},
	"participants" : [
		{
			"uuid" : "58eb8cda-c457-4183-8bf6-1edba78fb842",
			"label" : "Participant"
		},
		{
			"uuid" : "58eb8cda-c457-4183-8bf6-1edba78fb842",
			"label" : "Participant"
		}
	],
	"interactions" : [
		{
			"source" : "beba8402-6d10-4024-89d0-6d41539904b0",
			"target" : "58eb8cda-c457-4183-8bf6-1edba78fb842",
			"performative" : "request"
		},
		{
			"type" : "alternative",
			"childs" : [
				{"performative" : "agree"},
				{"performative" : "refuse"}
			],
			"source" : "58eb8cda-c457-4183-8bf6-1edba78fb842",
			"target" : "beba8402-6d10-4024-89d0-6d41539904b0"
		},
		{
			"type" : "alternative",
			"childs" : [
				{"performative" : "failure"},
				{"performative" : "inform-done"},
				{"performative" : "inform-result"}
			],
			"source" : "58eb8cda-c457-4183-8bf6-1edba78fb842",
			"target" : "beba8402-6d10-4024-89d0-6d41539904b0"
		}
	]
}


var participant = svg.selectAll("g.participant")
	.data(proto.participants).enter()
		.append("g");
		//.classed("participant");

var participantWidth = 150;
var participantGap = 300;
var participantHeight = 50;

var participantRect = participant.append("rect")
	.attr("x", function(d, i){return i*participantGap;})  
	.attr("y", 0)
	.attr("width", participantWidth)  
	.attr("height", participantHeight)
	.style("fill", "#2185d0")
	.style("stroke-width", 1)
	.style("stroke", "none");

var lineW = 50;
var lineH = 350;

var participantLineBack = participant.append("rect")
	.attr("x", function(d, i){return i*participantGap + participantWidth/2 - lineW/2;})  
	.attr("y", participantHeight)
	.attr("width", lineW)  
	.attr("height", lineH + 25)
	.style("fill", "lightgray")
	.style("stroke", "none")
	.style("cursor", "pointer");
    
var participantLabel = participant.append("text")
	.attr("x", function(d, i){return i*participantGap + participantWidth/2;}) 
    .attr("y", participantHeight / 2)
    .style("text-anchor", "middle")
    .style("alignment-baseline", "middle")
	.style("fill", "white")
    .text(function(d) { return d.label; });
    
var participantLine = participant.append("line")
	.attr("x1", function(d, i){return i*participantGap + participantWidth/2;})  
	.attr("y1", participantHeight)
	.attr("x2", function(d, i){return i*participantGap + participantWidth/2;})  
	.attr("y2", participantHeight + lineH)
	.style("stroke-width", 2)
	.style("stroke", "#2185d0")
	//.style("stroke-dasharray", "10,5")
	.style("fill", "none");

/********************
*
********************/

var interactions = svg.selectAll("g.interaction")
	.data(proto.interactions).enter()
		.append("g");
		//.classed("interaction");
    
var participantLine = participant.append("line")
	.attr("x1", participantWidth/2)  
	.attr("y1", 70)
	.attr("x2", participantGap + participantWidth/2)  
	.attr("y2", 70)
	.attr("marker-end", "url(#arrow)")
	.style("stroke-width", 3)
	.style("stroke", "#2185d0")
	.style("fill", "none");
    
var participantLine = participant.append("line")
	.attr("x2", participantWidth/2)  
	.attr("y1", 120)
	.attr("x1", participantGap + participantWidth/2)  
	.attr("y2", 120)
	.attr("marker-end", "url(#arrow)")
	.style("stroke-width", 3)
	.style("stroke", "#2185d0")
	.style("fill", "none");


/********************
*
********************/

function zoom() {
	node.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
}

// define the zoomListener which calls the zoom function on the "zoom" event constrained within the scaleExtents
var zoomListener = d3.behavior.zoom().scaleExtent([0.1, 3]).on("zoom", zoom);
//svg.call(zoomListener);