({
	doInit: function(component, event, helper) {
        // Prepare a new record from template
        component.find("accRecordCreator").getNewRecord(
            "Account", // sObject type (objectApiName)
            null,      // recordTypeId
            false,     // skip cache?
             
            $A.getCallback(function() {
                var rec = component.get("v.newAcc");
                var error = component.get("v.newAccError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.sobjectType);
            })
            
        );
        var action = component.get("c.getPickListValues");
        var inputIndustry = component.find("InputAccountIndustry");
        var opts=[];
        action.setCallback(this, function(a) {
            opts.push({
                class: "optionClass",
                label: "--- None ---",
                value: ""
            });
            for(var i=0;i< a.getReturnValue().length;i++){
                opts.push({"class": "optionClass", label: a.getReturnValue()[i], value: a.getReturnValue()[i]});
            }
            inputIndustry.set("v.options", opts);
             
        });
        $A.enqueueAction(action); 
        
      
    },
    handleSaveContact: function(component, event, helper) 
    {
         var rec = component.get("v.simpleNewAcc");
         console.log("Data Entered",rec);

        var action = component.get("c.createAccount");
        action.setParams({account:rec});
        action.setCallback(this,function(actionResponse){
            component.set("v.accId",actionResponse.getReturnValue());
            console.log(actionResponse.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})