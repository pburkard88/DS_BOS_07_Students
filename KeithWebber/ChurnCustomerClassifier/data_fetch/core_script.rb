# get backupify salesforce
service = Service.find 17989108

# get account object enum
sri = service.sobject_record_interface
account_object = sri.fetch_by_sobject "Account"
event_object = sri.fetch_by_sobject "Event"
contact_object = sri.fetch_by_sobject "Contact"
contract_object = sri.fetch_by_sobject "Contract"
user_object = sri.fetch_by_sobject "User"
survey_object = sri.fetch_by_sobject "Survey__c"


# load all high value accounts
sfdc_account_data = []
sfdc_account_ids = Set.new
sfdc_event_data = []
sfdc_contact_data = []
sfdc_contract_data = []
sfdc_users = []
sfdc_name_id_map = {}
# we only care about events for customers that pay us over 100$ a month
# we might expand this to include lower pay customers if we need more data

account_object.each do |rec|
  data = JSON.parse rec.column_values
  if data["Roll_Up_MRR__c"] > 500.0
    sfdc_account_ids << data["Id"]
    sfdc_account_data << data
  end
end

# we only care about events for customers that pay us over 100$ a month
event_object.each do |rec|
  data = JSON.parse rec.column_values
  if sfdc_account_ids.include?(data["AccountId"])
    sfdc_event_data << data
  end
end

contract_object.each do |rec|
  data = JSON.parse rec.column_values
  sfdc_contract_data << data
end

contact_object.each do |rec|
  data = JSON.parse rec.column_values
  sfdc_contact_data << data
end

user_object.each do |rec|
  data = JSON.parse rec.column_values
  sfdc_name_id_map[data["Id"]] = data["Name"]
  sfdc_users << data
end


# blanks = sfdc_account_data.select {|r| r["BASS_Subscription_Id__c"].nil? }
#
# guess_domain = blanks.map { |b| guess_sub_id(b) }
#
# no_domains = []
#
# guess_domain.each_with_index do |b, i|
#   if b.nil?
#     no_domains << blanks[i]
#   end
# end

# no_domains.select {|nd| nd["SFDC_Plan_Id__c"].present?}




def guess_sub_id(account_record)
  sub_id = nil
  d = nil
  name = account_record["Google_Apps__c"]
  if name.nil?
    name = account_record["Domain__c"]
  end

  if name.present?
    begin
      d = Domain.find_by_name(name)
      sub_id = d.customer.subscription.id
    rescue => e
    end
  end

  if sub_id.nil? && account_record["Website"].present?
    name = account_record["Website"].gsub("www.","")
    begin
      d = Domain.find_by_name(name)
      sub_id = d.customer.subscription.id
    rescue => e
    end
  end

  if sub_id.nil? && account_record['GAPPS_Number_of_Users_Being_Backed_Up__c']
    begin
      d = Domain.find_by_total_accounts(account_record['GAPPS_Number_of_Users_Being_Backed_Up__c'])
      sub_id = d.customer.subscription.id
    rescue => e
    end
  end

  sub_id
end

def get_additonal_data_for_record(sub_id)
  archive = false
  sub = begin
    Subscription.find sub_id
  rescue ActiveRecord::RecordNotFound
    archive = true
    Subscription::Archive.find_by_id sub_id
  end
  return [] if sub.nil?
  if archive == true
    use_archive_tables(sub)
  else
    use_regular_tables(sub)
  end
end


def use_archive_tables(sub)
  domains = Domain::Archive.where(:owner_id => sub.billing_contact_id)
  [sub,domains].flatten
end

def use_regular_tables(sub)
  domains = sub.customer.domains
  [sub,domains].flatten
end


def fetch_zendesk_tickets
  data = []
  page_counter = 0
  loop do
    print page_counter
    res = Zendesk::Client.api_resource["tickets.json?page=#{page_counter}"].get
    tickets = JSON.parse(res)["tickets"]
    break if tickets.empty?
    data.append(tickets)
    page_counter += 1
  end
  data.flatten
end

def fetch_zendesk_satisfaction
  data = []
  page_counter = 0
  loop do
    print page_counter
    res = Zendesk::Client.api_resource["satisfaction_ratings.json?page=#{page_counter}"].get
    satisfaction_ratings = JSON.parse(res)["satisfaction_ratings"]
    break if satisfaction_ratings.empty?
    data.append(satisfaction_ratings)
    page_counter += 1
  end
  data.flatten
end



