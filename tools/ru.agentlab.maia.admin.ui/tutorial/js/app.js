var maiaApp = angular.module('maiaApp', ['ui.router']);

maiaApp.config(function($stateProvider, $urlRouterProvider) {
    
    $urlRouterProvider.otherwise('/home');
    
    $stateProvider

	    .state('root', {
	        url: '/home',
	        views: {
	        	
	            '': { 
	            	templateUrl: 'partials/root.container.html',
	            	controller: function($scope) {
	    	            $scope.dogs = ['Bernese', 'Husky', 'Goldendoodle'];
	    	        }
	            },
	
	            'menu@': { 
	            	templateUrl: 'partials/root.menu.html',
               		controller: 'menu-controller'
	            },
	
	        }
	    })
	    
	    .state('root.home', {
	        url: '/home',
	        templateUrl: 'partials/partial-home.html'
	    })
	
	    .state('root.home.list', {
	        url: '/list',
	        templateUrl: 'partials/partial-home-list.html',
	        controller: function($scope) {
	            $scope.dogs = ['Bernese', 'Husky', 'Goldendoodle'];
	        }
	    })
	    
	    .state('root.ecosystem', {
	        url: '^/ecosystem',
	        template: '<div ui-view/>'
	    })
	    
	    .state('root.ecosystem.groups', {
	        url: '/groups',
	        templateUrl: 'partials/ecosystem/repositories.html',
       		controller: 'repositories-controller'
	    })
	    
	    .state('root.maia', {
	        url: '^/maia',
	        template: '<div ui-view/>'
	    })
	    
	    .state('root.maia.agents', {
	        url: '/agents',
	        templateUrl: 'partials/maia/agents.html',
       		controller: 'agents-controller'
	    })
	    
	    .state('root.osgi', {
	        url: '^/osgi',
	        template: '<div ui-view/>'
	    })
	
	    .state('root.osgi.bundles', {
	        url: '/bundles',
        	templateUrl: 'partials/osgi/bundles.html'
	    })
	
	    .state('root.osgi.services', {
	        url: '/services',
        	templateUrl: 'partials/osgi/services.html'
	    })
	
	    .state('root.osgi.statistic', {
	        url: '/statistic',
        	templateUrl: 'partials/osgi/statistic.html'
	    })
	    
	    .state('root.jvm', {
	        url: '^/jvm',
	        template: '<div ui-view/>'
	    })
	
	    .state('root.jvm.threads', {
	        url: '/threads',
        	templateUrl: 'partials/jvm/threads.html'
	    })
	
	    .state('root.jvm.statistic', {
	        url: '/statistic',
        	templateUrl: 'partials/jvm/statistic.html',
           	controller: 'jvm-info-controller'
	    })
	    
	    .state('root.os', {
	        url: '^/os',
	        template: '<div ui-view/>'
	    })
	
	    .state('root.os.processes', {
	        url: '/processes',
        	templateUrl: 'partials/os/processes.html'
	    })
	
	    .state('root.os.statistic', {
	        url: '/statistic',
        	templateUrl: 'partials/os/statistic.html',
       		controller: 'osgi-info-controller'
	    });
        
});

maiaApp.controller('repositories-controller', function($scope) {
    
    $scope.repositories = [
		{
			label : "Beeline Protocols Repository",
			address : "http://www.protocols.iob.beeline.ru:8080/",
			protocols : [
				{},{},{},{},{},{},{},{},{},{},{}
			],
			tags : [ "http://www.fipa.org/" ],
			description : "The FIPA Request Interaction Protocol (IP) allows one agent to request another to perform some action."

		},
		{
			label : "Some Protocols Repository",
			address : "http://www.protocols.example.ru:8080/",
			protocols : [
				{},{},{},{},{},{},{}
			],
			tags : [ "http://www.fipa.org/", "stadart", "remote" ],
			description : "The FIPA Propose Interaction Protocol (IP) allows an agent to propose to receiving agents that the initiator will do the actions described in the propose communicative act (see [FIPA00037]) when the receiving agent accepts the proposal."
		} ];
    
});

maiaApp.controller('osgi-info-controller', function($scope) {
    
    $scope.os = {
		"info" : {
			"name" : "Windows8",
			"architecture" : "x86_64",
			"version" : "8.1"
		},
		"variables" : {
			"TEMP" : "%USERPROFILE%\AppData\Local\Temp",
			"OS" : "Windows_NT",
			"OSe" : "Windows_NT",
			"OSw" : "Windows_NT",
			"OSws" : "Windows_NT"
		}
	};
    
});

