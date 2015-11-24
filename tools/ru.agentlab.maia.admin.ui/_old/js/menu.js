var menu = {
	"items" : [ {
			"label" : "Clouds",
			"href" : "../ecosystem/clouds.html"
		}
	]
}

var sidebar = d3.select(".sidebar.menu")
var logo = sidebar.append("div").classed("ui basic segment", true)
	.append("img").classed("ui centered tiny circular image", true).attr("src", "images/maya-calendar.jpg")