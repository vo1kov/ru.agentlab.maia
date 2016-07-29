package ru.agentlab.maia.message.impl;

import java.nio.charset.Charset;
import java.util.List;

import com.google.gson.Gson;

import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToMessageDecoder;
import io.netty.handler.codec.http.FullHttpRequest;
import ru.agentlab.maia.message.IMessage;

public class AclMessageDecoder extends MessageToMessageDecoder<FullHttpRequest> {

	Gson gson = new Gson();

	@Override
	protected void decode(ChannelHandlerContext ctx, FullHttpRequest request, List<Object> output) throws Exception {
		String json = request.content().toString(Charset.defaultCharset());
		IMessage message = gson.fromJson(json, AclMessage.class);
		output.add(message);
	}

}
