{
	"uuid" : "64a2672e-4c90-4001-be82-d33860eec2be",
	"label" : "Zipato Authenticate Protocol",
	"type" : "ru.agentlab.maia.task.sequential.SequentialTaskScheduler",
	"exceptions" : [
		{ 
			"uuid" : "21bc06af-34ca-47d6-b1e9-745ea7182f56",
			"label" : "NullPointerException", 
			"type" : "java.lang.NullPointerException" 
		}
	],
	"inputs" : [
		{ 
			"uuid" : "fb39c4f3-d68a-4fbc-9145-6de0f6c899ba",
			"label" : "login", 
			"type" : "java.lang.String" 
		},
		{ 
			"uuid" : "c3b52306-3046-4a8f-8ac1-19a4032ac14b",
			"label" : "password", 
			"type" : "java.lang.String" 
		}
	],
	"outputs" : [
		{ 
			"uuid" : "b71e5d2d-61ea-4751-bfd2-2ee59021dd54",
			"label" : "success", 
			"type" : "java.lang.Boolean" 
		}
	],
	"subtasks" : [
		{
			"uuid" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6",
			"label" : "Create Bootstrap",
			"type" : "ru.agentlab.maia.task.sequential.SequentialTaskScheduler",
			"exceptions" : [
				{ 
					"uuid" : "cc4172f6-518a-46fb-8aaf-6e8dc8377fbc",
					"label" : "NullPointerException", 
					"type" : "java.lang.NullPointerException" 
				}
			],
			"inputs" : [ 
				{ 
					"uuid" : "f2def088-eb54-44fc-942e-8ec3ef441488",
					"label" : "login", 
					"type" : "java.lang.String" 
				},
				{ 
					"uuid" : "df162a68-56c7-4658-99b9-d117a9d05fa6",
					"label" : "password", 
					"type" : "java.lang.String" 
				}
			],
			"outputs" : [ 
				{ 
					"uuid" : "48d05021-0eeb-4961-aed0-ee2831f8341c",
					"label" : "bootstrap", 
					"type" : "io.netty.bootstrap.Bootstrap" 
				}
			]
		},
		{	
			"uuid" : "d39d002d-82f4-4280-ad8f-2a724ddcfca2",
			"label" : "Check Not Null",
			"type" : "ru.agentlab.maia.task.sequential.SequentialTaskScheduler",
			"inputs" : [ 
				{ 
					"uuid" : "4a8e80ea-5ac7-47e2-92d2-b0252d8f980a",
					"label" : "input", 
					"type" : "java.lang.Object"
				}
			],
			"outputs" : [ 
				{ 
					"uuid" : "063595cd-1b61-4c91-9dbf-9f9a250087be",
					"label" : "result", 
					"type" : "java.lang.Boolean" 
				}
			]
		}
	],
	"dataflow" : [
		["fb39c4f3-d68a-4fbc-9145-6de0f6c899ba", "f2def088-eb54-44fc-942e-8ec3ef441488"],
		["c3b52306-3046-4a8f-8ac1-19a4032ac14b", "df162a68-56c7-4658-99b9-d117a9d05fa6"],
		["48d05021-0eeb-4961-aed0-ee2831f8341c", "4a8e80ea-5ac7-47e2-92d2-b0252d8f980a"],
		["063595cd-1b61-4c91-9dbf-9f9a250087be", "b71e5d2d-61ea-4751-bfd2-2ee59021dd54"]
	]
}