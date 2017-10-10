/*
 * generated by Xtext
 */
package org.uqbar.project.wollok.formatting2

import com.google.inject.Inject
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument
import org.uqbar.project.wollok.WollokConstants
import org.uqbar.project.wollok.services.WollokDslGrammarAccess
import org.uqbar.project.wollok.wollokDsl.Import
import org.uqbar.project.wollok.wollokDsl.WAssignment
import org.uqbar.project.wollok.wollokDsl.WBinaryOperation
import org.uqbar.project.wollok.wollokDsl.WBlockExpression
import org.uqbar.project.wollok.wollokDsl.WClass
import org.uqbar.project.wollok.wollokDsl.WClosure
import org.uqbar.project.wollok.wollokDsl.WFile
import org.uqbar.project.wollok.wollokDsl.WIfExpression
import org.uqbar.project.wollok.wollokDsl.WLibraryElement
import org.uqbar.project.wollok.wollokDsl.WListLiteral
import org.uqbar.project.wollok.wollokDsl.WMemberFeatureCall
import org.uqbar.project.wollok.wollokDsl.WMethodDeclaration
import org.uqbar.project.wollok.wollokDsl.WNamedObject
import org.uqbar.project.wollok.wollokDsl.WProgram
import org.uqbar.project.wollok.wollokDsl.WSetLiteral
import org.uqbar.project.wollok.wollokDsl.WTest
import org.uqbar.project.wollok.wollokDsl.WVariableDeclaration

import static org.uqbar.project.wollok.wollokDsl.WollokDslPackage.Literals.*

import static extension org.uqbar.project.wollok.model.WMethodContainerExtensions.*

class WollokDslFormatter extends AbstractFormatter2 {
	
	@Inject extension WollokDslGrammarAccess

	def dispatch void format(WFile wFile, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc.
		for (Import _import : wFile.getImports()) {
			_import.format
		}
		for (WLibraryElement wLibraryElement : wFile.getElements()) {
			wLibraryElement.format
		}
		wFile.getMain.format
		for (WTest wTest : wFile.getTests()) {
			wTest.format
		}
		wFile.getSuite.format
	}

