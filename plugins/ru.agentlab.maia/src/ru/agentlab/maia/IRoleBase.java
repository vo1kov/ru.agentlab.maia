package ru.agentlab.maia;

import ru.agentlab.maia.exception.ResolveException;

public interface IRoleBase {

	void add(Class<?> roleClass);

	void add(Class<?>... roleClasses);

	void resolve(Class<?> roleClass) throws ResolveException;

	void resolve(Class<?>... roleClasses) throws ResolveException;

	void resolveAll() throws ResolveException;

	boolean contains(Class<?> roleClass);

	void remove(Class<?> roleClass);

	void remove(Class<?>... roleClasses);

}