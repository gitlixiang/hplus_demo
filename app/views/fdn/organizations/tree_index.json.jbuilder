pic =  {"1"=>'<img alt="Add" src="/assets/1.png" title="一级企业" align="absmiddle">',"2"=>'<img alt="Add" src="/assets/2.png" title="二级企业" align="absmiddle">',"3"=>'<img alt="Add" src="/assets/3.png" title="三级企业" align="absmiddle">',"4"=>'<img alt="Add" src="/assets/4.png" title="四级及四级以下企业" align="absmiddle">',"委"=>'<img alt="Add" src="/assets/0.png" title="国资委" align="absmiddle">'}
if @nodeid.blank?
    json.array!(@fdn_organizations) do |org|
        if org.is_ent?
            json.act bs_link_window(fdn_organization_path(org),'查看')
            json.ent_level_value org.is_ent? ? org.resource.ent_level_value : ''
            json.reg_amt org.is_ent? ? org.resource.reg_amt : ''
            json.org_type org.org_type_name
            json.ent_type_value org.is_ent? ? org.resource.ent_type_value : ''
            json.org_hierarchy ''
            json.chan org.with_hierarchy(1).parent ? '是' : '否'
            json.kuai org.with_hierarchy(2).parent ? '是' : '否'
            json.yu org.with_hierarchy(3).parent ? '是' : '否'
            json.nian org.with_hierarchy(4).parent ? '是' : '否'
            json.jue org.with_hierarchy(5).parent ? '是' : '否'
        else
            json.chan '否'
            json.kuai '否'
            json.yu   '否'
            json.nian '否'
            json.jue  '否'
        end
        json.id org.id
        if org.children.empty?
            json.isLeaf true
        else
            json.isLeaf false
        end
        if org.is_ent?
            json.name "<div class='context-menu-sub box menu-1' id='#{org.id}'>" + ((org.resource.ent_level_code.to_i>0 && org.resource.ent_level_code.to_i<4) ? pic[org.resource.ent_level_code.to_s] : pic["4"]) + org.name + "</div>"
        else
            json.name "<div class='context-menu-sub box menu-1' id='#{org.id}'>" + pic["委"] + org.name + "</div>"
        end
        json.code org.code
        json.level 0
        json.expanded false
    end
    if  current_org.id == 1 && @other_orgs.size !=0
        json.array!([1]) do |r|
             json.id 9999
             json.isLeaf false
             json.level 0
             json.name '尚未关联的企业'
             json.expanded false
             json.chan '否'
             json.kuai '否'
             json.yu   '否'
             json.nian '否'
             json.jue  '否'
        end
    end
elsif @nodeid == '9999'
    json.array!(@other_orgs) do |o_org|
        json.act bs_link_window(fdn_organization_path(o_org),'查看')
        json.id o_org.id
        json.parent 9999
        json.level 1
        json.isLeaf true
        json.name "<div class='context-menu-sub box menu-1' id='#{o_org.id}'>" + ((o_org.resource.ent_level_code.to_i>0 && o_org.resource.ent_level_code.to_i<4) ? pic[o_org.resource.ent_level_code.to_s] : pic["4"]) + o_org.name + "</div>"
        json.code o_org.code
        json.expanded false
        json.ent_level_value o_org.is_ent? ? o_org.resource.ent_level_value : ''
        json.reg_amt o_org.is_ent? ? o_org.resource.reg_amt : ''
        json.org_type o_org.org_type_name
        json.ent_type_value o_org.is_ent? ? o_org.resource.ent_type_value : ''
        json.org_hierarchy ''
        json.chan o_org.with_hierarchy(1).parent ? '是' : '否'
        json.kuai o_org.with_hierarchy(2).parent ? '是' : '否'
        json.yu o_org.with_hierarchy(3).parent ? '是' : '否'
        json.nian o_org.with_hierarchy(4).parent ? '是' : '否'
        json.jue o_org.with_hierarchy(5).parent ? '是' : '否'
    end
else
    json.array!(@fdn_organizations) do |org|
        json.act bs_link_window(fdn_organization_path(org),'查看')
        json.id org.id
        json.parent @nodeid
        json.level @level
        if org.children.empty?
            json.isLeaf true
        else
            json.isLeaf false
        end
        json.name "<div class='context-menu-sub box menu-1' id='#{org.id}'>" + ((org.resource.ent_level_code.to_i>0 && org.resource.ent_level_code.to_i<4) ? pic[org.resource.ent_level_code.to_s] : pic["4"]) + org.name + "</div>"
        json.code org.code
        json.expanded false
        json.ent_level_value org.is_ent? ? org.resource.ent_level_value : ''
        json.reg_amt org.is_ent? ? org.resource.reg_amt : ''
        json.org_type org.org_type_name
        json.ent_type_value org.is_ent? ? org.resource.ent_type_value : ''
        json.org_hierarchy ''
        json.chan org.with_hierarchy(1).parent ? '是' : '否'
        json.kuai org.with_hierarchy(2).parent ? '是' : '否'
        json.yu org.with_hierarchy(3).parent ? '是' : '否'
        json.nian org.with_hierarchy(4).parent ? '是' : '否'
        json.jue org.with_hierarchy(5).parent ? '是' : '否'
    end
end