@IsTest
public with sharing class ContactTriggerTest
{
	@IsTest
	public static void testCourses(){
		List<Course__c> courses = createCourses();
		updatCourseStatus();
	}

	private static void updatCourseStatus()
	{
		List<Course__c> existingCourses = [SELECT id,Name,status__c FROM Course__c];
		Integer i = 1;
		for(Course__c course:existingCourses){
			course.Name = course.Name + '' + i;
			course.status__c = 'finished';
		}
		update existingCourses;
	}

	private static List<Course__c> createCourses(){
		List<Course__c> courses = new List<Course__c>();
		for(Integer i = 0 ; i < 100 ; i++){
			Course__c course = new Course__c();
			course.Name = 'curso nuevo ' + i;
			course.status__c = 'Started';
			courses.add(course);
		}
		insert courses;
		return courses;
	}


}