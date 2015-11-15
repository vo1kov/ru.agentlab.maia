package ru.agentlab.maia.adapter.organization.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.Map
import ru.agentlab.maia.adapter.Adapter
import ru.agentlab.maia.organization.IProtocol
import ru.agentlab.maia.organization.Protocol

class ProtocolJsonAdapter extends Adapter<String, IProtocol> {

	val public static String LANGUAGE = "protocol-json"

	val public static String ROOT = "$"

	override adapt(String json) {
		val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)
		val parsed = JsonPath.using(conf).parse(json).read(ROOT) as Map<String, ?>
		val label = parsed.get("label") as String
		val result = new Protocol => [
			it.label = label
		]
		return result
	}

}