public with sharing class ContactTriggerHandler
{
	public static void beforeInsert(List<Contact> newValues){
		//System.debug('nuevos valores lista:' +newValues);
		ContactTriggerHelper.markAccountWithStatus(newValues,'PENDING');
	}

	public static void beforeUpdate(Map<Id,Contact> previousValues, Map<Id,Contact>  newValues)
	{
		ContactTriggerHelper.markRecordsToSync(previousValues,newValues);
	}
}