maiaApp.controller('jvm-info-controller', function($scope) {
    
    $scope.jvm = {
		"info" : {
			"vendor" : "Oracle Corporation",
			"version" : "1.8.0_20"
		},
		"variables" : {
			"TEMP" : "%USERPROFILE%\AppData\Local\Temp",
			"ssss" : "Windows_NT",
			"OSws" : "Windows_NT"
		}
	};
    
});

maiaApp.controller('agents-controller', function($scope) {
    
    $scope.agents = [
		{
			id : "e0e27887-674f-4a30-9bdd-7d2d880da60e",
			label : "Lamp1",
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
			label : "Lamp2",
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
    
});


maiaApp.controller('menu-controller', ['$scope', '$state', function ($scope, $state) { 
	$scope.$state = $state;
    $scope.bread = [
		"Home", "Ecosystem"
	];
	
	$scope.current = "Clouds";
	
	$scope.main = "tesssst";
	
	$scope.menu = [{
			"name": "Ecosystem",
			"icon" : "cloud",
	    	"items" : [{
	    			"label" : "Clouds",
	    			"href" : "#/ecosystem/clouds.html",
	    			"state" : "root.ecosystem.clouds"
	    		},{
	    			"label" : "Agent Group Repositories",
	    			"href" : "#/ecosystem/groups.html",
	    			"state" : "root.ecosystem.groups"
	    		},{
	    			"label" : "Protocol Repositories",
	    			"href" : "#/ecosystem/protocols.html",
	    			"state" : "root.ecosystem.protocols"
	    		},{
	    			"label" : "Ontology Repositories",
	    			"href" : "#/ecosystem/ontologies.html",
	    			"state" : "root.ecosystem.ontologies"
	    		},{
	    			"label" : "P2 Repositories",
	    			"href" : "#/ecosystem/bundles.html",
	    			"state" : "root.ecosystem.p2"
	    		}]
		},{
			"name": "MAS",
			"icon" : "user",
	    	"items" : [{
	    			"label" : "Peers",
	    			"href" : "#/maia/peers.html",
	    			"state" : "root.maia.peers"
	    		},{
	    			"label" : "Containers",
	    			"href" : "#/maia/clouds.html",
	    			"state" : "root.maia.containers"
	    		},{
	    			"label" : "Agents",
	    			"href" : "#/maia/agents.html",
	    			"state" : "root.maia.agents"
	    		},{
	    			"label" : "Behaviours",
	    			"href" : "#/maia/behaviours.html",
	    			"state" : "root.maia.behaviours"
	    		},{
	    			"label" : "Groups",
	    			"href" : "#/maia/groups.html",
	    			"state" : "root.maia.groups"
	    		},{
	    			"label" : "Protocols",
	    			"href" : "#/maia/protocols.html",
	    			"state" : "root.maia.protocols"
	    		},{
	    			"label" : "Ontologies",
	    			"href" : "#/maia/ontologies.html",
	    			"state" : "root.maia.ontologies"
	    		}]
		},{
			"name": "OSGI",
			"icon" : "plug",
	    	"items" : [{
	    			"label" : "Bundles",
	    			"href" : "#/osgi/bundles.html",
	    			"state" : "root.osgi.bundles"
	    		},{
	    			"label" : "Services",
	    			"href" : "#/osgi/services.html",
	    			"state" : "root.osgi.services"
	    		},{
	    			"label" : "Statistic",
	    			"href" : "#/osgi/statistic.html",
	    			"state" : "root.osgi.statistic"
	    		}]
		},{
			"name": "JVM",
			"icon" : "coffee",
	    	"items" : [{
	    			"label" : "Threads",
	    			"href" : "#/jvm/threads.html",
	    			"state" : "root.jvm.threads"
	    		},{
	    			"label" : "Statistic",
	    			"href" : "#/jvm/statistic.html",
	    			"state" : "root.jvm.statistic"
	    		}]
		},{
			"name": "OS",
			"icon" : "windows",
	    	"items" : [{
	    			"label" : "Processes",
	    			"href" : "#/os/processes.html",
	    			"state" : "root.os.processes"
	    		},{
	    			"label" : "Statistic",
	    			"href" : "#/os/statistic.html",
	    			"state" : "root.os.statistic"
	    		}]
		},{
			"name": "HW",
			"icon" : "cube",
	    	"items" : [{
	    			"label" : "CPU Utilization",
	    			"href" : "#/hw/cpu.html",
	    			"state" : "root.hw.cpu"
	    		},{
	    			"label" : "Memory Utilization",
	    			"href" : "#/hw/memory.html",
	    			"state" : "root.hw.memory"
	    		},{
	    			"label" : "Statistic",
	    			"href" : "#/hw/statistic.html",
	    			"state" : "root.hw.statistic"
	    		}]
		}
  ];
    
}]);