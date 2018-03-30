package org.uqbar.project.wollok.typesystem.constraints.variables

import org.uqbar.project.wollok.typesystem.WollokType
import org.uqbar.project.wollok.typesystem.MessageType
import org.uqbar.project.wollok.typesystem.GenericType
import java.util.Map

/**
 * Represents an 'instantiated' generic type, i.e. the type of a specific instance of a generic type.
 * For example, if class list is generic and has a type parameter E, a specific list will not have type List<E>.
 * Instead, E should be assigned a specific type, for example [1,2,3] has type List<Number>, 
 * where List<Number> is an instance of the generic type List<E>.
 * 
 * This is an implementation type, specific to the constraint based type system, as the type information for 
 * the instantiated type parameters is represented by type variables and not by regular Wollok types.
 * 
 * @author npasserini
 */
class GenericTypeInstance implements WollokType {
	GenericType genericType
	
	Map<String, TypeVariable> typeParameters
	
	new(GenericType type, Map<String, TypeVariable> typeParameters) {
		this.genericType = genericType
		this.typeParameters = typeParameters
	}

	def param(String paramName) {
		typeParameters.get(paramName)	
	}
	
	// ************************************************************************
	// ** Interface WollokType, mostly delegated to the GenericType itself
	// ************************************************************************
	
	override getName() {
		genericType.name
	}
	
	override acceptsAssignment(WollokType other) {
		genericType.acceptsAssignment(other)
	}
	
	override acceptAssignment(WollokType other) {
		genericType.acceptAssignment(other)
	}
	
	override understandsMessage(MessageType message) {
		genericType.understandsMessage(message)
	}
	
	override resolveReturnType(MessageType message) {
		genericType.resolveReturnType(message)
	}
	
	override refine(WollokType previouslyInferred) {
		genericType.refine(previouslyInferred)
	}
	
	override getAllMessages() {
		genericType.allMessages
	}
		
}