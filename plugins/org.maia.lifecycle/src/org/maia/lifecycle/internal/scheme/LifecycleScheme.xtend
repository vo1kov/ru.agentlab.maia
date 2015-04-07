package org.maia.lifecycle.internal.scheme

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.maia.lifecycle.scheme.ILifecycleScheme
import org.maia.lifecycle.scheme.ILifecycleState
import org.maia.lifecycle.scheme.ILifecycleTransition

@Accessors
class LifecycleScheme implements ILifecycleScheme {

	val List<ILifecycleState> states = new ArrayList<ILifecycleState>

	val List<ILifecycleTransition> transitions = new ArrayList<ILifecycleTransition>

	ILifecycleState initialState

	ILifecycleState finalState

}