def fetch_zendesk_ticket_fields
  data = []
  page_counter = 0
  loop do
    print page_counter
    res = Zendesk::Client.api_resource["ticket_fields.json?page=#{page_counter}"].get
    ticket_fields = JSON.parse(res)["ticket_fields"]
    break if ticket_fields.empty?
    data.append(ticket_fields)
    page_counter += 1
  end
  data.flatten
end

def fetch_zendesk_agents
  data = []
  page_counter = 0
  loop do
    print page_counter
    res = Zendesk::Client.api_resource["users.json?page=#{page_counter}&role[]=admin&role[]=agent"].get
    users = JSON.parse(res)["users"]
    break if users.empty?
    data.append(users)
    page_counter += 1
  end
  data.flatten
end

def fetch_zendesk_end_users
  data = []
  page_counter = 0
  loop do
    print page_counter
    res = Zendesk::Client.api_resource["users.json?page=#{page_counter}&role[]=end-user"].get
    users = JSON.parse(res)["users"]
    break if users.empty?
    data.append(users)
    page_counter += 1
  end
  data.flatten
end

def fetch_zendesk_orgs
  data = []
  page_counter = 0
  loop do
    print page_counter
    res = Zendesk::Client.api_resource["organizations.json?page=#{page_counter}"].get
    organizations = JSON.parse(res)["organizations"]
    break if organizations.empty?
    data.append(organizations)
    page_counter += 1
  end
  data.flatten
end

def fetch_tickets_for_org(org)
  res = Zendesk::Client.api_resource["/organizations/#{org['id']}/tickets.json"].get
  ticks = JSON.parse(res)["tickets"]
  return ticks if ticks.empty?
  ticks.map {|tick| zendesk_clean_ticket(tick) }
end


def flatten_org(org)
  if org["organization_fields"].present?
    org['sfdc_account_id'] = org["organization_fields"]['sfdc_account_id']
    org["subscription_id"] = org["organization_fields"]["subscription_id"]
    org["sales_rep"] =       org["organization_fields"]["sales_rep"]
    org["success_rep"] =     org["organization_fields"]["success_rep"]
    org.delete("organization_fields")
  end
  org
end

def select_premier(tickets)
  tickets.select do |ticket|
    ticket["tags"].include? "premier_customer"
  end
end

def zendesk_clean_ticket(ticket)
  return if ticket.nil?
  ticket_fields = {
    24106656 => "Proactive",
    23906053 => "Trial?",
    22501658 => "Product",
    495183 => "Issue Category",
    498479 => "UserID",
    498480 =>"Account Type",
    510626 => "Pending:",
    20877608 => "JIRA_ID",
    25939828 => "Awaiting"
  }

  fields = ["id","type","tags", "subject","description","priority","status","requester_id","organization_id","comment_count"]
  new_ticket = {}
  fields.each do |f|
    new_ticket[f] = ticket[f]
  end
  ticket["custom_fields"].each do |id_name_hash|
    new_ticket[ticket_fields[id_name_hash["id"]]] = id_name_hash["value"]
  end

  case ticket["satisfaction_rating"]["score"]
  when "good"
    new_ticket["good"]
  when "unoffered"
    new_ticket["unoffered"]
  when "bad"
    new_ticket["bad"]
  end
  new_ticket
end



def prepare_org_lookup(all_orgs)
  @orgs ||= {}
  all_orgs.map do |org|
    org = flatten_org(org)
    @orgs[org["id"]] = org
  end
  @orgs
end
########################################################
########################################################
########################################################
############### STANDARDARDIZE DATA ####################
########################################################
########################################################


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

########################################################
############# SUMMARIZE DOMAINS ########################
########################################################


def summarize_domains(list_of_domains)
  domain_sum = {"authentication_type"=> 0,
  "total_accounts"=> 0,
  "send_owner_summary_email"=> 0,
  "auto_add_new_accounts"=> 0,
  "sites_for_owners_only"=> 0,
  "unprotected_accounts_count"=> 0,
  "notifications_count"=> 0,
  "s3_region_id"=> 0,
  "child_app_access_enabled" => 0}

  list_of_domains.each_with_index do |dom,index|
    domain_sum["authentication_type"] = dom.authentication_type
    domain_sum["total_accounts"] += dom.total_accounts.to_i
    domain_sum["send_owner_summary_email"] = dom.send_owner_summary_email
    domain_sum["auto_add_new_accounts"] = dom.auto_add_new_accounts
    domain_sum["sites_for_owners_only"] = dom.sites_for_owners_only
    domain_sum["unprotected_accounts_count"] += dom.unprotected_accounts_count.to_i
    domain_sum["notifications_count"] +=dom.notifications_count.to_i
    domain_sum["s3_region_id"] = dom.s3_region_id
    domain_sum["child_app_access_enabled" ] = dom.child_app_access_enabled
  end

  domain_sum
