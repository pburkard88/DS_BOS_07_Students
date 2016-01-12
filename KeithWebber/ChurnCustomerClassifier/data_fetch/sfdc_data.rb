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
