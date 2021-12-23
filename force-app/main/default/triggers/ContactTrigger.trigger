Trigger ContactTrigger on Contact (before update, before insert)
{
	if(Trigger.isBefore){
		if(Trigger.isInsert){
			ContactTriggerHandler.beforeInsert(Trigger.new);
		}
	}
	if(Trigger.isBefore){
		if(Trigger.isUpdate){
			ContactTriggerHandler.beforeUpdate(Trigger.oldMap,Trigger.newMap);
		}
	}
}