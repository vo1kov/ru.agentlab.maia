package ru.agentlab.maia.service.message;

import io.netty.bootstrap.Bootstrap;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelHandler;
import io.netty.channel.EventLoopGroup;

public interface INetworkProtocol {

	default ServerBootstrap getServerBootstrap(EventLoopGroup workerGroup, EventLoopGroup bossGroup) {
		return getServerBootstrap(workerGroup, bossGroup, null);
	}

	ServerBootstrap getServerBootstrap(EventLoopGroup workerGroup, EventLoopGroup bossGroup,
			ChannelHandler lastHandler);

	default Bootstrap getClientBootstrap(EventLoopGroup workerGroup) {
		return getClientBootstrap(workerGroup, null);
	}

	Bootstrap getClientBootstrap(EventLoopGroup workerGroup, ChannelHandler lastHandler);

}
