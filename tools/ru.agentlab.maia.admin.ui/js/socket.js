var socket = new WebSocket("ws://localhost:9091/websocket");

socket.onopen = function() {
	socket.send(JSON.stringify({"command" : "context-list"}));
	socket.send(JSON.stringify({"command" : "bundles"}));
	socket.send(JSON.stringify({"command" : "bundles-subscribe"}));
};

socket.onclose = function(event) {
	if (event.wasClean) {
		alert('Соединение закрыто чисто');
	} else {
		alert('Обрыв соединения'); // например, "убит" процесс сервера
	}
	alert('Код: ' + event.code + ' причина: ' + event.reason);
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
	alert("Ошибка " + error.message);
};