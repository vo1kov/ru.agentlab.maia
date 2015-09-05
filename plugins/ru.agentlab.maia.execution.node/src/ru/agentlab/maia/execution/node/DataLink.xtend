package ru.agentlab.maia.execution.node

import java.util.UUID
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.tree.IDataLink
import ru.agentlab.maia.execution.tree.IDataParameter

@Accessors
class DataLink implements IDataLink {

	IDataParameter<?> from

	IDataParameter<?> to

	String key

	new(IDataParameter<?> from, IDataParameter<?> to) {
		this.from = from
		this.to = to
		key = UUID.randomUUID.toString
	}
}