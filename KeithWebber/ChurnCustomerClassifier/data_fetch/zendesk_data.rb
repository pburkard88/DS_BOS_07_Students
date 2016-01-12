
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
