
def sfdc_account_fields(act)
  new_act = {}
  new_act["Account_Tier__c"]= act["Account_Tier__c"] # ["3", "2", "1"]
  new_act["AnnualRevenue"] = act["AnnualRevenue"]
  new_act["Assigned_CSM__c"]= act["Assigned_CSM__c"]            #=>"005600000047ugcAAA"
  new_act["BASS_Subscription_Id__c"] = act["BASS_Subscription_Id__c"]  #=>170523.0
  new_act["Backupify_Logins__c"] = act["Backupify_Logins__c"]   #=>nil
  new_act["BillingCountry"]= act["BillingCountry"]    #=>"Colombia"
  new_act["Churn_Notes__c"] = act["Churn_Notes__c"]     #=>nil
  new_act["Cloud_Forward_Scale__c"] = act["Cloud_Forward_Scale__c"] #=>nil
  new_act["Company_Size_by_Number_of_Employees__c"] = act["Company_Size_by_Number_of_Employees__c"]#=>nil
  new_act["Contract_Renewal_Date__c"] = act["Contract_Renewal_Date__c"]   #=>nil
  new_act["CreatedById"]= act["CreatedById"]          #=>"005600000048SUaAAM"
  new_act["CreatedDate"]= act["CreatedDate"]          #=>"2015-03-27T13:47:26.000+0000"
  new_act["Current_Plan_Type__c"] = act["Current_Plan_Type__c"]         #=>nil
  new_act["Customer_Status__c"]= act["Customer_Status__c"]          #=>"Is Customer"
  new_act["Customer_Success_Relationship__c"] = act["Customer_Success_Relationship__c"]         #=>nil
  new_act["Datto_Products__c"] = act["Datto_Products__c"]         #=>nil
  new_act["Domain_Users__c"] = act["Domain_Users__c"]         #=>549.0
  new_act["Domain__c"]= act["Domain__c"]          #=>"colciencias.gov.co"
  new_act["Feature_Requests__c"] = act["Feature_Requests__c"]        #=>true   #true if present?
  new_act["GAPPS_At_Risk__c"] = act["GAPPS_At_Risk__c"]         #=>false
  new_act["GAPPS_Churn_Date__c"] = act["GAPPS_Churn_Date__c"]         #=>nil
  new_act["GAPPS_Churn_Reason__c"] = act["GAPPS_Churn_Reason__c"]         #=>nil  # ["No longer using GApps" "Out of business" "Switching to competitor" "Pricing" "Declined to Answer" "Missing feature" "Customer service issue"]
  new_act["GAPPS_Churn__c"] = act["GAPPS_Churn__c"]         #=>false
  new_act["GAPPS_Number_of_Users_Being_Backed_Up__c"] = act["GAPPS_Number_of_Users_Being_Backed_Up__c"]         #=>0.0
  new_act["GAPPS_Paid_Start_Date__c"] = act["GAPPS_Paid_Start_Date__c"]         #=>nil
  new_act["GAPPS_Paid__c"] = act["GAPPS_Paid__c"]         #=>false
  new_act["GAPPS_Reseller_ID__c"] = act["GAPPS_Reseller_ID__c"]         #=>nil
  new_act["GAPPS_Total_Storage__c"] = act["GAPPS_Total_Storage__c"]         #=>63.0
  new_act["Google_Apps_Plan_ID__c"]= act["Google_Apps_Plan_ID__c"]          #=>"Professional"
  new_act["Google_Apps_Trial_End_Date__c"]= act["Google_Apps_Trial_End_Date__c"]          #=>"2015-04-08"
  new_act["Google_Apps_Trial_Start_Date__c"]= act["Google_Apps_Trial_Start_Date__c"]          #=>"2015-03-24"
  new_act["Google_Apps__c"]= act["Google_Apps__c"]          #=>"colciencias.gov.co"
  new_act["Health_Score__c"] = act["Health_Score__c"]         #=>5.0
  new_act["Id"]= act["Id"]          #=>"00132000019UEh0AAG"
  new_act["Industry"]= act["Industry"]          #=>"Government"
  new_act["LastActivityDate"] = act["LastActivityDate"]         #=>nil
  new_act["LeanData__LD_EmailDomains__c"]= act["LeanData__LD_EmailDomains__c"]          #=>"00132000019UEh0AAG w:colciencias.gov.co w:eforcers.com"
  new_act["LeanData__Search__c"]= act["LeanData__Search__c"]          #=>"00132000019UEh0AAG w:colciencias.gov.co"
  new_act["Name"]= act["Name"]          #=>"Colciencias"
  new_act["New_Subscription__c"] = act["New_Subscription__c"]         #=>true
  new_act["Number_of_Salesforce_Users__c"] = act["Number_of_Salesforce_Users__c"]         #=>nil
  new_act["Other_SaaS_Applications_Being_USed__c"] = act["Other_SaaS_Applications_Being_USed__c"] # might want to conisder a number here        #=>nil
  new_act["Overall_Health__c"] = act["Overall_Health__c"]         #=>nil
  new_act["Potential_GB_Upsell__c"] = act["Potential_GB_Upsell__c"]         #=>965.0
  new_act["Potential_Upsell__c"] = act["Potential_Upsell__c"]         #=>549.0
  new_act["Region__c"] = act["Region__c"]         #=>nil
  new_act["Risk_Activity__c"] = act["Risk_Activity__c"]         #=>nil
  new_act["Risk_Relationship__c"] = act["Risk_Relationship__c"]         #=>nil
  new_act["Roll_Up_MRR__c"] = act["Roll_Up_MRR__c"]         #=>594.0
  new_act["Roll_Up_Storage_Purchased__c"] = act["Roll_Up_Storage_Purchased__c"]         #=>1028.0
  new_act["SFDC_At_Risk__c"] = act["SFDC_At_Risk__c"]         #=>false
  new_act["SFDC_Churn_Date__c"] = act["SFDC_Churn_Date__c"]         #=>nil
  new_act["SFDC_Churn__c"] = act["SFDC_Churn__c"]         #=>false
  new_act["SFDC_Paid_Start_Date__c"] = act["SFDC_Paid_Start_Date__c"]         #=>nil
  new_act["SFDC_Paid__c"] = act["SFDC_Paid__c"]         #=>false
  new_act["SFDC_Plan_Id__c"] = act["SFDC_Plan_Id__c"]         #=>nil
  new_act["SFDC_Trial_End_Date__c"] = act["SFDC_Trial_End_Date__c"]         #=>nil
  new_act["SFDC_Trial_Start_Date__c"] = act["SFDC_Trial_Start_Date__c"]         #=>nil
  new_act["Salesforce_edition__c"] = act["Salesforce_edition__c"]         #=>nil
  new_act["Success_Strategy__c"] = act["Success_Strategy__c"]         #=>nil
  new_act["Territory__c"] = act["Territory__c"]         #=>nil
  new_act["Total_Opps__c"] = act["Total_Opps__c"]         #=>1.0
  new_act["Total_Won_Opportunities__c"] = act["Total_Won_Opportunities__c"]         #=>594.0
  new_act["Type"]= act["Type"]          #=>"Customer"
  new_act["Website"]= act["Website"]          #=>"colciencias.gov.co"
  new_act["Zuora_Account_Link__c"]= act["Zuora_Account_Link__c"]          #=>"Did not pay via Zuora"


  new_act
