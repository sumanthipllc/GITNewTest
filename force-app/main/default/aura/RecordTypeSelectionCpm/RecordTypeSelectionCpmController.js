({
	
 
   /* On the component Load this function call the apex class method, 
    * which is return the list of RecordTypes of object 
    * and set it to the lstOfRecordType attribute to display record Type values
    * on ui:inputSelect component. */
 
   fetchListOfRecordTypes: function(component, event, helper) {
      var action = component.get("c.fetchRecordTypeValues");
      action.setCallback(this, function(response) {
          console.log(response.getReturnValue());
         component.set("v.lstOfRecordType", response.getReturnValue());
      });
      $A.enqueueAction(action);
   },
 
   /* In this "createRecord" function, first we have call apex class method 
    * and pass the selected RecordType values[label] and this "getRecTypeId"
    * apex method return the selected recordType ID.
    * When RecordType ID comes, we have call  "e.force:createRecord"
    * event and pass object API Name and 
    * set the record type ID in recordTypeId parameter. and fire this event
    * if response state is not equal = "SUCCESS" then display message on various situations.
    */
   createRecord: function(component, event, helper) {
      component.set("v.isOpen", true);
 
      var action = component.get("c.getRecTypeId");
      var recordTypeLabel = component.find("selectid").get("v.value");
      action.setParams({
         "recordTypeLabel": recordTypeLabel
      });
      action.setCallback(this, function(response) {
         var state = response.getState();
         if (state === "SUCCESS") {
             alert('rec1'+recordTypeLabel);
             if(recordTypeLabel === 'Sold To')
             {
                 alert('rec2'+recordTypeLabel);
try{
            $A.createComponent(
                "c:TestImage",{
                }, 
                
                function(newcomponent){
                    if (component.isValid()) {
                        var body = component.get("v.body");
                        body.push(newcomponent);
                        component.set("v.body", body);             
                    }
                }            
            );
            
        }catch(Err){
           //console.log(Err);
          
        } 
             }
             else{
            var createRecordEvent = $A.get("e.force:createRecord");
            var RecTypeID  = response.getReturnValue();
            createRecordEvent.setParams({
               "entityApiName": 'Account',
               "recordTypeId": RecTypeID
            });
            createRecordEvent.fire();
			}             
         } else if (state == "INCOMPLETE") {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
               "title": "Oops!",
               "message": "No Internet Connection"
            });
            toastEvent.fire();
             
         } else if (state == "ERROR") {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
               "title": "Error!",
               "message": "Please contact your administrator"
            });
            toastEvent.fire();
         }
      });
      $A.enqueueAction(action);
   },
    openWindow : function(component, event, helper) { 
        try{
            $A.createComponent(
                "c:TestImage",{
                }, 
                
                function(newcomponent){
                    if (component.isValid()) {
                        var body = component.get("v.body");
                        body.push(newcomponent);
                        component.set("v.body", body); 
                        component.set("v.isOpen", false);
                    }
                }            
            );
            
        }catch(Err){
           //console.log(Err);
          
        } 
    },
 
   closeModal: function(component, event, helper) {
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isOpen", false);
   },
 
   openModal: function(component, event, helper) {
      // set "isOpen" attribute to true to show model box
      component.set("v.isOpen", true);
   },
})