xml.instruct!
xml.root do
  xml.item(:id=>'root',:hie_id =>@hie_id,:rel=>'root', :state=>"open") do
      xml.content do
        xml.name do
          xml.cdata!("组织树")
        end
      end
    end
  for org_element in @org_elements
    state = org_element.id <= 3 ? "open" : ""
    xml.item(:parent_id=>"#{@org_elements.index(org_element) == 0 ? 'root' : org_element.d_parent_id}", :id=>"#{org_element.id}",:hie_id =>@hie_id,:rel=>"element", :state => state) do
      xml.content do
        xml.name do
          xml.cdata!(org_element.name)
        end
      end
    end
  end
  
end

