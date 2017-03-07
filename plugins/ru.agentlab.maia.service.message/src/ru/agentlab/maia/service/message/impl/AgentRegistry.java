package ru.agentlab.maia.service.message.impl;

import java.util.Collection;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.BiConsumer;
import java.util.function.BiFunction;
import java.util.function.Function;

import javax.annotation.PostConstruct;

import ru.agentlab.maia.AgentAddress;
import ru.agentlab.maia.IAgentRegistry;

public class AgentRegistry implements IAgentRegistry {

	Map<UUID, AgentAddress> map = new ConcurrentHashMap<>();

	@PostConstruct
	public void init() {
	}

	@Override
	public int size() {
		return map.size();
	}

	@Override
	public boolean isEmpty() {
		return map.isEmpty();
	}

	@Override
	public boolean containsKey(Object key) {
		return map.containsKey(key);
	}

	@Override
	public boolean containsValue(Object value) {
		return map.containsValue(value);
	}

	@Override
	public AgentAddress get(UUID key) {
		return map.get(key);
	}

	@Override
	public AgentAddress put(UUID key, AgentAddress value) {
		return map.put(key, value);
	}

	@Override
	public AgentAddress remove(Object key) {
		return map.remove(key);
	}

	@Override
	public void putAll(Map<? extends UUID, ? extends AgentAddress> m) {
		map.putAll(m);
	}

	@Override
	public void clear() {
		map.clear();
	}

	@Override
	public Set<UUID> keySet() {
		return map.keySet();
	}

	@Override
	public Collection<AgentAddress> values() {
		return map.values();
	}

	@Override
	public Set<Entry<UUID, AgentAddress>> entrySet() {
		return map.entrySet();
	}

	public boolean equals(Object o) {
		return map.equals(o);
	}

	public int hashCode() {
		return map.hashCode();
	}

	@Override
	public AgentAddress getOrDefault(Object key, AgentAddress defaultValue) {
		return map.getOrDefault(key, defaultValue);
	}

	@Override
	public void forEach(BiConsumer<? super UUID, ? super AgentAddress> action) {
		map.forEach(action);
	}

	@Override
	public void replaceAll(BiFunction<? super UUID, ? super AgentAddress, ? extends AgentAddress> function) {
		map.replaceAll(function);
	}

	@Override
	public AgentAddress putIfAbsent(UUID key, AgentAddress value) {
		return map.putIfAbsent(key, value);
	}

	@Override
	public boolean remove(Object key, Object value) {
		return map.remove(key, value);
	}

	@Override
	public boolean replace(UUID key, AgentAddress oldValue, AgentAddress newValue) {
		return map.replace(key, oldValue, newValue);
	}

	@Override
	public AgentAddress replace(UUID key, AgentAddress value) {
		return map.replace(key, value);
	}

	@Override
	public AgentAddress computeIfAbsent(UUID key, Function<? super UUID, ? extends AgentAddress> mappingFunction) {
		return map.computeIfAbsent(key, mappingFunction);
	}

	@Override
	public AgentAddress computeIfPresent(UUID key,
			BiFunction<? super UUID, ? super AgentAddress, ? extends AgentAddress> remappingFunction) {
		return map.computeIfPresent(key, remappingFunction);
	}

	@Override
	public AgentAddress compute(UUID key,
			BiFunction<? super UUID, ? super AgentAddress, ? extends AgentAddress> remappingFunction) {
		return map.compute(key, remappingFunction);
	}

	@Override
	public AgentAddress merge(UUID key, AgentAddress value,
			BiFunction<? super AgentAddress, ? super AgentAddress, ? extends AgentAddress> remappingFunction) {
		return map.merge(key, value, remappingFunction);
	}

}
