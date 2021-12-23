public with sharing class ContactTriggerHelper
{
	public static void markAccountWithStatus(List<Contact>  newContacts,String status){
		for(Contact newContact : newContacts){
			System.debug('nombre de la cuenta creada:' + Contact.FirstName);
			newContact.SyncStatus__c = status;
		}
	}

	public static void markRecordsToSync(Map<Id,Contact> previousValues, Map<Id,Contact>  newValues){
		for(Contact oldContact : previousValues.values()){
			Contact newContact = newValues.get(oldContact.Id);
			if(oldContact.Email != newContact.Email){
				newContact.SyncStatus__c = 'PENDING';
			}
		}
		System.debug('calling feature method:' );
		KAR_ContactPlatformCall.synchContacts(newValues.keySet());

	}

}