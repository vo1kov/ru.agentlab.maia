package ru.agentlab.maia.messaging

import javax.inject.Provider

interface IMessageQueueFactory extends Provider<IMessageQueue> {
}
