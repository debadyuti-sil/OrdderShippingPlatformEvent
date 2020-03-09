@isTest
public with sharing class OrderEventTest {
        @isTest 
        static void isTaskCreated() {
            Order_Event__e event = new Order_Event__e();
            event.Has_Shipped__c = true;
            event.Order_Number__c = '0123456789';
            Test.startTest();
            // Call method to publish events
            Database.SaveResult sr = EventBus.publish(event);

            Test.stopTest();
        
             // Verify that the publish was successful
            System.assertEquals(true, sr.isSuccess());
            // Inspect publishing result 
            List<Task> tasks = [Select id,Priority,Subject,OwnerId From Task Where Subject = 'Follow up on shipped order 0123456789'];
            System.assertEquals(1, tasks.size());
        }
}
