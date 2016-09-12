package ru.agentlab.maia.message.impl.http;

import java.nio.charset.Charset;
import java.util.List;

import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToMessageEncoder;
import io.netty.handler.codec.http.DefaultFullHttpRequest;
import io.netty.handler.codec.http.HttpMethod;
import io.netty.handler.codec.http.HttpRequest;
import io.netty.handler.codec.http.HttpVersion;

public class HttpRequestContentEncoder extends MessageToMessageEncoder<String> {

	@Override
	protected void encode(ChannelHandlerContext ctx, String content, List<Object> output) throws Exception {
		HttpRequest request = new DefaultFullHttpRequest(HttpVersion.HTTP_1_1, HttpMethod.POST, "localhost",
				Unpooled.wrappedBuffer(content.getBytes(Charset.defaultCharset())));
		output.add(request);
	}

}