end


def sumarize_tickets(ticks)
  sum_ticket = build_verbose_ticket
  st_keys = sum_ticket.keys
  number_of_tickets = ticks.count

  ticks.each do |ti|
    sum_ticket[find_field_list_item("type", ti["type"], st_keys)] += 1

    ti["tags"].each do |tag_name|
      sum_ticket[find_field_list_item("tags", tag_name, st_keys)] += 1
    end

    sum_ticket[find_field_list_item("priority", ti["priority"], st_keys)] += 1
    sum_ticket[find_field_list_item("status", ti["status"], st_keys)] += 1
    sum_ticket[find_field_list_item("issue_category", ti["Issue Category"], st_keys)] += 1
    sum_ticket[find_field_list_item("issue_category", ti["Issue Category"], st_keys)] += 1
    sum_ticket[find_field_list_item("Pending", ti["Pending:"], st_keys)] += 1
    sum_ticket[find_field_list_item("Awaiting", ti["Awaiting"], st_keys)] += 1
    sum_ticket["comment_count"] += ti["comment_count"]
    sum_ticket["Trial?"] += ( ti["Trial?"] == true ? 1 : 0)
    sum_ticket["Proactive"] += ( ti["Proactive"] == true ? 1 : 0)
  end
  sum_ticket["comments_per_ticket"] = 0
  if number_of_tickets != 0
    sum_ticket["comments_per_ticket"] = sum_ticket["comment_count"] /number_of_tickets
  end
  sum_ticket