end


def summarize_subs(sub)
  sub_sum = {"subscription.canceled" => false,
     "subscription.is_monthly" => true,
     "subscription.invoiced" => false}
  if sub.present?
    sub_sum["subscription.canceled"] = sub.canceled
    sub_sum["subscription.is_monthly"] = sub.is_monthly
    sub_sum["subscription.invoiced"] = sub.invoiced
  end
  sub_sum
end







########################################################

def analyze_object(object_set, skip_keys = [])
  keys = object_set.first.keys
  obj_count = object_set.count
  keys.each do |key|
    next unless skip_keys.include?(key)
    cardinality = object_set.map {|s| s[key]}.compact
    uniq_values = cardinality.uniq
    nil_vals = obj_count - cardinality.count
    puts "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
    puts "key:#{key} - nilCount:#{nil_vals}"
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts "uniq_values:#{uniq_values}"
    # puts "cardinality:#{cardinality}"
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts "key:#{key} - nilCount:#{nil_vals}"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n"
  end

end




########################################################
#   ticket[org_id] => org['id']-org-org['sfdc_account_id'] => account_record["id"]
# =>                                subscription_id => account_record
#
#
#
#
#each account
# check tickets
#   dump any data bout tickets
# check database
#
#
#
#
#
#
#
#
#
#
##########################################################
##########################################################
####### THIS TO RUN TO GENERATE DATA #####################
##########################################################
##########################################################


#def prepare_data
tickets = fetch_zendesk_tickets;
tickets = tickets.map { |tick| zendesk_clean_ticket(tick) };
organizations = fetch_zendesk_orgs;
organizations = organizations.map { |org| flatten_org(org) };

account_object.each do |rec|
  data = JSON.parse rec.column_values
  if data["Roll_Up_MRR__c"] > 20.0
    sfdc_account_ids << data["Id"]
    sfdc_account_data << data
  end
end

sfdc_account_data = sfdc_account_data.map {|sfdc| sfdc_account_fields(sfdc) }

skip = "false"
CSV.open("/tmp/customers_stats_full.csv", "wb", col_sep: "|") do |csv|
  column_keys = sfdc_account_data[0].keys
  column_keys << build_verbose_ticket.keys
  important_db_fields = ["subscription.canceled", "subscription.is_monthly", "subscription.invoiced", "domain.authentication_type", "domain.total_accounts", "domain.send_owner_summary_email", "domain.auto_add_new_accounts", "domain.sites_for_owners_only","domain.unprotected_accounts_count","domain.notifications_count","domain.s3_region_id","domain.child_app_access_enabled"]
  column_keys << important_db_fields

  csv << column_keys.flatten!
  puts column_keys.count
  sfdc_account_data.map do |sfdc_account|
    begin
    next if sfdc_account["Customer_Status__c"] == "Not Customer"
    subscription_id = nil

    if subscription_id.nil?
      subscription_id = guess_sub_id(sfdc_account)
    end

    # setup org block
    org = organizations.select {|org| org["sfdc_account_id"] == sfdc_account["Id"] }.first
    if org.nil? && sfdc_account["BASS_Subscription_Id__c"].present?
      org = organizations.select {|org| org["subscription_id"] == sfdc_account["BASS_Subscription_Id__c"] }.first
    end
    if org.nil? && subscription_id.present?
      org = organizations.select {|org| org["subscription_id"] == subscription_id }.first
    end
    sum_act_tickets = build_verbose_ticket
    if org.present?
      account_ticket = fetch_tickets_for_org(org)
      sum_act_tickets = sumarize_tickets(account_ticket)
    end

    db_records = get_additonal_data_for_record(subscription_id)
    row = []
    row << sfdc_account.values
    row << sum_act_tickets.values
    row << summarize_subs(db_records.shift).values
    row << summarize_domains(db_records).values
    puts "1:#{row[0].count}--2:#{row[1].count}--3:#{row[2].count}--4:#{row[3].count}"



    row = row.flatten

    row = row.map do |item|
      begin
        item = item.gsub("\n", " ")
        item = item.gsub("\r\n", " ")
        item = item.gsub("\r", " ")
      rescue => e
      end
      item
    end

    csv << row
  rescue => e
    binding.pry if skip == "false"
    puts sfdc_account["Id"]
    puts "STUFHHHHH"
    puts e.message
  end
  end
end
