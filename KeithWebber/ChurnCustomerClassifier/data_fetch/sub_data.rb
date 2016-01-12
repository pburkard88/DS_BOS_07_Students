

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
