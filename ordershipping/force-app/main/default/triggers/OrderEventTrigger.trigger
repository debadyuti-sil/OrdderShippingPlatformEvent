trigger OrderEventTrigger on Order_Event__e (after insert) {
    List<Task> eventTasks = new List<Task>();
    for(Order_Event__e event : Trigger.new){
        if(event.Has_Shipped__c){
            Task newTask = new Task();
            newTask.Priority = 'Medium';
            newTask.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            newTask.OwnerId = event.CreatedById;
            eventTasks.add(newTask);
        }
    }
    if(!eventTasks.isEmpty()){
        insert eventTasks;
    }
}