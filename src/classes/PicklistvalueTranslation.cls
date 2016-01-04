public  class PicklistvalueTranslation{

    public static String DataLoadPicklistValueTranslation(String objectname,String fieldname,String picklistvalue){
		If(String.IsNotEmpty(picklistvalue)){
		    Map<String,String> keyToValueMap = new Map<String,String>();
		    Map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe();
			try{
				Schema.DescribeSObjectResult obj = GlobalMap.get(objectname).getDescribe();
				Schema.DescribeFieldResult fieldResult = obj.Fields.getMap().get(fieldname).getDescribe();       
				List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
				for( Schema.PicklistEntry f : ple)
				{   
					keyToValueMap.put(f.getLabel(),f.getValue());
					//system.debug(f.getLabel() + '========' + f.getValue());
				}
				if(keyToValueMap.containsKey(picklistvalue)){
					return keyToValueMap.get(PicklistValue);
				}else{
					return PicklistValue;
				}
			}catch(Exception e){
				return PicklistValue;
			}	
		}else{
            return '';
        }
	}      
}