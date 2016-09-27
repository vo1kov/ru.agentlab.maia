package ru.agentlab.maia.role.filter;

import java.util.Iterator;
import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.agent.IRole;
import ru.agentlab.maia.agent.IRoleBase;
import ru.agentlab.maia.filter.IPlanStateFilter;

public class SelectRoles implements IPlanStateFilter {

	Class<?> roleClass;

	@Inject
	IRoleBase roleBase;

	public SelectRoles(Class<?> roleClass) {
		this.roleClass = roleClass;
	}

	@Override
	public boolean matches(Object item, Map<String, Object> values) {
		Iterator<IRole> result = roleBase.getRoles().stream().filter(r -> r.getClass() == roleClass).iterator();
		if (result.hasNext()) {
			return true;
		} else {
			return false;
		}
	}

}
