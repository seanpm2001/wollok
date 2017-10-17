/*
 * generated by Xtext
 */
package org.uqbar.project.wollok.formatting2

import com.google.inject.Inject
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument
import org.uqbar.project.wollok.WollokConstants
import org.uqbar.project.wollok.services.WollokDslGrammarAccess
import org.uqbar.project.wollok.wollokDsl.Import
import org.uqbar.project.wollok.wollokDsl.WAssignment
import org.uqbar.project.wollok.wollokDsl.WBinaryOperation
import org.uqbar.project.wollok.wollokDsl.WBlockExpression
import org.uqbar.project.wollok.wollokDsl.WCatch
import org.uqbar.project.wollok.wollokDsl.WClass
import org.uqbar.project.wollok.wollokDsl.WClosure
import org.uqbar.project.wollok.wollokDsl.WConstructor
import org.uqbar.project.wollok.wollokDsl.WConstructorCall
import org.uqbar.project.wollok.wollokDsl.WFile
import org.uqbar.project.wollok.wollokDsl.WFixture
import org.uqbar.project.wollok.wollokDsl.WIfExpression
import org.uqbar.project.wollok.wollokDsl.WLibraryElement
import org.uqbar.project.wollok.wollokDsl.WListLiteral
import org.uqbar.project.wollok.wollokDsl.WMemberFeatureCall
import org.uqbar.project.wollok.wollokDsl.WMethodDeclaration
import org.uqbar.project.wollok.wollokDsl.WNamedObject
import org.uqbar.project.wollok.wollokDsl.WObjectLiteral
import org.uqbar.project.wollok.wollokDsl.WPostfixOperation
import org.uqbar.project.wollok.wollokDsl.WProgram
import org.uqbar.project.wollok.wollokDsl.WReturnExpression
import org.uqbar.project.wollok.wollokDsl.WSetLiteral
import org.uqbar.project.wollok.wollokDsl.WSuite
import org.uqbar.project.wollok.wollokDsl.WTest
import org.uqbar.project.wollok.wollokDsl.WTry
import org.uqbar.project.wollok.wollokDsl.WUnaryOperation
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
		p.prepend [ noSpace ]
		p.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).append[ newLine ]
		p.elements.forEach [
			surround [ indent ]
			format
			append [ newLine ]
		]
		p.regionFor.keyword(WollokConstants.END_EXPRESSION).append[ newLine ]
	}

	def dispatch void format(WClass c, extension IFormattableDocument document) {
		c.regionFor.keyword(WollokConstants.CLASS).prepend [ noSpace ]
		c.regionFor.keyword(WollokConstants.CLASS).append [ oneSpace ]
		c.regionFor.keyword(WollokConstants.INHERITS).surround [ oneSpace ]
		c.regionFor.feature(WCLASS__PARENT).surround [ oneSpace ]
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
		o.regionFor.keyword(WollokConstants.WKO).prepend [ noSpace ]
		o.regionFor.keyword(WollokConstants.WKO).append [ oneSpace ]
		o.regionFor.keyword(WollokConstants.INHERITS).surround [ oneSpace ]
		o.regionFor.feature(WCLASS__PARENT).surround [ oneSpace ]
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
		m.regionFor.feature(WMETHOD_DECLARATION__EXPRESSION_RETURNS).surround([ oneSpace ])
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
			prepend [ oneSpace ]
			format
			append [ newLine ]
		]
	}
	
	def dispatch void format(WBlockExpression b, extension IFormattableDocument document) {
		b.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION) => [
			append[ newLine ]
		]
		b.expressions.forEach [
			surround [ indent ]
			format
			append [ newLine ]
		]
	}

	def dispatch void format(WMemberFeatureCall c, extension IFormattableDocument document) {
		if (c.previousHiddenRegion.length > 1) {
			c.prepend [ oneSpace ]
		}
		c.memberCallTarget => [
			append [ noSpace ]
			if (operandShouldBeFormatted) {
				format
			}
		]
		c.regionFor.keyword(".").surround [ noSpace ]
		c.regionFor.feature(WMEMBER_FEATURE_CALL__NULL_SAFE).surround [ noSpace ]
		c.regionFor.feature(WMEMBER_FEATURE_CALL__FEATURE).surround [ noSpace ]
		c.memberCallArguments.forEach [ arg, i |
			if (i == 0) {
				arg.prepend [ noSpace ]
			} else {
				arg.prepend [ oneSpace ]
			}
			arg.append [ noSpace ]
			arg.format
		]
	}
	
	def dispatch void format(WAssignment a, extension IFormattableDocument document) {
		a.feature.surround [ oneSpace ]
		a.feature.format
		a.value.prepend [ oneSpace ]
		a.value.format
		a.append[ newLine ]
	}
	
	def dispatch void format(WBinaryOperation o, extension IFormattableDocument document) {
		o.leftOperand.append [ oneSpace ]
		if (o.leftOperand.operandShouldBeFormatted) {
			o.leftOperand.format
		}
		if (o.rightOperand.operandShouldBeFormatted) {
			o.rightOperand.format
		}
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

	def dispatch void format(WTry t, extension IFormattableDocument document) {
		t.expression.prepend [ oneSpace ]
		if (!(t.expression instanceof WBlockExpression)) {
			t.expression.surround [ newLine ; indent ]
		}
		t.expression.format
		t.catchBlocks.forEach [ format ]
		t.alwaysExpression?.surround [ oneSpace ]
		if (!(t.alwaysExpression instanceof WBlockExpression)) {
			t.alwaysExpression?.surround [ newLine ; indent ]
		}
		t.alwaysExpression?.format
		t.append [ newLine ]
	}
	
	def dispatch void format(WCatch c, extension IFormattableDocument document) {
		c.surround [ oneSpace ]
		c.exceptionVarName.surround [ oneSpace ]
		c.regionFor.keyword(":").surround [ oneSpace ]
		c.exceptionType.append [ oneSpace ]
		c.expression.prepend [ oneSpace ]
		if (!(c.expression instanceof WBlockExpression)) {
			c.expression.surround [ newLine ; indent ]
		}
		
		c.expression.format
	}
	
	def dispatch void format(WSetLiteral s, extension IFormattableDocument document) {
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
		val parametersCount = c.parameters.length
		c.parameters.forEach [ parameter, i |
			if (i == parametersCount - 1) 
				parameter.append [ oneSpace ]
			else
				parameter.append [ noSpace ]
			if (i == 0) {
				parameter.prepend [ noSpace ].surround [ indent ]
			} else {
				parameter.prepend [ oneSpace ]		
			} 
		]
		c.regionFor.keyword("=>") => [
			append [ newLine ]
			if (parametersCount == 0)
				surround [ indent ]
		]
		
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

	def dispatch void format(WConstructor c, extension IFormattableDocument document) {
		c.regionFor.keyword(WollokConstants.CONSTRUCTOR).append [ noSpace ]
		c.parameters.forEach [ parameter, i |
			parameter.append [ noSpace ]
			if (i == 0) {
				parameter.prepend [ noSpace ]
			} else {
				parameter.prepend [ oneSpace ]		
			} 
		]
		c.regionFor.feature(WNAMED__NAME).append [ noSpace ]
		c.surround [ newLine ]
		c.expression => [
			surround [ oneSpace ]
			format
		]
	}

	def dispatch void format(WConstructorCall c, extension IFormattableDocument document) {
		c.prepend [ indent ]
		c.regionFor.keyword(WollokConstants.INSTANTIATION).append [ oneSpace ]
		c.regionFor.keyword(WollokConstants.BEGIN_PARAMETER_LIST).prepend [ noSpace ]
		c.regionFor.keyword(WollokConstants.END_PARAMETER_LIST).append [ noSpace ]
		c.append [ newLine ]
		c.arguments.forEach [ arg, i |
			if (i == 0) {
				arg.prepend [ noSpace ]
			} else {
				arg.prepend [ oneSpace ]
			}
			arg.append [ noSpace ]
			arg.format
		]
	}

	def dispatch void format(WTest t, extension IFormattableDocument document) {
		t.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).prepend [ oneSpace ].append[ newLine ]
		t.elements.forEach [
			surround [ indent ; newLine ]
			format
		]
		t.regionFor.keyword(WollokConstants.END_EXPRESSION).append[ noSpace ; newLine ]
	}

	def dispatch void format(WReturnExpression r, extension IFormattableDocument document) {
		r.prepend [ noSpace ]
		r.expression.format
		r.append [ newLine ]
	}

	def dispatch void format(WSuite s, extension IFormattableDocument document) {
		s.regionFor.keyword(WollokConstants.SUITE).append [ oneSpace ]
		s.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).append[ newLine ].prepend [ oneSpace ]
		s.interior [ indent ]
		s.variableDeclarations.forEach [ format ]
		s.fixture.format
		s.methods.forEach [ format ]
		s.tests.forEach [ format ]
		s.regionFor.keyword(WollokConstants.END_EXPRESSION).surround[ newLine ]
	}

	def dispatch void format(WFixture f, extension IFormattableDocument document) {
		f.regionFor.keyword(WollokConstants.FIXTURE).append [ oneSpace ]
		f.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).append[ newLine ].prepend [ oneSpace ]
		f.interior [ indent ]
		f.elements.forEach [ format ]
		f.regionFor.keyword(WollokConstants.END_EXPRESSION).surround[ newLine ]
	}

	def dispatch void format(WPostfixOperation o, extension IFormattableDocument document) {
		o.operand.append [ noSpace ]
	}

	def dispatch void format(WObjectLiteral o, extension IFormattableDocument document) {
		o.regionFor.keyword(WollokConstants.BEGIN_EXPRESSION).append[ newLine ].prepend [ oneSpace ]
		o.members.forEach [
			surround [ indent ]
			format
			append [ newLine ]
		]
	}

	def dispatch void format(WUnaryOperation o, extension IFormattableDocument document) {
		o.interior [ noSpace ]
		o.operand.surround [ noSpace ]
	}

	def dispatch operandShouldBeFormatted(EObject o) { false }
	def dispatch operandShouldBeFormatted(WMemberFeatureCall c) { true }
	def dispatch operandShouldBeFormatted(WUnaryOperation o) { true }
	def dispatch operandShouldBeFormatted(WBinaryOperation o) { true }
	def dispatch operandShouldBeFormatted(WListLiteral l) { true }
	def dispatch operandShouldBeFormatted(WSetLiteral l) { true }
	
	// TODO: implement for 
	/**
	 * WPackage, 
	 * WSuperInvocation, 
	 * WMixin, 
	 * WSelfDelegatingConstructorCall, 
	 * WSuperDelegatingConstructorCall, 
	 * WThrow, 
	 */
}
