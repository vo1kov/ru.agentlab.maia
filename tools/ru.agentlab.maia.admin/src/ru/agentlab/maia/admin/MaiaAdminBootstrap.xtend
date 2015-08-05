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

class MaiaAdminBootstrap extends ServerBootstrap {

	MaiaAdminChannelHandlerTracker handlerTracker

	new(NioEventLoopGroup bossGroup, NioEventLoopGroup workerGroup) {
		super()
		group(bossGroup, workerGroup)
		channel(NioServerSocketChannel)
		childHandler(new ChannelInitializer<SocketChannel> {

			override public void initChannel(SocketChannel ch) throws Exception {
				ch.pipeline => [
					addLast(new HttpServerCodec)
					addLast(new HttpObjectAggregator(1024 * 1024))
					addLast(new WebSocketServerCompressionHandler)
					addLast(new WebSocketServerHandler)

				]
				if (handlerTracker == null) {
					handlerTracker = new MaiaAdminChannelHandlerTracker(Activator.context, ch.pipeline)
				}
			}

		})
		option(ChannelOption.SO_BACKLOG, 128)
		childOption(ChannelOption.SO_KEEPALIVE, true)
	}

}