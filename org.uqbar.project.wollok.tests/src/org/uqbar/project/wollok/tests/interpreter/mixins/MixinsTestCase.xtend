package org.uqbar.project.wollok.tests.interpreter.mixins

import org.uqbar.project.wollok.tests.interpreter.AbstractWollokInterpreterTestCase
import org.junit.Test

/**
 * 
 * @author jfernandes
 */
class MixinsTestCase extends AbstractWollokInterpreterTestCase {
	

	def String toStringFixture() {
		'''
		class Persona {
			var edad = 10
			
			method envejecer(cuanto) {
				edad += cuanto
			}
		}
		
		mixin EnvejeceDoble {
			method envejecer(cuanto) {
				super(cuanto * 2)
			}
		}
		
		mixin EnvejeceTriple {
			method envejecer(cuanto) {
				super(cuanto * 3)
			}
		}
		'''	
	}
	
	@Test
	def void toStringMixedMethodContainer1Mixin() {
		'''
		«toStringFixture»
		test "toString de un mixed method container con 1 mixin" {
			const pm = new Persona() with EnvejeceDoble
			assert.equals(pm.toString(), "Persona with EnvejeceDoble")
		}
		'''.interpretPropagatingErrors
	}
	
	@Test
	def void toStringMixedContainerWith2Mixins() {
		'''
		«toStringFixture»
		test "toString de un mixed method container con 2 mixins" {
			const pm = new Persona() with EnvejeceDoble with EnvejeceTriple
			assert.equals(pm.toString(), "Persona with EnvejeceDoble with EnvejeceTriple")
		}
		'''.interpretPropagatingErrors
	}
}