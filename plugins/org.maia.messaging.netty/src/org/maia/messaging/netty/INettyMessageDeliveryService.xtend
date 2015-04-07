package org.maia.messaging.netty

import org.maia.messaging.IMessageDeliveryService

interface INettyMessageDeliveryService extends IMessageDeliveryService {

	val static String KEY_SERVER_HANDLER = "mts.server.handler"

	val static String KEY_CLIENT_HANDLER = "mts.client.handler"

	val static String KEY_PORT = "mts.port"

	val static String KEY_WORKER_GROUP = "mts.group.worker"

	val static String KEY_BOSS_GROUP = "mts.group.boss"

}