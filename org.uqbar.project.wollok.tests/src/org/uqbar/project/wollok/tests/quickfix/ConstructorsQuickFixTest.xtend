package org.uqbar.project.wollok.tests.quickfix

import org.junit.Test
import org.uqbar.project.wollok.ui.Messages

class ConstructorsQuickFixTest extends AbstractWollokQuickFixTestCase {
	
	@Test
	def addOneConstructorsFromSuperclass(){
		val initial = #['''
			class MyClass{
				const y
				constructor(x){
					y = x
				}
				
				method someMethod(){
					return null
				}
			}
			
			object aWKO inherits MyClass {
			}
		''']

		val result = #['''
			class MyClass{
				const y
				constructor(x){
					y = x
				}
				
				method someMethod(){
					return null
				}
			}
			
			object aWKO inherits MyClass(x)  {
			}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_add_constructors_superclass_name)
	}

	@Test
	def createConstructorInSuperclassWithEnter(){
		val initial = #['''
			class MyClass{
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']

		val result = #['''
			class MyClass{
			
				constructor(param1){
					//TODO: Autogenerated Code ! 
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_superclass_name)
	}

	@Test
	def createConstructorInSuperclassWithoutChars(){
		val initial = #['''
			class MyClass{}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']

		val result = #['''
			class MyClass{
				constructor(param1){
					//TODO: Autogenerated Code ! 
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_superclass_name)
	}

	@Test
	def createConstructorInSuperclassWithSingleChar(){
		val initial = #['''
			class MyClass{ }
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']

		val result = #['''
			class MyClass{ 
				constructor(param1){
					//TODO: Autogenerated Code ! 
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_superclass_name)
	}

	@Test
	def createConstructorInSuperclassWithMethods(){
		val initial = #['''
			class MyClass{
				method oneMethod() {
					console.println("hello")
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']

		val result = #['''
			class MyClass{
				constructor(param1){
					//TODO: Autogenerated Code ! 
				}
				method oneMethod() {
					console.println("hello")
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_superclass_name)
	}

	@Test
	def createConstructorInSuperclassWithConstructorsAndMethods(){
		val initial = #['''
			class MyClass{
				constructor() {
					
				}
				
				method oneMethod() {
					console.println("hello")
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']

		val result = #['''
			class MyClass{
				constructor() {
					
				}
				constructor(param1){
					//TODO: Autogenerated Code ! 
				}
				
				method oneMethod() {
					console.println("hello")
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_superclass_name)
	}

	@Test
	def createConstructorInSuperclassWithHardDefinition(){
		val initial = #['''
			class MyClass{
				var a = 1
				
				
				var b = 2
				var c = 3
				
				constructor() {}
				constructor(_a, _b, _c, _d) {
				}
				
				
				
				
				method oneMethod() {
					console.println("hello")
				}
				
				
				method anotherMethod() {
					a = a + 1
					b = b + 1
					c = c + 1
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']

		val result = #['''
			class MyClass{
				var a = 1
				
				
				var b = 2
				var c = 3
				
				constructor() {}
				constructor(_a, _b, _c, _d) {
				}
				constructor(param1){
					//TODO: Autogenerated Code ! 
				}
				
				
				
				
				method oneMethod() {
					console.println("hello")
				}
				
				
				method anotherMethod() {
					a = a + 1
					b = b + 1
					c = c + 1
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_superclass_name)
	}

	@Test
	def createConstructorInSuperclassWithConstructorsAndMethodsNoEnter(){
		val initial = #['''
			class MyClass{
				constructor() {
					
				}
				method oneMethod() {
					console.println("hello")
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']

		val result = #['''
			class MyClass{
				constructor() {
					
				}
				constructor(param1){
					//TODO: Autogenerated Code ! 
				}
				method oneMethod() {
					console.println("hello")
				}
			}
			
			class MySubclass inherits MyClass {
				const y
				
				constructor(x) = super(x) {
					y = x
				}
			}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_superclass_name)
	}

	@Test
	def removeDuplicatedConstructor(){
		val initial = #['''
			class MyClass {
				const y
				
				constructor(x) {
					y = x
				}
				
				constructor(x) {
					y = x
				}
			}
		''']

		val result = #['''
			class MyClass {
				const y
				
				
				
				constructor(x) {
					y = x
				}
			}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_constructor_name, 2)
	}

	@Test
	def addNewConstructorInRefClassNoParams(){
		val initial = #[
		'''
		class A {
			const y
			constructor(_y){
				y = _y
			}
		
			method someMethod(){
				return null
			}
		}
		
		class B {
			method b() {
				const a = new A()
				console.println(a.toString())
			}
		}
		''']

		val result = #[
		'''
		class A {
			const y
			constructor(_y){
				y = _y
			}
			constructor() {
				//TODO: Autogenerated Code ! 
			}
		
			method someMethod(){
				return null
			}
		}
		
		class B {
			method b() {
				const a = new A()
				console.println(a.toString())
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_class_name)
	}
	
	@Test
	def addNewConstructorInRefClassOneParam(){
		val initial = #[
		'''
		class A {
			const y = 0
			method someMethod(){
				return y
			}
		}
		
		class B {
			method b() {
				const a = new A("hola")
				console.println(a.toString())
			}
		}
		''']

		val result = #[
		'''
		class A {
			const y = 0
			constructor(param1) {
				//TODO: Autogenerated Code ! 
			}
			method someMethod(){
				return y
			}
		}
		
		class B {
			method b() {
				const a = new A("hola")
				console.println(a.toString())
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_class_name)
	}
	
	@Test
	def addNewConstructorInRefClassSeveralParams(){
		val initial = #[
		'''
		class A {
			const y = 0
			method someMethod(){
				return y
			}
		}
		
		class B {
			method b() {
				const a = new A("hola", 1)
				console.println(a.toString())
			}
		}
		''']

		val result = #[
		'''
		class A {
			const y = 0
			constructor(param1, param2) {
				//TODO: Autogenerated Code ! 
			}
			method someMethod(){
				return y
			}
		}
		
		class B {
			method b() {
				const a = new A("hola", 1)
				console.println(a.toString())
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_create_constructor_class_name)
	}

	@Test
	def adjustConstructorCallParams(){
		val initial = #[
		'''
		class A {
			var y
			constructor(_y) {
				y = _y
			}
		}
		class B {
			method b() {
				const a = new A("hola", 1)
				console.println(a.toString())
			}
		}
		''']

		val result = #[
		'''
		class A {
			var y
			constructor(_y) {
				y = _y
			}
		}
		class B {
			method b() {
				const a = new A("hola")
				console.println(a.toString())
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_adjust_constructor_call_name)
	}

	@Test
	def adjustConstructorCallParams2(){
		val initial = #[
		'''
		class A {
			var y
			constructor(_x, _y, _z) {
				y = _y
			}
		}
		class B {
			method b() {
				const a = new A("hola", 1, 8, true)
				console.println(a.toString())
			}
		}
		''']

		val result = #[
		'''
		class A {
			var y
			constructor(_x, _y, _z) {
				y = _y
			}
		}
		class B {
			method b() {
				const a = new A("hola", 1, 8)
				console.println(a.toString())
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_adjust_constructor_call_name)
	}

	@Test
	def adjustConstructorCallParams3(){
		val initial = #[
		'''
		class A {
			var y
			constructor(_y) {
				y = _y
			}
		}
		class B {
			method b() {
				const a = new A("hola", 1, 8, true)
				console.println(a.toString())
			}
		}
		''']

		val result = #[
		'''
		class A {
			var y
			constructor(_y) {
				y = _y
			}
		}
		class B {
			method b() {
				const a = new A("hola")
				console.println(a.toString())
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_adjust_constructor_call_name)
	}

	@Test
	def adjustConstructorCallParams4(){
		val initial = #[
		'''
		class A {
			var y
			constructor(_x, _y, _z, _t) {
				y = _y
			}
		}
		class B {
			method b() {
				const a = new A("hola")
				console.println(a.toString())
			}
		}
		''']

		val result = #[
		'''
		class A {
			var y
			constructor(_x, _y, _z, _t) {
				y = _y
			}
		}
		class B {
			method b() {
				const a = new A("hola", _y, _z, _t)
				console.println(a.toString())
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_adjust_constructor_call_name)
	}

	@Test
	def adjustConstructorCallParams5(){
		val initial = #[
		'''
		class A {
			const y = 0
			method y() = y
		}
		class B {
			method b() {
				const a = new A("hola", 1)
				console.println(a.toString())
			}
		}
		''']

		val result = #[
		'''
		class A {
			const y = 0
			method y() = y
		}
		class B {
			method b() {
				const a = new A()
				console.println(a.toString())
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_adjust_constructor_call_name)
	}

	@Test
	def removeUnusedInitializationForVar(){
		val initial = #[
		'''
		class A {
			var valor = 0
			constructor() {
				valor = 1
			}
			constructor(_a) {
				valor = _a
			}
		}
		''']

		val result = #[
		'''
		class A {
			var valor
			constructor() {
				valor = 1
			}
			constructor(_a) {
				valor = _a
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_initialization_name)
	}
	
	@Test
	def removeUnusedInitializationForConst(){
		val initial = #[
		'''
		class A {
			const valor = 0
			constructor() {
				valor = 1
			}
			constructor(_a) {
				valor = _a
			}
		}
		''']

		val result = #[
		'''
		class A {
			const valor
			constructor() {
				valor = 1
			}
			constructor(_a) {
				valor = _a
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_initialization_name)
	}

	@Test
	def removeUnusedInitializationForVar2(){
		val initial = #[
		'''
		class Ave {
			var energia = 1
			var saludo = "Hola"
			constructor() {
				energia = 4
			}
			constructor(_saludo) = self() {
				saludo = _saludo
			}
		}
		''']

		val result = #[
		'''
		class Ave {
			var energia
			var saludo = "Hola"
			constructor() {
				energia = 4
			}
			constructor(_saludo) = self() {
				saludo = _saludo
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_initialization_name)
	}

	@Test
	def removeUnexistentAttributeInConstructorCall(){
		val initial = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energiaz = 100,   saludo = "Que onda?")
			}
		}
		''']

		val result = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(saludo = "Que onda?")
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_attribute_initialization_name)
	}

	@Test
	def removeUnexistentAttributeInConstructorCall2(){
		val initial = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 100, pavlov = 2, saludo = "Que onda?")
			}
		}
		''']

		val result = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 100, saludo = "Que onda?")
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_attribute_initialization_name)
	}

	@Test
	def removeUnexistentAttributeInConstructorCall3(){
		val initial = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(pavlov = 2, energia = 100, saludo = "Que onda?")
			}
		}
		''']

		val result = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 100, saludo = "Que onda?")
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_attribute_initialization_name)
	}
	
	@Test
	def removeUnexistentAttributeInConstructorCall4(){
		val initial = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(pavlov = 2)
			}
		}
		''']

		val result = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave()
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_attribute_initialization_name)
	}	

	@Test
	def removeUnexistentAttributeInConstructorCall5(){
		val initial = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 2,   pavlov = 2)
			}
		}
		''']

		val result = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 2)
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_attribute_initialization_name)
	}	

	@Test
	def removeUnexistentAttributeInConstructorCall6(){
		val initial = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 2,pavlov = 2)
			}
		}
		''']

		val result = #[
		'''
		class Ave {
			const energia = 1
			const saludo = "Hola"
			method energiaCalculada() = saludo.size() + energia
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 2)
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_remove_attribute_initialization_name)
	}	

	@Test
	def addInitializationsInConstructorCall(){
		val initial = #[
		'''
		class Ave {
			var energia
			var saludo
			var color
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 2)
			}
		}
		''']

		val result = #[
		'''
		class Ave {
			var energia
			var saludo
			var color
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 2, saludo = value, color = value)
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_add_missing_initializations_name, 4, "You must provide initial value to the following references: saludo, color")
	}	

	@Test
	def addInitializationsInConstructorCall2(){
		val initial = #[
		'''
		class Ave {
			var energia
			const saludo = 0
			var color
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 2)
			}
		}
		''']

		val result = #[
		'''
		class Ave {
			var energia
			const saludo = 0
			var color
		}
		object aveBuilder {
			method construirAve() {
				return new Ave(energia = 2, color = value)
			}
		}
		''']
		assertQuickfix(initial, result, Messages.WollokDslQuickFixProvider_add_missing_initializations_name, 4, "You must provide initial value to the following references: color")
	}
	
}