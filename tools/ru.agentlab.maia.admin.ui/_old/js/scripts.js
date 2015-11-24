var dict = {};
var hues = [];

if (!Array.prototype.indexOf) {
	Array.prototype.indexOf = function (obj, fromIndex) {
		if (fromIndex == null) {
			fromIndex = 0;
		} else if (fromIndex < 0) {
			fromIndex = Math.max(0, this.length + fromIndex);
		}
		for (var i = fromIndex, j = this.length; i < j; i++) {
			if (this[i] === obj)
				return i;
		}
		return -1;
	};
}

function getTypeColor(type) {
	var color = dict[type];
	
	if(typeof color != 'undefined'){
		return color;
	} else {
		var hue = Math.floor(Math.random()*360);
		if (dict.length <= 360 && hues.indexOf(hue) > 0){
			return getTypeColor(type);
		} else {
			hues.push(hue);
			color = d3.hsl(hue, 0.7, 0.4);
			dict[type] = color;
			return color;
		}
	}
}