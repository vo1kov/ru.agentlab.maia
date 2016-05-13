package ru.agentlab.maia;

import ru.agentlab.maia.exception.ResolveException;

public interface IRoleBase {

	void addRole(Class<?> role);

	void resolve() throws ResolveException;

}