package ru.agentlab.maia.admin

import io.netty.bootstrap.ServerBootstrap
import io.netty.channel.ChannelInitializer
import io.netty.channel.ChannelOption
import io.netty.channel.nio.NioEventLoopGroup
import io.netty.channel.socket.SocketChannel
import io.netty.channel.socket.nio.NioServerSocketChannel
import io.netty.handler.codec.http.HttpObjectAggregator
import io.netty.handler.codec.http.HttpServerCodec
import io.netty.handler.codec.http.websocketx.extensions.compression.WebSocketServerCompressionHandler
import ru.agentlab.maia.admin.command.BundleHandler
import ru.agentlab.maia.admin.command.WsContextListHandler
import ru.agentlab.maia.admin.command.WsContextServicesListHandler
import ru.agentlab.maia.admin.command.WsSubscribeBundleHandler

class WsAdminServer {

	val port = 9091

	def void main() {
		val bossGroup = new NioEventLoopGroup
		val workerGroup = new NioEventLoopGroup
		try {
			val b = new ServerBootstrap
			b.group(bossGroup, workerGroup)
			b.channel(NioServerSocketChannel)
			b.childHandler(new ChannelInitializer<SocketChannel> {

				override public void initChannel(SocketChannel ch) throws Exception {
					ch.pipeline => [
//						addLast(new HttpServerCodec)
//						addLast(new HttpObjectAggregator(1024 * 1024))
//						addLast(new ContextListHandler)
//						addLast(new ContextHandler)
						addLast(new HttpServerCodec)
						addLast(new HttpObjectAggregator(65536))
						addLast(new WebSocketServerCompressionHandler)
						addLast(new WebSocketServerHandler)
						addLast(new WsContextListHandler)
						addLast(new BundleHandler)
						addLast(new WsSubscribeBundleHandler)
						addLast(new WsContextServicesListHandler)
					]
				}

			})
			b.option(ChannelOption.SO_BACKLOG, 128)
			b.childOption(ChannelOption.SO_KEEPALIVE, true)

			val f = b.bind(port).sync

			//f.channel.closeFuture.sync
		} finally {
			//workerGroup.shutdownGracefully()
			//bossGroup.shutdownGracefully()
		}
	}

	def static void main(String[] args) {
		(new AdminServer).main
	}

}