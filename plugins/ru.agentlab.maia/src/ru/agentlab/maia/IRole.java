package ru.agentlab.maia;

import java.util.Map;

public interface IRole {

	void setActive(boolean active);

	boolean isActive();

	Object getRoleObject();

	IPlan<?>[] getPlans();

	Map<String, Object> getExtra();


}
