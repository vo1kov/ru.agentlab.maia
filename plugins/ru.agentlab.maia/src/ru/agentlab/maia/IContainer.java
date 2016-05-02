/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import java.util.Set;
import ru.agentlab.maia.context.exception.InjectionException;

/**
 * Container for storing services and agents.
 * 
 * @author Dmitriy Shishkin
 */
@SuppressWarnings("all")
public interface IContainer {
  /**
   * <p>
   * Returns parent of context or <code>null</code> if context is a root context.
   * </p>
   * 
   * @return 			parent of context or <code>null</code> if context have no parent.
   */
  public abstract IContainer getParent();
  
  public abstract Iterable<IContainer> getChilds();
  
  public abstract void addChild(final IContainer container);
  
  public abstract void removeChild(final IContainer container);
  
  public abstract void clearChilds();
  
  /**
   * <p>
   * Change parent of context. If <code>null</code> then context become to
   * be a root context.
   * </p>
   * 
   * @param parent 	the new parent context. If <code>null</code> then context
   * 					become to be a root context.
   */
  public abstract IContainer setParent(final IContainer parent);
  
  /**
   * <p>
   * Retrieve unique id of context.
   * </p>
   * 
   * @return 			unique id of context. Can not be null.
   */
  public abstract String getUuid();
  
  /**
   * <p>
   * Returns the context value associated with the given name. Returns <code>null</code> if no
   * such value is defined or computable by this context, or if the assigned value is
   * <code>null</code>.
   * </p>
   * 
   * @param key		key of registered service as plain string. If <code>null</code>
   * 					then IllegalArgumentException will be thrown.
   * @return			an object corresponding to the given name, or <code>null</code>.
   * @throws			MaiaContextKeyNotFound
   * 					if context have no value for specified key.
   * 
   * @see #getService(Class)
   */
  public abstract Object get(final String key);
  
  /**
   * <p>
   * Returns the context value associated with the given name. Returns <code>null</code> if no
   * such value is defined or computable by this context, or if the assigned value is
   * <code>null</code>.
   * </p>
   * 
   * @param key		key of registered service as type of the value to return. If <code>null</code>
   * 					then IllegalArgumentException will be thrown.
   * @param <T> 		type of returning value.
   * @return 			an object corresponding to the given class, can be <code>null</code>.
   * @throws			ClassCastException
   * 					if context contains value but with different type.
   * @throws			MaiaContextKeyNotFound
   * 					if context have no value for specified key.
   * 
   * @see #getService(String)
   */
  public abstract <T extends Object> T get(final Class<T> key);
  
  /**
   * <p>
   * Returns the context value associated with the given key in this context, or <code>null</code> if
   * no such value is defined in this context.
   * </p><p>
   * This method does not search for the value on other elements on the context tree.
   * </p>
   * 
   * @param key 		key of registered service as plain string. If <code>null</code>
   * 					then IllegalArgumentException will be thrown.
   * @param <T> 		type of returning value
   * @return 			an object corresponding to the given name, or <code>null</code>
   * @throws			MaiaContextKeyNotFound
   * 					if context have no value for specified key.
   * 
   * @see #getServiceLocal(Class)
   */
  public abstract Object getLocal(final String key);
  
  /**
   * <p>
   * Returns the context value associated with the given key in this context, or <code>null</code> if
   * no such value is defined in this context.
   * </p><p>
   * This method does not search for the value on other elements on the context tree.
   * </p>
   * 
   * @param key		key of registered service as type of the value to return. If <code>null</code>
   * 					then IllegalArgumentException will be thrown.
   * @param <T> 		type of returning value.
   * @return 			an object corresponding to the given class, can be <code>null</code>.
   * @throws			ClassCastException
   * 					if context contains value but with different type.
   * @throws			MaiaContextKeyNotFound
   * 					if context have no value for specified key.
   * 
   * @see #getServiceLocal(String)
   */
  public abstract <T extends Object> T getLocal(final Class<T> key);
  
  /**
   * <p>
   * Returns keys of registered services.
   * </p>
   * 
   * @return keys of registered services.
   */
  public abstract Set<String> getKeySet();
  
  /**
   * <p>
   * Removes the given name and any corresponding value from this context.
   * </p><p>
   * Removal can never affect a parent context, so it is possible that a subsequent call to
   * {@link #get(String)} with the same name will return a non-null result, due to a value being
   * stored in a parent context.
   * </p>
   * 
   * @param key		key of registered service as plain string. If <code>null</code>
   * 					then IllegalArgumentException will be thrown.
   * @return 			value removed from context
   * 
   * @see #remove(Class)
   */
  public abstract Object remove(final String key);
  
