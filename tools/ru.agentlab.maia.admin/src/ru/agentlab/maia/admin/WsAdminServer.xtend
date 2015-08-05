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
import ru.agentlab.maia.admin.internal.Activator

class WsAdminServer {

	val port = 9091

	HandlerTracker handlerTracker

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
						addLast(new HttpServerCodec)
						addLast(new HttpObjectAggregator(1024 * 1024))
						addLast(new WebSocketServerCompressionHandler)
						addLast(new WebSocketServerHandler)

						handlerTracker = new HandlerTracker(Activator.context, it)

					]
				}

			})
			b.option(ChannelOption.SO_BACKLOG, 128)
			b.childOption(ChannelOption.SO_KEEPALIVE, true)

			b.bind(port)

		} finally {
			// workerGroup.shutdownGracefully()
			// bossGroup.shutdownGracefully()
		}
	}

}