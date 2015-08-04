var tooltip = d3.select("body").append("div")
	.classed("tooltip", true)               
	.style("opacity", 0);

	
/*****************************************
 *
 *	Event listeners
 *
 *****************************************/ 

dispatch.on("context_hover_start.tooltip", function(context) {
	d3.select("#status").text(context.name);
	editTooltip(
		"<b>Value:	</b> " + context.name + "<br/>" + 
		"<b>Type:	</b> " + context.type);
	//showTooltip();
});

dispatch.on("context_hover_inprogress.tooltip", function(xx, yy) {
	//moveTooltip(xx, yy);
});

dispatch.on("context_hover_end.tooltip", function(context) {
	hideTooltip();
});
	
dispatch.on("service_hover_start.tooltip", function(service) {
	d3.select("#status").text(service.fullName);
	//showTooltip();
});

dispatch.on("service_hover_inprogress.tooltip", function(xx, yy) {
	//moveTooltip(xx, yy);
});

dispatch.on("service_hover_end.tooltip", function(context) {
	hideTooltip();
});

/*****************************************
 *
 *	Functions
 *
 *****************************************/ 
 
function showTooltip(){
	tooltip.transition()
		.duration(200)  
		//.delay(700)    
		.style("opacity", .7);
}
	
function editTooltip(text){
	tooltip.html(text);
}
function moveTooltip(xx, yy){
	tooltip
		.style("left", xx + "px")     
		.style("top",  yy + "px");
}

function hideTooltip(){
d3.select("#status").text("");
	tooltip.transition()
		.duration(200)
		//.delay(700)    
		.style("opacity", 0);
}