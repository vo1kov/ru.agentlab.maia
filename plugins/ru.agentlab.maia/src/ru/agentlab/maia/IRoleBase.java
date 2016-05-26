package ru.agentlab.maia;

import java.util.Collection;
import java.util.Map;

import ru.agentlab.maia.exception.ResolveException;

public interface IRoleBase {

	Object addRole(Class<?> roleClass, Map<String, Object> parameters) throws ResolveException;

	boolean contains(Class<?> roleClass);

	void remove(Class<?> roleClass);

	Collection<Object> getRoles();

}