package ru.agentlab.maia.message.impl.http;

import java.nio.charset.Charset;
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

	Gson gson;

	public AclMessageEncoder(Gson gson) {
		this.gson = gson;
	}

	@Override
	protected void encode(ChannelHandlerContext ctx, IMessage msg, List<Object> output) throws Exception {
		String json = gson.toJson(msg);
		HttpRequest request = new DefaultFullHttpRequest(HttpVersion.HTTP_1_1, HttpMethod.POST, "localhost",
				Unpooled.wrappedBuffer(json.getBytes(Charset.defaultCharset())));
		output.add(request);
	}

}
