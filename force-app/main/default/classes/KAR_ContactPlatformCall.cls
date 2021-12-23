public with sharing class KAR_ContactPlatformCall
{

	@Future(Callout=true)
	public static void synchContacts(Set<Id> contactsIds){

		HttpRequest request = new httprequest();
		List<contactEndpoint__c> endpoints = [select endpointurl__c from contactEndpoint__c];

		if(endpoints.size() == 0){
			throw new EndpointException('No end point configured on contactEndpoint__c custom setting');
		}
		if(endpoints.size() > 1){
			throw new EndpointException('too many endpoints configured on contactEndpoint__c custom setting,configure only 1 ');
		}
		String endpoint = '';
		if(endpoints.size() == 1){
			endpoint = endpoints.get(0).endpointurl__c;
		}



		String endpointULR = [select endpointurl__c from contactEndpoint__c][0].endpointurl__c;
		request.setEndpoint(endpointULR);
		//request.setEndpoint('callout:SharePoint_credentials/c2c095a8-a041-4c30-93db-8f6b6c07e3df/oauth2/token');
		request.setMethod('PUT');
		request.setTimeout(20000);
		request.setHeader('Content-Type', 'application/json');
		List<Contact> contacts = [SELECT patientsId__c,Email,FirstName,LastName FROM Contact WHERE Id IN :contactsIds and SyncStatus__c = 'PENDING'];
		System.debug('contacts to be sent:' +JSON.serialize(getExternalContactVos(contacts)));
		request.setBody(JSON.serialize(getExternalContactVos(contacts)));

		httpResponse Response = new http().send(request);
		system.debug('contacts created: ' + response.getStatusCode());

	}

	public static List<ExternalContactVO> getExternalContactVos(List<Contact>contacts)
	{
		List<ExternalContactVO> externalContactVOS = new List<KAR_ContactPlatformCall.ExternalContactVO>();
		for(Contact contact:contacts){
			ExternalContactVO externalContactVO = new ExternalContactVO();
			externalContactVO.id = contact.patientsId__c;
			externalContactVO.email =contact.Email;
			externalContactVO.firstName=contact.FirstName;
			externalContactVO.lastName = contact.LastName;
			externalContactVOS.add(externalContactVO);
		}
		return externalContactVOS;
	}

	public class EndpointException extends Exception {}
	public class ExternalContactVO{
		public String id;	//1
		public String firstName;	//omar
		public String lastName;	//polania
		public String email;	//email1@email.com

		public ExternalContactVO parse(String json)
		{
			return (ExternalContactVO) System.JSON.deserialize(json, KAR_ContactPlatformCall.externalContact.class);
		}
	}

}