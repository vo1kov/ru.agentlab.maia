maiaApp.controller('behaviours-controller', function($scope) {

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
		  				{ "uuid" : "cc4172f6-518a-46fb-8aaf-6e8dc8377fbc", "label" : "NullPointerException", "type" : "java.lang.NullPointerException"},
		  				{ "uuid" : "cc4172f6-518a-46fb-8aaf-6e8dc837ssss", "label" : "NullPointerException", "type" : "java.lang.NullPointerException"}
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
	
	function findChildInput(uuid){
		for (var i = 0; i < $scope.behaviour.childs.length; i++){
			var child = $scope.behaviour.childs[i];
			for (var j = 0; j < child.inputs.length; j++){
				var input = child.inputs[j]
				if (input.uuid == uuid){
					return input;
				}
			}
		}
		return null;
	}
	
	$scope.childSeparatorVisible = function(uuid){
		var child = findChild(uuid);
		if (child){
			return child.exceptions
		}
	}
	
	$scope.childSeparatorY = function(uuid){
		var child = findChild(uuid);
		if (child && child.exceptions){
			return (child.exceptions.length - 1) * 15 + 50;
		}
		return  
	}
	
	$scope.childHeight = function(uuid){
		var child = findChild(uuid);
		var result = 30;
		if (child){
			if (child.exceptions){
				result += 10;
				result += (child.exceptions.length - 1) * 15;
				result += 10;
			}
			result += 10;
			if (child.inputs){
				result += child.inputs.length * 15;
			}
			if (child.outputs){
				result += child.outputs.length * 15;
			}
		}
		return result;
	}
	
    var colors = {};
    
    $scope.stateInputY = function(uuid, index){
    	var child = findChild(uuid);
    	var result = 30;
		if (child){
			if (child.exceptions){
				result += 10;
				result += (child.exceptions.length - 1) * 15;
				result += 10;
			}
			result += 10;
			if (child.outputs){
				result += child.outputs.length * 15;
			}
			result += index * 15;
		}
		return result;
    }
    
    $scope.stateOutputY = function(uuid, index){
    	var child = findChild(uuid);
    	var result = 30;
		if (child){
			if (child.exceptions){
				result += 10;
				result += (child.exceptions.length - 1) * 15;
				result += 10;
			}
			result += 10;
			result += index * 15;
		}
		return result;
    }
    
    $scope.stateExceptionY = function(uuid, index){
    	var child = findChild(uuid);
    	var result = 30;
		if (child){
			result += 10;
			result += index * 15;
		}
		return result;
    }
    
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
    
    $scope.addInput = function(){
    	if(!$scope.behaviour.childs[1].inputs){
    		$scope.behaviour.childs[1].inputs = [];
    	}
    	$scope.behaviour.childs[1].inputs.push({label:"test"});// += 10;
    };
    $scope.addOutput = function(){
    	if(!$scope.behaviour.childs[1].outputs){
    		$scope.behaviour.childs[1].outputs = [];
    	}
    	$scope.behaviour.childs[1].outputs.push({label:"test"});// += 10;
    };
    $scope.addException = function(){
    	if(!$scope.behaviour.childs[1].exceptions){
    		$scope.behaviour.childs[1].exceptions = [];
    	}
    	$scope.behaviour.childs[1].exceptions.push({label:"test"});// += 10;
    };
    
});