end


def build_verbose_ticket
  new_ticket = {}
  type = ["question", "incident", "task", "problem"]
  tags = ["","acct_salesforce_professional", "escalated", "premier_customer", "prod_salesforce", "redmine", "salesforce", "acct_salesforce_enterprise", "follow_up", "prod_google_apps", "prod_migrator", "acct_googleapps", "billing", "user_response", "hot", "phone_received", "acct_salesforce_basic", "gmail", "acct_enterprise", "proactive_reachout", "restore", "google_apps", "stalled_migration", "success", "admin_add_users", "acct_enterprise_plus", "sales", "google_docs", "prod_backupify_labs", "acct_migrator", "data_export", "inquiry", "google_calendar", "acct_reseller", "premier_partner", "cancellation", "admin_subdomain", "prod_snapshot", "google_sites", "monitor", "trial_alerted", "trial_yes", "accounting", "standard_partner", "prod_smartsheet", "acct_pro100", "spoke_migrator", "prod_office365", "admin_re_enable_service", "admin_shared_docs", "assigned_to_boston", "admin_admin_roles", "admin_login", "asterisk_voicemail", "prod_social_media", "intro_macro_used", "acct_other", "admin_remove_service", "restore_pending", "google_contacts", "n/a", "acct_sm_professional", "acct_sm_enterprise", "social_media", "acct_pro500", "stalled_snapshot", "admin_cdr", "closed_by_merge", "acct_mycloud100", "acct_mycloud500", "acct_legacy_prem", "user_config", "export_pending", "prod_freespace", "prod_labs", "admin__login", "ex_premier_customer", "admin_account", "export", "google", "admin__add_users", "backup_pending", "gapps", "user_removal_pending", "hot.", "backup_job", "nonsuperadminsetup", "beta_feedback", "created_by_reception", "reception_received", "other"]
  priority = ["normal", "high", "urgent", "low"]
  status = ["pending", "closed", "open", "solved", "new"]
  issue_category = ["salesforce", "", "billing", "gmail", "restore", "google_apps", "stalled_migration", "admin_add_users", "google_docs", "data_export", "inquiry", "google_calendar", "cancellation", "admin_subdomain", "google_sites", "admin_re_enable_service", "admin_shared_docs", "admin_admin_roles", "admin_login", "admin_remove_service", "google_contacts", "social_media", "stalled_snapshot", "admin_cdr"]
  pending = ["redmine", "follow_up", "", "user_response", "user_config", "export", "backup_job"]
  awaiting = ["", "success", "sales", "monitor", "accounting", "restore_pending", "export_pending", "google", "backup_pending", "user_removal_pending"]
  keys = [["type", type], ["tags", tags],["priority", priority],["status", status],["issue_category", issue_category],['pending', pending],["awaiting", awaiting] ]
  keys.each do |key|
    named_field_list(key[0],key[1]).each do |name|
      new_ticket[name] = 0
    end
  end
  new_ticket["comment_count"] = 0
  new_ticket["Trial?"] = 0
  new_ticket["Proactive"] = 0
  new_ticket[""] = 0
  new_ticket["comments_per_ticket"] = 0
  new_ticket
end

def named_field_list(name, list)
  list.map do |li|
    "#{name.downcase}.#{li}"
  end
end

def find_field_list_item(name, value, field)
  if value == nil || value == ""
    return ""
  end
  field.select do |ff|
    "#{name.downcase}.#{value}" == ff
  end.first
end
