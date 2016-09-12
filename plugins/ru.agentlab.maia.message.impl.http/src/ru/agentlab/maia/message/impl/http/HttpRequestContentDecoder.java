package ru.agentlab.maia.message.impl.http;

import java.nio.charset.Charset;
import java.util.List;

import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToMessageDecoder;
import io.netty.handler.codec.http.FullHttpRequest;

public class HttpRequestContentDecoder extends MessageToMessageDecoder<FullHttpRequest> {

	@Override
	protected void decode(ChannelHandlerContext ctx, FullHttpRequest request, List<Object> out) throws Exception {
		String content = request.content().toString(Charset.defaultCharset());
		out.add(content);
	}


}
