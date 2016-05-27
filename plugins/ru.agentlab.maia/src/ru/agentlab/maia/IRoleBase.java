package ru.agentlab.maia;

import java.util.Collection;

public interface IRoleBase {

	boolean addRole(Object roleObject);

	boolean contains(Object roleObject);

	boolean remove(Object roleObject);

	Collection<Object> getRoles();

	void clear();

}