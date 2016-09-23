package ru.agentlab.maia.agent;

import static com.google.common.base.Preconditions.checkNotNull;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.stream.Stream;

public interface IRoleBase {

	IRole create(Class<?> roleClass, Map<String, Object> parameters);

	default IRole create(Class<?> roleClass) {
		checkNotNull(roleClass, "Role class to create should be non null");
		return create(roleClass, Collections.emptyMap());
	}

	IRole create(Object role, Map<String, Object> parameters);

	default IRole create(Object role) {
		checkNotNull(role, "Role to create should be non null");
		return create(role, Collections.emptyMap());
	}

	boolean add(IRole role);

	default boolean addAll(IRole[] roles) {
		return Stream.of(roles).map(this::add).anyMatch(result -> result == true);
	}

	default boolean addAll(Collection<IRole> roles) {
		return roles.stream().map(this::add).anyMatch(result -> result == true);
	}

	default boolean addAll(Stream<IRole> roles) {
		return roles.map(this::add).anyMatch(result -> result == true);
	}

	default boolean addAndActivate(IRole role) {
		checkNotNull(role, "Role to add should be non null");
		if (add(role)) {
			return activate(role);
		} else {
			return false;
		}
	}

	boolean activate(IRole role);

	boolean deactivate(IRole role);

	boolean remove(IRole role);

	default boolean removeAll(IRole[] roles) {
		return Stream.of(roles).map(this::remove).anyMatch(result -> result == true);
	}

	default boolean removeAll(Collection<IRole> roles) {
		return roles.stream().map(this::remove).anyMatch(result -> result == true);
	}

	default boolean removeAll(Stream<IRole> roles) {
		return roles.map(this::remove).anyMatch(result -> result == true);
	}

	Collection<IRole> getRoles();

	default void clear() {
		getRoles().forEach(this::remove);
	}

}