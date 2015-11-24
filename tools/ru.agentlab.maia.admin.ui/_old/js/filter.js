var expr = "";
var re = new RegExp("^$");
var input = d3.select("input").attr("value", expr);
console.log(input);
input.on('change', inputChanged, false);
input[0][0].onchange = (function(d){
inputChanged(d.target.value);
console.log(d);});
//inputChanged();