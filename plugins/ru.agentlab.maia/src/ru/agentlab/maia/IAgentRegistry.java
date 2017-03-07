package ru.agentlab.maia;

import java.util.Collection;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.UUID;
import java.util.function.BiConsumer;
import java.util.function.BiFunction;
import java.util.function.Function;

public interface IAgentRegistry {

	AgentAddress merge(UUID key, AgentAddress value,
			BiFunction<? super AgentAddress, ? super AgentAddress, ? extends AgentAddress> remappingFunction);

	AgentAddress compute(UUID key,
			BiFunction<? super UUID, ? super AgentAddress, ? extends AgentAddress> remappingFunction);

	AgentAddress computeIfPresent(UUID key,
			BiFunction<? super UUID, ? super AgentAddress, ? extends AgentAddress> remappingFunction);

	AgentAddress computeIfAbsent(UUID key, Function<? super UUID, ? extends AgentAddress> mappingFunction);

	AgentAddress replace(UUID key, AgentAddress value);

	boolean replace(UUID key, AgentAddress oldValue, AgentAddress newValue);

	boolean remove(Object key, Object value);

	AgentAddress putIfAbsent(UUID key, AgentAddress value);

	void replaceAll(BiFunction<? super UUID, ? super AgentAddress, ? extends AgentAddress> function);

	void forEach(BiConsumer<? super UUID, ? super AgentAddress> action);

	AgentAddress getOrDefault(Object key, AgentAddress defaultValue);

	Set<Entry<UUID, AgentAddress>> entrySet();

	Collection<AgentAddress> values();

	Set<UUID> keySet();

	void clear();

	void putAll(Map<? extends UUID, ? extends AgentAddress> m);

	AgentAddress remove(Object key);

	AgentAddress put(UUID key, AgentAddress value);

	AgentAddress get(UUID key);

	boolean containsValue(Object value);

	boolean containsKey(Object key);

	boolean isEmpty();

	int size();

}
