var routerApp = angular.module('maiaApp', ['ui.router']);

routerApp.config(function($stateProvider, $urlRouterProvider) {
    
    $urlRouterProvider.otherwise('/home');
    
    $stateProvider
        
        // HOME STATES AND NESTED VIEWS ========================================
	    .state('home', {
	        url: '/home',
	        templateUrl: 'partial-home.html'
	    })
	
	    // nested list with custom controller
	    .state('home.list', {
	        url: '/list',
	        templateUrl: 'partial-home-list.html',
	        controller: function($scope) {
	            $scope.dogs = ['Bernese', 'Husky', 'Goldendoodle'];
	        }
	    })
	
	    .state('osgi', {
	        url: '/osgi',
	        template: 'osgi'
	    })
	
	    .state('osgi.statistic', {
	        url: '/statistic',
	        template: 'osgi.statistic'
	    })
	
	    // nested list with just some random string data
	    .state('home.paragraph', {
	        url: '/paragraph',
	        template: 'I could sure use a drink right now.'
	    })
	    
	     // ABOUT PAGE AND MULTIPLE NAMED VIEWS =================================
        .state('about', {
            // we'll get to this in a bit       
        });
        
});

angular.module("maiaApp", [])
	.controller("JavaVirtualMachineStatistic", function($scope) {
		$scope.jvm = {
			"info" : {
				"vendor" : "Oracle Corporation",
				"version" : "1.8.0_20"
			},
			"variables" : {
				"TEMP" : "%USERPROFILE%\AppData\Local\Temp",
				"OS" : "Windows_NT",
				"OSe" : "Windows_NT",
				"OSw" : "Windows_NT",
				"OSws" : "Windows_NT"
			}
		};
	})
	.controller("OperatingSystemStatistic", function($scope) {
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
	})
	.controller("Menu", function($scope) {
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
		    			"href" : "#/ecosystem/clouds.html"
		    		},{
		    			"label" : "Agent Group Repositories",
		    			"href" : "#/ecosystem/groups.html"
		    		},{
		    			"label" : "Protocol Repositories",
		    			"href" : "#/ecosystem/protocols.html"
		    		},{
		    			"label" : "Ontology Repositories",
		    			"href" : "#/ecosystem/ontologies.html"
		    		},{
		    			"label" : "P2 Repositories",
		    			"href" : "#/ecosystem/bundles.html"
		    		}]
			},{
				"name": "MAIA",
				"icon" : "user",
		    	"items" : [{
		    			"label" : "Peers",
		    			"href" : "#/maia/peers.html"
		    		},{
		    			"label" : "Containers",
		    			"href" : "#/maia/clouds.html"
		    		},{
		    			"label" : "Agents",
		    			"href" : "#/maia/agents.html"
		    		},{
		    			"label" : "Behaviours",
		    			"href" : "#/maia/behaviours.html"
		    		},{
		    			"label" : "Groups",
		    			"href" : "#/maia/groups.html"
		    		},{
		    			"label" : "Interaction Protocols",
		    			"href" : "#/maia/protocols.html"
		    		},{
		    			"label" : "Ontologies",
		    			"href" : "#/maia/ontologies.html"
		    		}]
			},{
				"name": "OSGI",
				"icon" : "plug",
		    	"items" : [{
		    			"label" : "Bundles",
		    			"href" : "#/osgi/bundles.html"
		    		},{
		    			"label" : "Services",
		    			"href" : "#/osgi/services.html"
		    		},{
		    			"label" : "Statistic",
		    			"href" : "#/osgi/statistic.html"
		    		}]
			},{
				"name": "JVM",
				"icon" : "coffee",
		    	"items" : [{
		    			"label" : "Threads",
		    			"href" : "#/jvm/peers.html"
		    		},{
		    			"label" : "Statistic",
		    			"href" : "#/jvm/statistic.html"
		    		}]
			},{
				"name": "OS",
				"icon" : "windows",
		    	"items" : [{
		    			"label" : "Processes",
		    			"href" : "#/os/processes.html"
		    		},{
		    			"label" : "Statistic",
		    			"href" : "#/os/statistic.html"
		    		}]
			},{
				"name": "HW",
				"icon" : "cube",
		    	"items" : [{
		    			"label" : "CPU Utilization",
		    			"href" : "#/hw/cpu.html"
		    		},{
		    			"label" : "Memory Utilization",
		    			"href" : "#/hw/memory.html"
		    		},{
		    			"label" : "Statistic",
		    			"href" : "#/hw/statistic.html"
		    		}]
			}
	  ];
	});