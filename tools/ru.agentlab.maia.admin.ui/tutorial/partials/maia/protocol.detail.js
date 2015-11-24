maiaApp.controller('protocol-controller', function($scope) {
    
    $scope.protocol = {
		"uuid" : "2662a202-136f-4d45-a13f-25fedc0814e6",
		"label" : "FIPA Request",
		"participants" : [
			{
				"uuid" : "beba8402-6d10-4024-89d0-6d41539904b0",
				"label" : "Initiator"
			},
			{
				"uuid" : "58eb8cda-c457-4183-8bf6-1edba78fb842",
				"label" : "Participant1"
			},
			{
				"uuid" : "2490fe62-8d56-4f2b-869c-a33f3aac35d3",
				"label" : "Participant2"
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
				"target" : "2490fe62-8d56-4f2b-869c-a33f3aac35d3"
			}
		]
	};
    
    $scope.participationX = function(index){
    	return index * 220
    }
    
    $scope.getX = function(uuid){
    	var index = $scope.participationIndex(uuid);
    	var result = $scope.participationX(index) + 75
    	return result;
    }
    
    $scope.participationIndex = function(uuid){
    	for (var i = 0; i < $scope.protocol.participants.length; i++){
    		if ($scope.protocol.participants[i].uuid == uuid){
    			return i;
    		}
    	}
    }
    
});