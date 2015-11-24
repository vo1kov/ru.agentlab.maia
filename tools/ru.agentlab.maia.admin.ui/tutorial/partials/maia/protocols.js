maiaApp.controller('protocols-controller', function($scope) {
    
    $scope.protocols = [
		{
			id : "e0e27887-674f-4a30-9bdd-7d2d880da60e",
			label : "FIPA Request Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "The FIPA Request Interaction Protocol (IP) allows one agent to request another to perform some action."

		},
		{
			id : "2a095da6-2854-441a-9505-195d857d8476",
			label : "FIPA Query Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "The FIPA Query Interaction Protocol (IP) allows one agent to request to perform some kind of action on another agent."
		},
		{
			id : "25f8905f-b84f-4b60-9b4e-5e6c4c60f709",
			label : "FIPA Request When Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "The FIPA Request When Interaction Protocol (IP) allows an agent to request that the receiver perform some action at the time a given precondition becomes true. This IP provides a framework for the request-when communicative act (see [FIPA00037])."
		},
		{
			id : "eef5ccc4-a59a-4416-8ecf-70f795810db4",
			label : "FIPA Contract Net Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "The FIPA Contract Net Interaction Protocol (IP) is a minor modification of the original contract net IP pattern[1] in that it adds rejection and confirmation communicative acts. In the contract net IP, one agent (the Initiator) takes the role of manager which wishes to have some task performed by one or more other agents (the Participants) and further wishes to optimise a function that characterizes the task. This characteristic is commonly expressed as the price, in some domain specific way, but could also be soonest time to completion, fair distribution of tasks, etc. For a given task, any number of the Participants may respond with a proposal; the rest must refuse. Negotiations then continue with the Participants that proposed."
		},
		{
			id : "d18de8e0-0dc2-489e-9817-7fe348c6638a",
			label : "FIPA Iterated Contract Net Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "The FIPA Iterated Contract Net Interaction Protocol (IP) is an extension of the basic FIPA Contract Net IP (see [FIPA00029]), but it differs by allowing multi-round iterative bidding."
		},
		{
			id : "ff1b4838-8b55-402e-831d-483ec863ede0",
			label : "FIPA English Auction Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "In the FIPA English Auction Interaction Protocol (IP), the auctioneer seeks to find the market price of a good by initially proposing a price below that of the supposed market value and then gradually raising the price. Each time the price is announced, the auctioneer waits to see if any buyers will signal their willingness to pay the proposed price. As soon as one buyer indicates that it will accept the price, the auctioneer issues a new call for bids with an incremented price. The auction continues until no buyers are prepared to pay the proposed price, at which point the auction ends. If the last price that was accepted by a buyer exceeds the auctioneer's (privately known) reservation price, the good is sold to that buyer for the agreed price. If the last accepted price is less than the reservation price, the good is not sold"
		},
		{
			id : "f5c2713a-77ad-4555-abe8-da5f0cf33e74",
			label : "FIPA Dutch Auction Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "In the FIPA Dutch Auction Interaction Protocol (IP), the auctioneer attempts to find the market price for a good by starting bidding at a price much higher than the expected market value, then progressively reducing the price until one of the buyers accepts the price. The rate of reduction of the price is up to the auctioneer and they usually have a reserve price below which not to go. If the auction reduces the price to the reserve price with no buyers, then the auction terminates."
		},
		{
			id : "e11c8eae-7210-47b9-82ae-e824f54f1b0c",
			label : "FIPA Brokering Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "The FIPA Brokering Interaction Protocol (IP) is designed to support brokerage interactions in mediated systems and in multi-agent systems, for example, [Finin97]."
		},
		{
			id : "5bf4b35e-0af1-4316-af2e-696effabed1c",
			label : "FIPA Recruiting Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "The FIPA Subscribe Interaction Protocol (IP) allows an agent to request a receiving agent to perform an action on subscription and subsequently when the referenced object changes."
		},
		{
			id : "7258a600-2365-4035-a9d3-a723de2336d6",
			label : "FIPA Propose Interaction Protocol",
			version : "1.0.0",
			participants : [
				{
					
				},
				{}
			],
			tags : [ "http://www.fipa.org/", "stadart", "remote" ],
			description : "The FIPA Propose Interaction Protocol (IP) allows an agent to propose to receiving agents that the initiator will do the actions described in the propose communicative act (see [FIPA00037]) when the receiving agent accepts the proposal."
		} ];
    
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