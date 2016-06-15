json.array!(@orgs) do |org|
    json.id org.id
    if org.children.empty?
        json.children false
    else
        json.children true
    end
    json.text org.name
    json.code org.code
end
if @org_id.blank? && current_org.id == 1 && !@other_orgs.empty?
    json.array!(@orgs) do |r|
     json.id 9999
     json.children true
     json.text '尚未关联的企业'
        unless @other_orgs.empty?
            json.children(@other_orgs) do |o_org|
                json.id o_org.id
                json.children false
                json.text o_org.name
                json.code o_org.code
            end
        end
    end
end