package ru.agentlab.maia.message.impl;

import java.util.List;

import com.google.gson.Gson;

import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToMessageEncoder;
import io.netty.handler.codec.http.DefaultFullHttpRequest;
import io.netty.handler.codec.http.HttpMethod;
import io.netty.handler.codec.http.HttpRequest;
import io.netty.handler.codec.http.HttpVersion;
import ru.agentlab.maia.message.IMessage;

public class AclMessageEncoder extends MessageToMessageEncoder<IMessage> {

	Gson gson = new Gson();

	@Override
	protected void encode(ChannelHandlerContext ctx, IMessage msg, List<Object> output) throws Exception {
		String json = gson.toJson(msg);
		HttpRequest request = new DefaultFullHttpRequest(HttpVersion.HTTP_1_1, HttpMethod.POST, "localhost",
				Unpooled.wrappedBuffer(json.getBytes()));
		output.add(request);
	}

}
