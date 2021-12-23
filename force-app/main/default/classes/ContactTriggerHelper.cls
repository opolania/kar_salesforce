public with sharing class ContactTriggerHelper
{
	public static void markAccountWithStatus(List<Contact>  newContacts,String status){
		for(Contact newContact : newContacts){
			System.debug('nombre de la cuenta creada:' + Contact.FirstName);
			newContact.SyncStatus__c = status;
		}
	}

	public static void markRecordsToSync(Map<Id,Contact> previousValues, Map<Id,Contact>  newValues){
		Set<Id> contactsIds = new Set<Id>();
		for(Contact oldContact : previousValues.values()){
			Contact newContact = newValues.get(oldContact.Id);
			if(oldContact.Email != newContact.Email){
				contactsIds.add(oldContact.Id);
			}

		}
		System.debug('calling feature method:' );
		if(contactsIds.size() > 0 ){
			System.enqueueJob(new KAR_ContactPlatformCall(contactsIds));
		}
		System.debug('end off trigger' );

	}

}