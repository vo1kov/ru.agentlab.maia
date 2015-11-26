maiaApp.controller('behaviours-controller', function($scope) {
    
    $scope.behaviour = {
		"id" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol",
		"label" : "ZipatoAuthenticateProtocol",
		"exceptions" : [
			{ "id" : "NullPointerException", "type" : "java.lang.NullPointerException" }
		],
		"inputs" : [
			{ "id" : "login", 		"type" : "java.lang.String" },
			{ "id" : "password", 	"type" : "java.lang.String" },
			{ "id" : "eventLoop",	"type" : "io.netty.channel.EventLoopGroup" }, 
			{ "id" : "channel", 	"type" : "java.lang.Class<? extends io.netty.channel.Channel>" }, 
			{ "id" : "options", 	"type" : "java.util.Map<io.netty.channel.ChannelOption<java.lang.Object>, java.lang.Object>" }, 
			{ "id" : "handler", 	"type" : "io.netty.channel.ChannelHandler" }
		],
		"outputs" : [
			{ "id" : "success", "type" : "boolean" }
		],
		"states" : [
			{
				"x" : 200,
				"y" : 200,
				"id" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6",
				"label" : "Create Bootstrap",
				"ref" : "ru.beeline.iot.gateway.zipato.CreateBootstrapBehaviour",
				"exceptions" : [
					{ "id" : "NullPointerException", "type" : "java.lang.NullPointerException" }
				],
				"inputs" : [ 
					{ "id" : "eventLoop", 	"type" : "io.netty.channel.EventLoopGroup" }, 
					{ "id" : "channel", 	"type" : "java.lang.Class<? extends io.netty.channel.Channel>" }, 
					{ "id" : "options", 	"type" : "java.util.Map<io.netty.channel.ChannelOption<java.lang.Object>, java.lang.Object>" }, 
					{ "id" : "handler", 	"type" : "io.netty.channel.ChannelHandler" }
				],
				"outputs" : [ 
					{ "id" : "bootstrap", "type" : "io.netty.bootstrap.Bootstrap" }
				]
			},
			{	
				"x" : 500,
				"y" : 100,
				"id" : "2da4cfe4-9da7-4940-830d-bbed1e895568",
				"label" : "Check Not Null",
				"ref" : "ru.beeline.iot.CheckNotNull",
				"exceptions" : [],
				"inputs" : [ 
					{ "id" : "input", "type" : "io.netty.bootstrap.Bootstrap", "required" : true }
				],
				"outputs" : [ 
					{ "id" : "result", "type" : "boolean" }
				]
			},
			{	
				"x" : 600,
				"y" : 300,
				"id" : "test",
				"label" : "false",
				"ref" : "ru.beeline.iot.CheckNotNull",
				"exceptions" : [],
				"inputs" : [ ],
				"outputs" : [ 
					{ "id" : "result", "type" : "boolean" }
				]
			},
			{	
				"x" : 700,
				"y" : 200,
				"id" : "and",
				"label" : "And",
				"ref" : "ru.beeline.iot.CheckNotNull",
				"exceptions" : [],
				"inputs" : [
					{ "id" : "first", "type" : "boolean" },
					{ "id" : "second", "type" : "boolean" }
				],
				"outputs" : [ 
					{ "id" : "result", "type" : "boolean" }
				]
			}
		],
		"dataflow" : [
			["this#eventLoop", "719b2a8a-4119-453b-a39d-62e9ce2d6cc6#eventLoop"],
			["this#options", "719b2a8a-4119-453b-a39d-62e9ce2d6cc6#options"],
			["this#channel", "719b2a8a-4119-453b-a39d-62e9ce2d6cc6#channel"],
			["this#handler", "719b2a8a-4119-453b-a39d-62e9ce2d6cc6#handler"],
			["719b2a8a-4119-453b-a39d-62e9ce2d6cc6#bootstrap", "2da4cfe4-9da7-4940-830d-bbed1e895568#input"],
			["2da4cfe4-9da7-4940-830d-bbed1e895568#result", "this#success"],
			["test#result", "this#success"]
		],
		"workflow" : [
			["this#start", "719b2a8a-4119-453b-a39d-62e9ce2d6cc6#start"], 
			["719b2a8a-4119-453b-a39d-62e9ce2d6cc6#finish", "2da4cfe4-9da7-4940-830d-bbed1e895568#start"],
			["719b2a8a-4119-453b-a39d-62e9ce2d6cc6#NullPointerException", "test#start"],
			["2da4cfe4-9da7-4940-830d-bbed1e895568#finish", "this#finish"],
			["test#finish", "this#NullPointerException"]
		],
		"dataflow2" : [
			{
				"from" 	: { "node" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol", "parameter" : "eventLoop" },
				"to" 	: { "node" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6", "parameter" : "eventLoop" }
			},{
				"from" 	: { "node" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol", "parameter" : "options" },
				"to" 	: { "node" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6", "parameter" : "options" }
			},{
				"from" 	: { "node" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol", "parameter" : "channel" },
				"to" 	: { "node" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6", "parameter" : "channel" }
			},{
				"from" 	: { "node" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol", "parameter" : "handler" },
				"to" 	: { "node" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6", "parameter" : "handler" }
			},{
				"from" 	: { "node" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6", "parameter" : "bootstrap" },
				"to" 	: { "node" : "2da4cfe4-9da7-4940-830d-bbed1e895568", "parameter" : "input" }
			},{
				"from" 	: { "node" : "2da4cfe4-9da7-4940-830d-bbed1e895568", "parameter" : "result" },
				"to" 	: { "node" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol", "parameter" : "success" }
			},{
				"from" 	: { "node" : "test", "parameter" : "result" },
				"to" 	: { "node" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol", "parameter" : "success" }
			}
		],
		"workflow2" : [
			{
				"from" 	: { "node" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol" },
				"to" 	: { "node" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6" }
			},{
				"from" 	: { "node" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6" },
				"to" 	: { "node" : "2da4cfe4-9da7-4940-830d-bbed1e895568" }
			},{
				"from" 	: { "node" : "2da4cfe4-9da7-4940-830d-bbed1e895568", },
				"to" 	: { "node" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol" }
			},{
				"from" 	: { "node" : "test" },
				"to" 	: { "node" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol", "exception" : "NullPointerException" }
			},{
				"from" 	: { "node" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6", "exception" : "NullPointerException" },
				"to" 	: { "node" : "test" }
			}
		]
	};
    
    var dict = {};
    var hues = [];
    
    $scope.getTypeColor = function(type) {
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
    };
    
});