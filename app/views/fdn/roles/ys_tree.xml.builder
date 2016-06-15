xml.instruct!
xml.root do
  @orgs3.each do |o|
    if o.with_hierarchy(4).parent
      if o.with_hierarchy(4).children.empty?
        xml.item :id => o.id, :parent_id => o.parent.id, :url => index_main_fdn_roles_path(:org_id => o.id) do
          xml.content do
            xml.name do
              xml.cdata! '(预算)'+o.name
            end
          end
        end
      else
        xml.item :id => o.id, :parent_id => o.parent.id, :state => 'closed', :url => index_main_fdn_roles_path(:org_id => o.id) do
          xml.content do
            xml.name do
              xml.cdata! '(预算)'+o.name
            end
          end
        end
      end
    else
      if o.with_hierarchy(4).children.empty?
        xml.item :id => o.id, :url => index_main_fdn_roles_path(:org_id => o.id) do
          xml.content do
            xml.name do
              xml.cdata! '(预算)'+o.name
            end
          end
        end
      else
        xml.item :id => o.id, :state => 'closed', :url => index_main_fdn_roles_path(:org_id => o.id) do
          xml.content do
            xml.name do
              xml.cdata! '(预算)'+o.name
            end
          end
        end
      end
    end

  end
end