({
	doInit : function(component, event) {
		var prodList = component.get( "c.getProducts");
        prodList.setCallback(this,function(prod){
            		
                        component.set("v.listOfArts", prod.getReturnValue());
            //console.log(prod.getReturnValue());
                  		
                                    
                                });
         
        $A.enqueueAction(prodList);
	},
    getInput : function(component,event){
        var input = component.find("text1").get("v.value");
        console.log(input);
        component.set("v.textentered",input);
        var action = component.get("c.getMatchingAccounts");
        action.setParams({searchString:input});
        action.setCallback(this,function(actionResponse){
            component.set("v.listOfArts",actionResponse.getReturnValue());
            console.log(actionResponse.getReturnValue());
        });
        $A.enqueueAction(action);
        
    }
   
})