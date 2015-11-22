var maiaApp = angular.module('maiaApp', ['ui.router']);

maiaApp.config(function($stateProvider, $urlRouterProvider) {
    
    $urlRouterProvider.otherwise('/home');
    
    $stateProvider
        
	    .state('home', {
	        url: '/home',
	        templateUrl: 'partials/partial-home.html'
	    })
	
	    .state('home.list', {
	        url: '/list',
	        templateUrl: 'partials/partial-home-list.html',
	        controller: function($scope) {
	            $scope.dogs = ['Bernese', 'Husky', 'Goldendoodle'];
	        }
	    })
	    
	    .state('agents', {
	        url: '/agents',
	        templateUrl: 'partials/agents/agents.html',
	    })
	    
	    .state('osgi', {
	        url: '/osgi',
	        templateUrl: 'partials/osgi/osgi.html',
	    })
	
	    .state('osgi.statistic', {
	        url: '/statistic',
	        views: {
	
	            '': { 
	            	templateUrl: 'partials/osgi/statistic.html' 
	            },
	
	            'info@osgi.statistic': { 
	            	templateUrl: 'partials/osgi/statistic-info.html',
               		controller: 'osgi-info-controller'
	            },
	
	            'variables@osgi.statistic': { 
	            	templateUrl: 'partials/osgi/statistic-variables.html',
               		controller: 'osgi-info-controller'
	            }
	        }
	    })
	    
	    .state('jvm', {
	        url: '/jvm',
	        templateUrl: 'partials/jvm/osgi.html',
	    })
	
	    .state('jvm.statistic', {
	        url: '/statistic',
	        views: {
	
	            '': { 
	            	templateUrl: 'partials/jvm/statistic.html' 
	            },
	
	            'info@jvm.statistic': { 
	            	templateUrl: 'partials/jvm/statistic-info.html',
               		controller: 'jvm-info-controller'
	            },
	
	            'variables@jvm.statistic': { 
	            	templateUrl: 'partials/jvm/statistic-variables.html',
               		controller: 'jvm-info-controller'
	            }
	        }
	    })
	
	    .state('home.paragraph', {
	        url: '/paragraph',
	        template: 'I could sure use a drink right now.'
	    })
	    
        .state('about', {
            // we'll get to this in a bit       
        });
        
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


maiaApp.controller('menu-controller', function($scope) {
    
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
	    			"href" : "#/osgi/statistic.html",
	    			"state" : "osgi.statistic"
	    		}]
		},{
			"name": "JVM",
			"icon" : "coffee",
	    	"items" : [{
	    			"label" : "Threads",
	    			"href" : "#/jvm/peers.html"
	    		},{
	    			"label" : "Statistic",
	    			"href" : "#/jvm/statistic.html",
	    			"state" : "jvm.statistic"
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