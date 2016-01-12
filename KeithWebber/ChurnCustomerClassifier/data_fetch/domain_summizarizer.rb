
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
