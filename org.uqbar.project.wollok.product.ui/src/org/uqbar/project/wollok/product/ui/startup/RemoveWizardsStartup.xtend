package org.uqbar.project.wollok.product.ui.startup

import java.util.ArrayList
import java.util.List
import org.eclipse.ui.PlatformUI
import org.eclipse.ui.internal.dialogs.WorkbenchWizardElement
import org.eclipse.ui.internal.wizards.AbstractExtensionWizardRegistry
import org.eclipse.ui.wizards.IWizardCategory
import org.eclipse.ui.wizards.IWizardDescriptor
import org.uqbar.project.wollok.ui.WollokUIStartup
import org.eclipse.ui.wizards.IWizardRegistry

/**
 * Programmatically hacks eclipse workbench to
 * remove unwanted wizards that will confuse users/students.
 * 
 * TODO: maybe we can have this configurable as a preference ?
 * 
 * @author jfernandes
 */
class RemoveWizardsStartup implements WollokUIStartup {
	
	override startup() { 
		PlatformUI.workbench.newWizardRegistry.removeWizards
		PlatformUI.workbench.exportWizardRegistry.removeWizards
		PlatformUI.workbench.importWizardRegistry.removeWizards
	}
	
	// reusable code

	def removeWizards(IWizardRegistry it) {
		(it as AbstractExtensionWizardRegistry).removeWizards
	}	
	
	def removeWizards(AbstractExtensionWizardRegistry registry) {
		val categories = registry.rootCategory.categories
		for (wizard : getAllWizards(categories)) {
	        if (!wizard.id.includeWizards) {
				val wizardElement = wizard as WorkbenchWizardElement
				registry.removeExtension(wizardElement.configurationElement.declaringExtension, #[wizardElement])
			}
		}
	}
	
	static val includeWizards = #["org\\.eclipse\\.ui\\..*", "org\\.uqbar\\.project\\.wollok\\..*"]
	def includeWizards(String id) {
		includeWizards.exists[id.matches(it)]
	}
	
	def List<IWizardDescriptor> getAllWizards(IWizardCategory[] categories) {
	  val results = new ArrayList<IWizardDescriptor>
	  for(wizardCategory : categories) {
	    results.addAll(wizardCategory.wizards)
	    results.addAll(getAllWizards(wizardCategory.categories))
	  }
	  results
	}
	
}