maiaApp.controller('behaviours-controller', function($scope) {
//	$scope.state = {};
	$scope.state_width = 150;
	$scope.state_height = 130;
	
	$scope.behaviour = {
			"uuid" : "64a2672e-4c90-4001-be82-d33860eec2be",
			"label" : "Zipato Authenticate Protocol",
			"type" : "ru.agentlab.maia.behaviour.sequential.SequentialBehaviour",
			"exceptions" : [
				{ "uuid" : "21bc06af-34ca-47d6-b1e9-745ea7182f56", "label" : "NullPointerException", "type" : "java.lang.NullPointerException" }
			],
			"inputs" : [
				{ "uuid" : "fb39c4f3-d68a-4fbc-9145-6de0f6c899ba", "label" : "login", "type" : "java.lang.String" },
				{ "uuid" : "c3b52306-3046-4a8f-8ac1-19a4032ac14b", "label" : "password", "type" : "java.lang.String" }
			],
			"outputs" : [
				{ "uuid" : "b71e5d2d-61ea-4751-bfd2-2ee59021dd54", "label" : "success", "type" : "java.lang.Boolean" }
			],
			"childs" : [
		  		{
					"x" : 200,
					"y" : 200,
		  			"uuid" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6",
		  			"label" : "Create Bootstrap",
		  			"type" : "ru.agentlab.maia.behaviour.sequential.SequentialBehaviour",
		  			"exceptions" : [
		  				{ "uuid" : "cc4172f6-518a-46fb-8aaf-6e8dc8377fbc", "label" : "NullPointerException", "type" : "java.lang.NullPointerException"}
		  			],
		  			"inputs" : [ 
		  				{ "uuid" : "f2def088-eb54-44fc-942e-8ec3ef441488", "label" : "login", "type" : "java.lang.String" },
		  				{ "uuid" : "df162a68-56c7-4658-99b9-d117a9d05fa6", "label" : "password", "type" : "java.lang.String" }
		  			],
		  			"outputs" : [ 
		  				{ "uuid" : "48d05021-0eeb-4961-aed0-ee2831f8341c", "label" : "bootstrap", "type" : "java.lang.Object" }
		  			]
		  		},
		  		{	
					"x" : 600,
					"y" : 300,
		  			"uuid" : "d39d002d-82f4-4280-ad8f-2a724ddcfca2",
		  			"label" : "Check Not Null",
		  			"type" : "ru.agentlab.maia.behaviour.sequential.SequentialBehaviour",
		  			"inputs" : [ 
		  				{ "uuid" : "4a8e80ea-5ac7-47e2-92d2-b0252d8f980a", "label" : "input", "type" : "java.lang.Object" }
		  			],
		  			"outputs" : [ 
		  				{ "uuid" : "063595cd-1b61-4c91-9dbf-9f9a250087be", "label" : "result", "type" : "java.lang.Boolean" }
		  			]
		  		}
		  	],
		  	"dataflow" : [
		  		["fb39c4f3-d68a-4fbc-9145-6de0f6c899ba", "f2def088-eb54-44fc-942e-8ec3ef441488"],
		  		["c3b52306-3046-4a8f-8ac1-19a4032ac14b", "df162a68-56c7-4658-99b9-d117a9d05fa6"],
		  		["48d05021-0eeb-4961-aed0-ee2831f8341c", "4a8e80ea-5ac7-47e2-92d2-b0252d8f980a"],
		  		["063595cd-1b61-4c91-9dbf-9f9a250087be", "b71e5d2d-61ea-4751-bfd2-2ee59021dd54"]
		  	]
		};
	
	function findChild(uuid){
		for (var i = 0; i < $scope.behaviour.childs.length; i++){
			if ($scope.behaviour.childs[i].uuid == uuid){
    			return $scope.behaviour.childs[i];
    		}
		}
		return null;
	}
	
	$scope.childHeight = function(uuid){
		var child = findChild(uuid);
		var result = 0;
		if (child){
			
			return 30 + child.exceptions.length * 15 + child.inputs.length * 15 + child.outputs.length * 15;
		}
		return result;
	}
	
//	for (var i = 0; i < $scope.behaviour.inputs.length; i++){
//		coordinates[$scope.behaviour.inputs[i].uuid] = {x : 0, y: (15 * i + 80)};
//	}
//	
//	for (var i = 0; i < $scope.behaviour.outputs.length; i++){
//		coordinates[$scope.behaviour.outputs[i].uuid] = {x : 900, y: (15 * i + 105)};
//	}
//	for (var i = 0; i < $scope.behaviour.childs.length; i++){
//		coordinates[$scope.behaviour.childs[i].uuid] = {x : 0, y: 100};
//	}
	
//	$scope.coordinates = function(uuid){
//		return coordinates[uuid];
//	}
	
    $scope.behaviour2 = {
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
    
    var colors = {};
    
    $scope.state_startX = function(uuid){
    	for (var i=0; i< $scope.behaviour.childs; i++){
    		var state = $scope.behaviour.childs[i];
    		if (state.id == uuid){
    			return state.x;
    		}
    	}
    	return null;
    }
    
    $scope.state_startX = function(uuid){
    	for (var i=0; i< $scope.behaviour.childs; i++){
    		var state = $scope.behaviour.childs[i];
    		if (state.id == uuid){
    			return state.y + 15;
    		}
    	}
    	return null;
    }
    
    $scope.getTypeColor = function(type) {
    	var color = colors[type];
    	if(typeof color != 'undefined'){
    		return color;
    	} else {
        	color = "#"+((1<<24)*Math.random()|0).toString(16);
			colors[type] = color;
			return color;
    	}
    };
    
    $scope.test = function(){
    	console.log("CLICK");
    	$scope.behaviour.childs[1].x += 10;
    };
    
});