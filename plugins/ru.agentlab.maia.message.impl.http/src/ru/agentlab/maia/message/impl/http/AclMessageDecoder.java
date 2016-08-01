package ru.agentlab.maia.message.impl.http;

import java.nio.charset.Charset;
import java.util.List;

import com.google.gson.Gson;

import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToMessageDecoder;
import io.netty.handler.codec.http.FullHttpRequest;
import ru.agentlab.maia.message.IMessage;
import ru.agentlab.maia.message.impl.AclMessage;

public class AclMessageDecoder extends MessageToMessageDecoder<FullHttpRequest> {

	Gson gson;

	public AclMessageDecoder(Gson gson) {
		this.gson = gson;
	}

	@Override
	protected void decode(ChannelHandlerContext ctx, FullHttpRequest request, List<Object> output) throws Exception {
		String json = request.content().toString(Charset.defaultCharset());
		IMessage message = gson.fromJson(json, AclMessage.class);
		output.add(message);
	}

}
