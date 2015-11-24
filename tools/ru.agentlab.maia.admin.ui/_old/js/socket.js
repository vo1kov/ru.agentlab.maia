var socket = new WebSocket("ws://localhost:9091/websocket");

socket.onopen = function() {
	socket.send(JSON.stringify({"command" : "context-list"}));
	socket.send(JSON.stringify({"command" : "bundles"}));
	socket.send(JSON.stringify({"command" : "bundles-subscribe"}));
};

socket.onclose = function(event) {
	if (event.wasClean) {
		//alert('Ð¡Ð¾ÐµÐ´Ð¸Ð½ÐµÐ½Ð¸Ðµ Ð·Ð°ÐºÑ€Ñ‹Ñ‚Ð¾ Ñ‡Ð¸Ñ�Ñ‚Ð¾');
	} else {
		//alert('ÐžÐ±Ñ€Ñ‹Ð² Ñ�Ð¾ÐµÐ´Ð¸Ð½ÐµÐ½Ð¸Ñ�'); // Ð½Ð°Ð¿Ñ€Ð¸Ð¼ÐµÑ€, "ÑƒÐ±Ð¸Ñ‚" Ð¿Ñ€Ð¾Ñ†ÐµÑ�Ñ� Ñ�ÐµÑ€Ð²ÐµÑ€Ð°
	}
	//alert('ÐšÐ¾Ð´: ' + event.code + ' Ð¿Ñ€Ð¸Ñ‡Ð¸Ð½Ð°: ' + event.reason);
};

socket.onmessage = function(event) {
	var data = JSON.parse(event.data);
	switch (data.command) {
		case "context-list" : 
			dispatch.context_load(data.content, data.parameters);
			break;
		case "services" : 
			var context = {};
			for (var i = 0; i < data.parameters.length; i++){
				if (data.parameters[i].context){
					context = data.parameters[i].context;
					break;
				}
			}
			dispatch.services_load_end(context, data.content);
			//maia.dispatch.services.context_load(data.content, data.parameters);
			break;
		case "bundles" : 
			console.log(data);
			updateBundles(data.content);
			break;
		case "bundles-subscribe" :
			console.log(data);
			dispatch.bundle_update(data.content);
		default :
			break;
	}
	//maia.dispatch.socket.response(data.content, data.command, data.parameters);
};

socket.onerror = function(error) {
	alert("ÐžÑˆÐ¸Ð±ÐºÐ° " + error.message);
};