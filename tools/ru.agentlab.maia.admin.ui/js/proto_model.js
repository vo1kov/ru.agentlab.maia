var proto = {
	"id" : "ru.beeline.iot.gateway.zipato.proto.ZipatoAuthenticateProtocol",
	"exceptions" : [
		{
			"id" : "NullPointerException",
			"type" : "java.lang.NullPointerException"
		}
	],
	"inputs" : [
		{
			"id" : "login",
			"type" : "java.lang.String"
		},
		{
			"id" : "password",
			"type" : "java.lang.String"
		}
	],
	"outputs" : [
		{
			"id" : "success",
			"type" : "boolean"
		}
	],
	"states" : [
		{	
			"x" : 200,
			"y" : 200,
			"id" : "719b2a8a-4119-453b-a39d-62e9ce2d6cc6",
			"label" : "Create Bootstrap",
			"ref" : "ru.beeline.iot.gateway.zipato.CreateBootstrapBehaviour",
			"exceptions" : [
				{
					"id" : "NullPointerException",
					"type" : "java.lang.NullPointerException"
				}
			],
			"inputs" : [ 
				{
					"id" : "eventLoop",
					"label" : "Event Loop",
					"type" : "io.netty.channel.EventLoopGroup",
					"required" : true
				}, 
				{
					"id" : "channel",
					"type" : "java.lang.Class<? extends io.netty.channel.Channel>"
				}, 
				{
					"id" : "options",
					"type" : "java.util.Map<io.netty.channel.ChannelOption<java.lang.Object>, java.lang.Object>"
				}, 
				{
					"id" : "handler",
					"type" : "io.netty.channel.ChannelHandler"
				}
			],
			"outputs" : [ 
				{
					"id" : "bootstrap",
					"type" : "io.netty.bootstrap.Bootstrap"
				}
			]
		},
		{	
			"x" : 500,
			"y" : 100,
			"id" : "2da4cfe4-9da7-4940-830d-bbed1e895568",
			"label" : "Check Not Null",
			"ref" : "ru.beeline.iot.CheckNotNull",
			"inputs" : [ 
				{
					"id" : "input",
					"type" : "java.lang.Object",
					"required" : true
				}
			],
			"outputs" : [ 
				{
					"id" : "result",
					"type" : "boolean"
				}
			]
		},
		{	
			"x" : 600,
			"y" : 300,
			"id" : "test",
			"label" : "false",
			"ref" : "ru.beeline.iot.CheckNotNull",
			"inputs" : [ ],
			"outputs" : [ 
				{
					"id" : "result",
					"type" : "boolean"
				}
			]
		}
	],
	"dataflow" : [
		["login", "719b2a8a-4119-453b-a39d-62e9ce2d6cc6#eventLoop"],
		["login", "719b2a8a-4119-453b-a39d-62e9ce2d6cc6#options"],
		["login", "719b2a8a-4119-453b-a39d-62e9ce2d6cc6#channel"],
		["password", "719b2a8a-4119-453b-a39d-62e9ce2d6cc6#handler"],
		["719b2a8a-4119-453b-a39d-62e9ce2d6cc6#bootstrap", "2da4cfe4-9da7-4940-830d-bbed1e895568#input"],
		["2da4cfe4-9da7-4940-830d-bbed1e895568#result", "success"],
		["test#result", "success"]
	],
	"workflow" : [
		[null, "719b2a8a-4119-453b-a39d-62e9ce2d6cc6"], 
		["719b2a8a-4119-453b-a39d-62e9ce2d6cc6", "2da4cfe4-9da7-4940-830d-bbed1e895568"],
		["719b2a8a-4119-453b-a39d-62e9ce2d6cc6", "test"],
		["2da4cfe4-9da7-4940-830d-bbed1e895568", null],
		["test", null]
	]
}