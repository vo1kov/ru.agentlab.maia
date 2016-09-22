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

	void add(IRole role);

	default void addAll(IRole[] roles) {
		for (int i = 0; i < roles.length; i++) {
			add(roles[i]);
		}
	}

	default void addAll(Collection<IRole> roles) {
		roles.forEach(this::add);
	}

	default void addAll(Stream<IRole> roles) {
		roles.forEach(this::add);
	}

	default void addAndActivate(IRole role) {
		checkNotNull(role, "Role to add should be non null");
		add(role);
		activate(role);
	}

	boolean activate(IRole role);

	boolean deactivate(IRole role);

	void remove(IRole role);

	default void removeAll(IRole[] roles) {
		for (int i = 0; i < roles.length; i++) {
			remove(roles[i]);
		}
	}

	default void removeAll(Collection<IRole> roles) {
		roles.forEach(this::remove);
	}

	default void removeAll(Stream<IRole> roles) {
		roles.forEach(this::remove);
	}

	Collection<IRole> getRoles();

	default void clear() {
		getRoles().forEach(this::remove);
	}

}