	def dispatch void format(WProgram p, extension IFormattableDocument document) {
		p.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).append[ newLine ]
		p.elements.forEach [
			surround [ indent ]
			format
		]
		p.regionFor.keyword(WollokConstants.END_EXPRESSION).append[ newLine ]
	}

	def dispatch void format(WClass c, extension IFormattableDocument document) {
		c.regionFor.keyword(WollokConstants.CLASS).append [ oneSpace ]
		c.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).append[ newLine ].prepend [ oneSpace ]
		c.interior [ 
			indent
		]
		c.variableDeclarations.forEach [ format ]
		
		c.constructors.forEach [
			format
		]
		
		c.methods.forEach [ format ]
		c.regionFor.keyword(WollokConstants.END_EXPRESSION).surround[ newLine ]
	}

	def dispatch void format(WNamedObject o, extension IFormattableDocument document) {
		o.regionFor.keyword(WollokConstants.WKO).append [ oneSpace ]
		o.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).append[ newLine ].prepend [ oneSpace ]
		o.interior [ 
			indent
		]
		o.variableDeclarations.forEach [
			format
		]
		
		o.methods.forEach [
			format
		]
		o.regionFor.keyword(WollokConstants.END_EXPRESSION).append[ newLine ]
	}

	def dispatch void format(WVariableDeclaration v, extension IFormattableDocument document) {
		v.surround[	newLine	]
		v.regionFor.keyword(WollokConstants.VAR).append [ oneSpace ]
		v.regionFor.keyword(WollokConstants.CONST).append [ oneSpace ]
		v.variable.append [ oneSpace ]
		v.regionFor.keyword(WollokConstants.ASSIGNMENT).append [ oneSpace ]
		v.right.format
	}
	
	def dispatch void format(WMethodDeclaration m, extension IFormattableDocument document) {
		m.regionFor.feature(WMETHOD_DECLARATION__OVERRIDES).surround [ oneSpace ]
		m.regionFor.feature(WMETHOD_DECLARATION__NATIVE).surround [ oneSpace ]
		m.regionFor.keyword(WollokConstants.METHOD).surround [ oneSpace ]
		m.parameters.forEach [ parameter, i |
			parameter.append [ noSpace ]
			if (i == 0) {
				parameter.prepend [ noSpace ]
			} else {
				parameter.prepend [ oneSpace ]		
			} 
		]
		m.regionFor.feature(WNAMED__NAME).append [ noSpace ]
		m.surround [ newLine ]
		m.expression => [
			surround [ oneSpace ]
			format
		]
	}
	
	def dispatch void format(WBlockExpression b, extension IFormattableDocument document) {
		b.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).append[ newLine ]
		b.expressions.forEach [
			surround [ indent ]
			format
		]
		//b.regionFor.keyword(WollokConstants.END_EXPRESSION).append[ newLine ]
	}

	def dispatch void format(WMemberFeatureCall c, extension IFormattableDocument document) {
		c.prepend [ indent ]
		c.append [ newLine ]
		c.memberCallTarget.format
		c.memberCallArguments.forEach [
			format
		]
	}
	
	def dispatch void format(WAssignment a, extension IFormattableDocument document) {
		a.feature.surround [ oneSpace ]
		a.feature.format
		a.value.surround [ oneSpace ]
		a.value.format
		a.append[ newLine ]
	}
	
	def dispatch void format(WBinaryOperation o, extension IFormattableDocument document) {
		o.leftOperand.append [ oneSpace ]
		o.rightOperand.prepend [ oneSpace ]
	}

	def dispatch void format(WIfExpression i, extension IFormattableDocument document) {
		i.then.surround [
			oneSpace 
		]
		i.then.format
		i.^else.surround [
			oneSpace
		]
		i.^else.format
	}
	
	def dispatch void format(WSetLiteral s, extension IFormattableDocument document) {
		s.regionFor.keyword(WollokConstants.BEGIN_SET_LITERAL).prepend [ noSpace ]
		s.elements.forEach [ element, i |
			element.prepend [ oneSpace ]
			if (i == s.elements.length - 1) {
				element.append [ oneSpace ]
			} else {
				element.append [ noSpace ]		
			}
		]
		s.regionFor.keyword(WollokConstants.END_SET_LITERAL).append [ noSpace ]
	}

	def dispatch void format(WListLiteral l, extension IFormattableDocument document) {
		l.regionFor.keyword(WollokConstants.BEGIN_LIST_LITERAL).prepend [ noSpace ]
		l.elements.forEach [ element, i |
			element.prepend [ oneSpace ]
			if (i == l.elements.length - 1) {
				element.append [ oneSpace ]
			} else {
				element.append [ noSpace ]		
			}
		]
		l.regionFor.keyword(WollokConstants.END_LIST_LITERAL).append [ noSpace ]
	}
	
	def dispatch void format(WClosure c, extension IFormattableDocument document) {
		c.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).append [ newLine ]
		c.parameters.forEach [ parameter, i |
			if (i == c.parameters.length - 1) 
				parameter.append [ oneSpace ]
			else
				parameter.append [ noSpace ]
			if (i == 0) {
				parameter.prepend [ noSpace ].surround [ indent ]
			} else {
				parameter.prepend [ oneSpace ]		
			} 
		]
		c.regionFor.keyword("=>").append [ newLine ]
		c.surround [
			noSpace
		]
		c.expression => [
			prepend [ oneSpace ]
			surround [ indent ]
			format
		]
		c.regionFor.keyword(WollokConstants.END_EXPRESSION).prepend [ newLine ]
	}
	
	// TODO: implement for 
	/**
	 * WTest,
	 * WSuite, 
	 * WFixture, 
	 * WPackage, 
	 * WObjectLiteral, 
	 * WUnaryOperation, 
	 * WSuperInvocation, 
	 * WMixin, 
	 * WConstructor, 
	 * WSelfDelegatingConstructorCall, 
	 * WSuperDelegatingConstructorCall, 
	 * WConstructorCall, 
	 * WTry, 
	 * WCatch, 
	 * WReturnExpression, 
	 * WThrow, 
	 * WPostfixOperation
	 */
}
