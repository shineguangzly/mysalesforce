public with sharing class JJ_CN_DCR_Util {
    
    public JJ_CN_DCR_Util(){}
    
    /**
    *获得医生的external Id
    *
    **/
    public static String getExternalId(){
        
     /*  JJ_CN_DCR_Setting__c workSetting = JJ_CN_DCR_Setting__c.getValues('Account External ID');
       Integer  temp = (Integer)workSetting.JJ_CN_Account_External_ID__c;  
       workSetting.JJ_CN_Account_External_ID__c = temp +1;
       upsert workSetting;
       string ExternalID = Integer.valueOf(temp) + '';*/
        List<JJ_CN_DCR_Setting__c> list_dcr = new List<JJ_CN_DCR_Setting__c>();
		for (JJ_CN_DCR_Setting__c customSetting : [SELECT id, name,JJ_CN_Account_External_ID__c  FROM JJ_CN_DCR_Setting__c
		                                       	 limit 1 FOR UPDATE
		                                       ])
		{	
		    list_dcr.add(customSetting);
		
		}
		JJ_CN_DCR_Setting__c dcrsetObj = list_dcr.get(0);
		Integer  temp = (Integer)dcrsetObj.JJ_CN_Account_External_ID__c;  
		    
		dcrsetObj.JJ_CN_Account_External_ID__c = temp +1;
		upsert dcrsetObj;
       return temp + '';
    }
    
     /**
    *创建科室并分配territory  挂牌科室
    *
    **/
    public static Id createHospitalDep(Boolean isKaAndMSL, String HospitalId, String hospitalExternlaId, String hospitalName, String departmentKey,Id accountHD,String territoryName){
        Id accountId = null;
        Account a = new Account();
		a.recordtypeId = accountHD;
		a.Primary_Parent_vod__c = HospitalId;
		//String depTemp = getPickListLabel(departmentKey);
		//a.Name = hospitalName + '_' + depTemp;
		a.Name = hospitalName + '_' + departmentKey;
		//a.External_ID_vod__c = hospitalExternlaId + '_' + getPickListKey(departmentName);
		a.External_ID_vod__c = hospitalExternlaId + '_' + departmentKey;
		upsert a External_ID_vod__c;
		if(isKaAndMSL)
		{
			Account_Territory_Loader_vod__c atlObj = new Account_Territory_Loader_vod__c();
			atlObj.Account_vod__c = a.Id;
			atlObj.Territory_To_Add_vod__c = territoryName;
			atlObj.External_ID_vod__c = hospitalExternlaId + '_' + departmentKey;
			upsert atlObj External_ID_vod__c;
		}
		accountId = a.Id;
		system.debug('accountId==========='+accountId);
        return accountId;
    }
    
    
    
    /**
    *account department key to label
    *JJ_CN_Department__c
    **/
    public static String  getPickListLabel(String Key)
	{
		Map<String,String> keyToValueMap = new Map<String,String>();
	    
	    String LabelStr = '';    
	        
	    Schema.DescribeFieldResult fieldResult = Account.JJ_CN_Department__c.getDescribe();
	    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	        
	    for( Schema.PicklistEntry f : ple)
	    {	
	    	keyToValueMap.put(f.getValue() , f.getLabel());
	    }       
	    
	    LabelStr = keyToValueMap.get(Key);
	    
	    return LabelStr;
	}
	
	/**
    *account admin title  key to label
    *JJ_CHN_Administrative_Title__c
    **/
    public static String  getAdminTitlePickListLabel(String Key)
	{
		Map<String,String> keyToValueMap = new Map<String,String>();
	    
	    String LabelStr = '';    
	        
	    Schema.DescribeFieldResult fieldResult = Account.JJ_CHN_Administrative_Title__c.getDescribe();
	    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	        
	    for( Schema.PicklistEntry f : ple)
	    {	
	    	keyToValueMap.put(f.getValue() , f.getLabel());
	    }       
	    
	    LabelStr = keyToValueMap.get(Key);
	    
	    return LabelStr;
	}
	
	
	/**
    *account cv local academy  key to label
    *JJ_CN_CV_Local_Academy__c
    **/
    public static String  getCVAcademyPickListLabel(String Key)
	{
		Map<String,String> keyToValueMap = new Map<String,String>();
	    
	    String LabelStr = '';    
	        
	    Schema.DescribeFieldResult fieldResult = Account.JJ_CN_CV_Local_Academy__c.getDescribe();
	    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	        
	    for( Schema.PicklistEntry f : ple)
	    {	
	    	keyToValueMap.put(f.getValue() , f.getLabel());
	    }       
	    
	    LabelStr = keyToValueMap.get(Key);
	    
	    return LabelStr;
	}
	
	
	/**
    *account professional  label to  key 
    *JJ_CHN_Professional_Title__c
    **/
    public static String  getProfessionalLabelToKey(String label)
	{
		Map<String,String> keyToValueMap = new Map<String,String>();
	    
	    String LabelStr = '';    
	        
	    Schema.DescribeFieldResult fieldResult = Account.JJ_CHN_Professional_Title__c.getDescribe();
	    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	        
	    for( Schema.PicklistEntry f : ple)
	    {	
	    	keyToValueMap.put(f.getLabel(),f.getValue());
	    }       
	    
	    LabelStr = keyToValueMap.get(label);
	    
	    return LabelStr;
	}
	
	/**
    *account admin title  key to label
    *JJ_CHN_Administrative_Title__c
    **/
    public static String  getAdminTitleLabelToKey(String label)
	{
		Map<String,String> keyToValueMap = new Map<String,String>();
	    
	    String LabelStr = '';    
	        
	    Schema.DescribeFieldResult fieldResult = Account.JJ_CHN_Administrative_Title__c.getDescribe();
	    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	        
	    for( Schema.PicklistEntry f : ple)
	    {	
	    	keyToValueMap.put( f.getLabel() , f.getValue());
	    }       
	    
	    LabelStr = keyToValueMap.get(label);
	    
	    return LabelStr;
	}
	
	/**
    *account gender  key to label
    *Gender_vod__c
    **/
    public static String  getGenderLabelToKey(String label)
	{
		Map<String,String> keyToValueMap = new Map<String,String>();
	    
	    String LabelStr = '';    
	        
	    Schema.DescribeFieldResult fieldResult = Account.Gender_vod__c.getDescribe();
	    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	        
	    for( Schema.PicklistEntry f : ple)
	    {	
	    	keyToValueMap.put( f.getLabel() , f.getValue());
	    }       
	    
	    LabelStr = keyToValueMap.get(label);
	    
	    return LabelStr;
	}
	
	/**
    *所属医院 picklist 仅取到当前territory
    **/
    public static List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        String lang = userinfo.getLanguage();
        if(lang.equals('zh_CN'))
        	options.add(new SelectOption('','--无--'));
        else
        	options.add(new SelectOption('','--none--'));
        for(Account aObj : [Select Id,name from Account where RecordType.name = 'Hospital_vod'])
        	options.add(new SelectOption(aObj.id,aObj.name)); 
        return options;
    }
    
    /**
    *获取user当前territory的所有医生 不包含cv医生
    **/
    public static List<SelectOption> getDoctorItems() {
        List<SelectOption> options = new List<SelectOption>();
        String lang = userinfo.getLanguage();
        if(lang.equals('zh_CN'))
        	options.add(new SelectOption('','--无--'));
        else
        	options.add(new SelectOption('','--none--'));
        for(Account aObj : [Select Id,name from Account where RecordType.name = 'Professional_vod'])
        	options.add(new SelectOption(aObj.id,aObj.name)); 
        return options;
    }
    
    /**
    *获取user当前territory的所有医生  包含cv医生 
    **/
    public static List<SelectOption> getDoctorCVItems() {
        List<SelectOption> options = new List<SelectOption>();
        String lang = userinfo.getLanguage();
        if(lang.equals('zh_CN'))
        	options.add(new SelectOption('','--无--'));
        else
        	options.add(new SelectOption('','--none--'));
        for(Account aObj : [Select Id,name from Account where ispersonaccount = true])
        	options.add(new SelectOption(aObj.id,aObj.name)); 
        return options;
    }
    
    /**
    *cv search
    * limit by with sharing
    **/
    public List<Account> searchCurrentTerritoryCVAccount(String SearchText,String hospitalId,String departmentId)
    {	
    	String querysql = 'select Id,Name,FirstName,LastName,JJ_CN_CV_Hospital_Level__c,Gender_vod__c,JJ_CN_Department__c, '+
        							' PersonEmail,Primary_Parent_vod__c,Primary_Parent_vod__r.Primary_Parent_vod__c,External_ID_vod__c,'+
        							' JJ_CN_CV_Hospital__c,Phone,JJ_CN_Mobile__c,'+
            						' JJ_CN_ID_Card__c,JJ_CN_CV_Academy_Level__c,JJ_CN_CV_Academy_Title__c,JJ_CN_CV_Academy__c ,JJ_CN_CV_Local_Academy__c,'+
            						' JJ_CN_License_NO__c,'+
            						' JJ_CHN_Professional_Title__c,'+
            						' JJ_CHN_Administrative_Title__c,'+
            						' JJ_CN_Academic_Title__c '+
            						' from Account where ';
        String whereCause = '  ';
        //医院
        whereCause = whereCause + ' Primary_Parent_vod__r.Primary_Parent_vod__c =:hospitalId  and ispersonaccount = true and JJ_CN_IsActive__c = true ';
             
        //科室
        if(!String.isBlank(departmentId))
        	whereCause = whereCause + ' and JJ_CN_Department__c =:departmentId';
         	
        //姓名
        if(!String.isBlank(SearchText))
        	whereCause = whereCause + ' and Name like \'%' + SearchText +'%\''; 					
        
            						//' where id = :SearchText ';
            						 //and Primary_Parent_vod__r.Primary_Parent_vod__c = :hospitalId
            						 //and JJ_CN_Department__c = :departmentId
        querysql = querysql + whereCause;
        List<Account> accountlist = DataBase.query(querysql);
        system.debug('accountlist==================='+accountlist.size());
    	return accountlist;
    }
    
    /**
    *professional account search
    * limit by with sharing
    **/
    public  List<Account> searchCurrentTerritoryAccount(String SearchText,String hospitalId,String departmentId)
    {	
    	String querysql = 'select Id,Name,FirstName,LastName,JJ_CN_CV_Hospital_Level__c,Gender_vod__c,JJ_CN_Department__c, '+
        							' PersonEmail,Primary_Parent_vod__c,Primary_Parent_vod__r.Primary_Parent_vod__c,External_ID_vod__c,'+
        							' JJ_CN_CV_Hospital__c,Phone,JJ_CN_Mobile__c,'+
            						' JJ_CN_ID_Card__c,JJ_CN_CV_Academy_Level__c,JJ_CN_CV_Academy_Title__c,JJ_CN_CV_Academy__c ,JJ_CN_CV_Local_Academy__c,'+
            						' JJ_CN_License_NO__c,'+
            						' JJ_CHN_Professional_Title__c,'+
            						' JJ_CHN_Administrative_Title__c,'+
            						' JJ_CN_Academic_Title__c '+
            						' from Account where ';
        String whereCause = '  ';
        //医院
       // whereCause = whereCause + ' (Primary_Parent_vod__r.Primary_Parent_vod__c =:hospitalId or Primary_Parent_vod__c=:hospitalId ) and ispersonaccount = true  and RecordType.Name = \'Professional_vod\' ';
       // whereCause = whereCause + ' Primary_Parent_vod__r.Primary_Parent_vod__c =:hospitalId  and ispersonaccount = true  and RecordType.Name = \'Professional_vod\' ';
          whereCause = whereCause + '	ispersonaccount = true  and JJ_CN_IsActive__c = true ';
        
         //医院
        if(!String.isBlank(hospitalId))
        	whereCause = whereCause + ' and Primary_Parent_vod__r.Primary_Parent_vod__c =:hospitalId ';     
        //科室
        if(!String.isBlank(departmentId))
        	whereCause = whereCause + ' and JJ_CN_Department__c =:departmentId';
         	
        //姓名
        if(!String.isBlank(SearchText))
        	whereCause = whereCause + ' and Name like \'%' + SearchText + '%\''; 					
        
            						//' where id = :SearchText ';
            						 //and Primary_Parent_vod__r.Primary_Parent_vod__c = :hospitalId
            						 //and JJ_CN_Department__c = :departmentId
        querysql = querysql + whereCause;
        system.debug('querysql==================='+querysql);
        List<Account> accountlist = DataBase.query(querysql);
        system.debug('accountlist==================='+accountlist.size());
    	return accountlist;
    }
    
    /**
    *hco search
    **/
    public Set<Id> searchCurrentTerritory(String nameWord )
    {	
    	String whereClause = '';
    	Set<Id> accountSet = new Set<Id>();
    	nameWord = nameWord == null ?  '' : nameWord;
            
        whereClause = ' Name Like \'%' + nameWord + '%\' and ispersonaccount = false';
        
        whereClause += ' AND recordtype.name =\'Hospital_vod\' ';
        
        String q = 'select id,name from account where ';
    	q = q + whereClause;
    	system.debug('============'+q);
    	for (Account a : Database.query(q)) 
    	{
	         accountSet.add(a.Id);
        }
        system.debug('accountSet============'+accountSet.size());
    	return accountSet;
    }
    
     /**
    *current territory Hospital Ids
    **/
    public Set<Id> searchCurrentTerritoryHCO()
    {	
    	Set<Id> accountSet = new Set<Id>();
        String q = 'select id,name from account where recordtype.name =\'Hospital_vod\' limit 49999';
    	system.debug('============'+q);
    	for (Account a : Database.query(q)) 
    	{
	         accountSet.add(a.Id);
        }
        system.debug('accountSet============'+accountSet.size());
    	return accountSet;
    }
    
    public Set<Id> searchHCPIds( String nameWord, String hospitalId, String departmentId , String lisenceNo ) 
    {
     	Set<Id> accountSet = new Set<Id>();
     	String whereClause = '';
     	nameWord = nameWord == null ?  '' : nameWord;
            
        whereClause = ' ispersonAccount = true and JJ_CN_IsActive__c = true';
        
        if(!String.isBlank(nameWord))
        	whereClause += ' and LastName Like \'%' + nameWord + '%\' ';
        
        if(!String.isBlank(hospitalId)) {
            whereClause += ' AND Primary_Parent_vod__r.Primary_Parent_vod__c = :hospitalId ';
        }
        //Primary_Parent_vod__c
        if(!String.isBlank(departmentId)) {
            whereClause += ' AND JJ_CN_Department__c = :departmentId ';
        }
        
        if(!String.isBlank(lisenceNo))
        {
             whereClause += ' AND JJ_CN_License_NO__c = :lisenceNo ';
        }
        
        string sql = 'select Id from Account where ' + whereClause + '';
     	
     	for (Account a : Database.query(sql)) 
    	{
	         accountSet.add(a.Id);
        }
     	
     	return accountSet;
    }
    
    /**
    *ATL HCO HCP account search
    * limit by with sharing
    **/
    public  List<Account> searchCurrentTerritoryAccount(String SearchText,Boolean isKa)
    {	
    	String querysql = 'select Id,Name,FirstName,LastName,External_ID_vod__c,Primary_Parent_vod__r.Primary_Parent_vod__c,JJ_CN_Department__c  ' +  
            						' from Account where ';
        String whereCause = '  ';
        //医院
        whereCause = whereCause + ' JJ_CN_IsActive__c = true and recordtype.name in(\'Hospital_vod\',\'Professional_vod\' ,\'CV Doctor\' ) ';
        //是否KA
        if(isKa == true)
            whereCause = whereCause + ' and  ispersonaccount = true' ;
        //姓名
        if(!String.isBlank(SearchText))
        	whereCause = whereCause + ' and Name like \'%' + SearchText + '%\' limit 100'; 					

        querysql = querysql + whereCause;
        system.debug('querysql================='+querysql);
        List<Account> accountlist = DataBase.query(querysql);
    	return accountlist;
    }
    
}