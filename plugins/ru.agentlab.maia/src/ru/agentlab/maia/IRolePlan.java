package ru.agentlab.maia;

import java.lang.reflect.Method;

public interface IRolePlan extends IPlan {

	Method getMethod();

	Object getRole();

}