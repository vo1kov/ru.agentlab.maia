package ru.agentlab.maia.admin

import io.netty.buffer.Unpooled
import io.netty.channel.ChannelFutureListener
import io.netty.channel.ChannelHandlerContext
import io.netty.channel.SimpleChannelInboundHandler
import io.netty.handler.codec.http.DefaultFullHttpResponse
import io.netty.handler.codec.http.FullHttpRequest
import io.netty.handler.codec.http.FullHttpResponse
import io.netty.handler.codec.http.HttpHeaderUtil
import io.netty.handler.codec.http.websocketx.CloseWebSocketFrame
import io.netty.handler.codec.http.websocketx.PingWebSocketFrame
import io.netty.handler.codec.http.websocketx.PongWebSocketFrame
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame
import io.netty.handler.codec.http.websocketx.WebSocketFrame
import io.netty.handler.codec.http.websocketx.WebSocketServerHandshaker
import io.netty.handler.codec.http.websocketx.WebSocketServerHandshakerFactory
import io.netty.util.CharsetUtil

import static io.netty.handler.codec.http.HttpHeaderNames.CONTENT_TYPE
import static io.netty.handler.codec.http.HttpHeaderNames.HOST
import static io.netty.handler.codec.http.HttpMethod.GET
import static io.netty.handler.codec.http.HttpResponseStatus.BAD_REQUEST
import static io.netty.handler.codec.http.HttpResponseStatus.FORBIDDEN
import static io.netty.handler.codec.http.HttpResponseStatus.NOT_FOUND
import static io.netty.handler.codec.http.HttpResponseStatus.OK
import static io.netty.handler.codec.http.HttpVersion.HTTP_1_1

/**
 * Handles handshakes and messages
 */
public class WebSocketServerHandler extends SimpleChannelInboundHandler<Object> {

	private static final String WEBSOCKET_PATH = "/websocket"

	private WebSocketServerHandshaker handshaker

	override public void messageReceived(ChannelHandlerContext ctx, Object msg) {
		switch (msg) {
			FullHttpRequest: {
				handleHttpRequest(ctx, msg)
			}
			WebSocketFrame: {
				handleWebSocketFrame(ctx, msg)
			}
			default: {
				ctx.fireChannelRead(msg)
			}
		}
	}

	override public void channelReadComplete(ChannelHandlerContext ctx) {
		ctx.flush
	}

	def private void handleHttpRequest(ChannelHandlerContext ctx, FullHttpRequest req) {
		// Handle a bad request.
		if (!req.decoderResult.success) {
			sendHttpResponse(ctx, req, new DefaultFullHttpResponse(HTTP_1_1, BAD_REQUEST))
			return
		}

		// Allow only GET methods.
		if (req.method != GET) {
			sendHttpResponse(ctx, req, new DefaultFullHttpResponse(HTTP_1_1, FORBIDDEN))
			return
		}

		// Send the demo page and favicon.ico
		if ("/".equals(req.uri)) {
			val content = Unpooled.wrappedBuffer("ttt".getBytes())
			// WebSocketServerIndexPage
			// .getContent(getWebSocketLocation(req))
			val res = new DefaultFullHttpResponse(HTTP_1_1, OK, content)

			res.headers().set(CONTENT_TYPE, "text/html charset=UTF-8")
			HttpHeaderUtil.setContentLength(res, content.readableBytes())

			sendHttpResponse(ctx, req, res)
			return
		}
		if ("/favicon.ico".equals(req.uri)) {
			val res = new DefaultFullHttpResponse(HTTP_1_1, NOT_FOUND)
			sendHttpResponse(ctx, req, res)
			return
		}

		// Handshake
		val wsFactory = new WebSocketServerHandshakerFactory(getWebSocketLocation(req), null, true)
		handshaker = wsFactory.newHandshaker(req)
		if (handshaker == null) {
			WebSocketServerHandshakerFactory.sendUnsupportedVersionResponse(ctx.channel())
		} else {
			handshaker.handshake(ctx.channel(), req)
		}
	}

	def private void handleWebSocketFrame(ChannelHandlerContext ctx, WebSocketFrame frame) {
		switch (frame) {
			CloseWebSocketFrame: {
				handshaker.close(ctx.channel, frame.retain)
			}
			PingWebSocketFrame: {
				ctx.channel.write(new PongWebSocketFrame(frame.content.retain))
			}
			PongWebSocketFrame: {
				
			}
			TextWebSocketFrame: {
				val request = (frame as TextWebSocketFrame).text
				ctx.fireChannelRead(request)
			}
			default: {
				throw new UnsupportedOperationException(String.format("%s frame types not supported", frame.class.name))
			}
		}
	}

	def private static void sendHttpResponse(ChannelHandlerContext ctx, FullHttpRequest req, FullHttpResponse res) {
		// Generate an error page if response getStatus code is not OK (200).
		if (res.status.code != 200) {
			val buf = Unpooled.copiedBuffer(res.status.toString, CharsetUtil.UTF_8)
			res.content.writeBytes(buf)
			buf.release
			HttpHeaderUtil.setContentLength(res, res.content.readableBytes)
		}

		// Send the response and close the connection if necessary.
		val f = ctx.channel().writeAndFlush(res)
		if (!HttpHeaderUtil.isKeepAlive(req) || res.status.code != 200) {
			f.addListener(ChannelFutureListener.CLOSE)
		}
	}

	override public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
		cause.printStackTrace
		ctx.close
	}

	def private static String getWebSocketLocation(FullHttpRequest req) {
		val location = req.headers().get(HOST) + WEBSOCKET_PATH
		// if (WebSocketServer.SSL) {
		// return "wss://" + location
		// } else {
		return "ws://" + location
	// }
	}
}