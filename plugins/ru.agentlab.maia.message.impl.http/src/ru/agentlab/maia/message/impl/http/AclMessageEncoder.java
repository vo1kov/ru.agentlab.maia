package ru.agentlab.maia.message.impl.http;

import java.util.List;

import com.google.gson.Gson;

import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToMessageEncoder;
import ru.agentlab.maia.agent.IMessage;

public class AclMessageEncoder extends MessageToMessageEncoder<IMessage> {

	Gson gson;

	public AclMessageEncoder(Gson gson) {
		this.gson = gson;
	}

	@Override
	protected void encode(ChannelHandlerContext ctx, IMessage msg, List<Object> output) throws Exception {
		String json = gson.toJson(msg);
		output.add(json);
	}

}