  /**
   * <p>
   * Removes the given name and any corresponding value from this context.
   * </p><p>
   * Removal can never affect a parent context, so it is possible that a subsequent call to
   * {@link #get(String)} with the same name will return a non-null result, due to a value being
   * stored in a parent context.
   * </p>
   * 
   * @param key		key of registered service as type of the value to return. If <code>null</code>
   * 					then IllegalArgumentException will be thrown.
   * @return 			value removed from context
   * 
   * @see #remove(String)
   */
  public abstract Object remove(final Class<?> key);
  
  public abstract boolean clear();
  
  /**
   * <p>
   * Sets a value to be associated with a given name in this context.
   * The value can may be <code>null</code>.
   * </p>
   * 
   * @param key		key of registered service as plain string. If <code>null</code>
   * 					then IllegalArgumentException will be thrown.
   * @param value 	the value to be stored that can return the stored value.
   * 
   * @see #putService(Class, Object)
   */
  public abstract Object put(final String key, final Object value);
  
  /**
   * <p>
   * Sets a value to be associated with a given class in this context.
   * </p>
   * 
   * @param key		key of registered service as type of the value to return. If <code>null</code>
   * 					then IllegalArgumentException will be thrown.
   * @param value 	the value to be stored
   * @param <T> 		type of specified value.
   * 
   * @see #putService(String, Object)
   * @see #putProvider(String, Provider)
   */
  public abstract <T extends Object> Object put(final Class<T> key, final T value);
  
  /**
   * <p>
   * Obtain an instance of the specified class and inject it with the context.
   * Class'es scope dictates if a new instance of the class will be created,
   * or existing instance will be reused.
   * </p>
   * 
   * @param clazz 	the class to be instantiated
   * @param T 		type of creating service
   * @return 			an instance of the specified class
   * @throws 			InjectionException
   * 					if an exception occurred while performing this operation
   */
  public abstract <T extends Object> T make(final Class<T> clazz) throws InjectionException;
  
  /**
   * <p>
   * Injects a context into a domain object.
   * </p>
   * 
   * @param object 	the object to perform injection on
   * @throws 			InjectionException
   * 					if an exception occurred while performing this operation
   */
  public abstract void inject(final Object object) throws InjectionException;
  
  /**
   * <p>
   * Create new service instance and register it to context
   * </p>
   * 
   * @param clazz 	type of service to be deployed
   * @return 			deployed service object
   * @param T 		type of deployed service
   * @throws 			InjectionException
   * 					when creating or registering falls
   */
  public abstract <T extends Object> T deploy(final Class<T> clazz) throws InjectionException;
  
  /**
   * <p>
   * Create new service instance and register it to context with specified key
   * </p>
   * 
   * @param clazz 	type of service to be deployed
   * @param key 		key for registration in context
   * @param T 		type of deployed service
   * @return 			deployed service object
   * @throws 			InjectionException
   * 					when creating or registering falls
   */
  public abstract <T extends Object> T deploy(final Class<T> clazz, final String key) throws InjectionException;
  
  /**
   * <p>
   * Create new service instance and register it to context with specified key
   * </p>
   * 
   * @param clazz 	type of service to be deployed
   * @param interf 	interface for registration in context
   * @param T 		type of deployed service
   * @return 			deployed service object
   * @throws 			InjectionException
   * 					when creating or registering falls
   */
  public abstract <T extends Object> T deploy(final Class<? extends T> clazz, final Class<T> interf) throws InjectionException;
  
  /**
   * <p>
   * Inject context to service object and register it to context
   * </p>
   * 
   * @param service 	service object to be deployed
   * @param T 		type of deployed service
   * @return  		deployed service object
   * @throws 			InjectionException
   * 					when injecting falls
   */
  public abstract <T extends Object> T deploy(final T service) throws InjectionException;
  
  /**
   * <p>
   * Inject context to service object and register it to context with specified key
   * </p>
   * 
   * @param service	service object to be deployed
   * @param key 		key for registration in context
   * @param T 		type of deployed service
   * @return  		deployed service object
   * @throws 			InjectionException
   * 					when creating or registering falls
   */
  public abstract <T extends Object> T deploy(final T service, final String key) throws InjectionException;
  
  /**
   * <p>
   * Inject context to service object and register it to context with specified key
   * </p>
   * 
   * @param service 	service object to be deployed
   * @param interf 	interface for registration in context
   * @param T 		type of deployed service
   * @return 			deployed service object
   * @throws 			InjectionException
   * 					when creating or registering falls
   */
  public abstract <T extends Object> T deploy(final T service, final Class<T> interf) throws InjectionException;
}
