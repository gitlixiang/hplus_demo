after :fdn_organizations do
  ActiveRecord::Base.connection_pool.with_connection do |c|
    name = 'fdn_org_hierarchies'
    name2 = 'fdn_org_hie_versions'
    name3 = 'fdn_org_hie_elements'
    puts "truncating...#{name}...#{name2}...#{name3}"
    c.execute("truncate table #{name}")
    c.execute("truncate table #{name2}")
    c.execute("truncate table #{name3}")

    gzw = Fdn::Organization.first

    FactoryGirl.create(:cq_org_hierarchy) do |hie|
      hie.org_hie_elements.create(FactoryGirl.attributes_for(:main_element, p: gzw, r: gzw, c: gzw, d: 0))
    end
    FactoryGirl.create(:kb_org_hierarchy) do |hie|
      hie.org_hie_elements.create(FactoryGirl.attributes_for(:main_element, p: gzw, r: gzw, c: gzw, d: 0))
    end
    FactoryGirl.create(:ys_org_hierarchy) do |hie|
      hie.org_hie_elements.create(FactoryGirl.attributes_for(:main_element, p: gzw, r: gzw, c: gzw, d: 0))
    end
    FactoryGirl.create(:nb_org_hierarchy) do |hie|
      hie.org_hie_elements.create(FactoryGirl.attributes_for(:main_element, p: gzw, r: gzw, c: gzw, d: 0))
    end
    FactoryGirl.create(:js_org_hierarchy) do |hie|
      hie.org_hie_elements.create(FactoryGirl.attributes_for(:main_element, p: gzw, r: gzw, c: gzw, d: 0))
    end

    #FactoryGirl.attributes_for(:one_lvl).create_organization(FactoryGirl.attributes_for(:one_lvl_org1))
    #FactoryGirl.attributes_for(:one_lvl_other).create_organization(FactoryGirl.attributes_for(:one_lvl_org2))
    #FactoryGirl.attributes_for(:two_lvl).create_organization(FactoryGirl.attributes_for(:two_lvl_org))
    #
    #gzw.with_hierarchy.add_child(2,nil,nil)
    #gzw.with_hierarchy.add_child(3,nil,nil)
    #gzw.with_hierarchy.add_child(4,nil,nil)
    ents = [['嘉兴市国有资产控股有限公司','314000',{ent_code:'149175298',ent_level_code:1,reg_amt:6000,ent_type_code:'001'}],
            ['嘉兴城建发展股份有限公司','149175298',{ent_code:'713965160',ent_level_code:2,reg_amt:4000,ent_type_code:'001'}],
            ['嘉兴城建广德置业有限公司','713965160',{ent_code:'057028987',ent_level_code:3,reg_amt:2000,ent_type_code:'002'}],
            ['嘉兴工业投资控股有限公司','314000',{ent_code:'737313255',ent_level_code:1,reg_amt:8000,ent_type_code:'001'}],
            ['嘉兴工投工业科技发展有限公司','737313255',{ent_code:'667943138',ent_level_code:2,reg_amt:5000,ent_type_code:'001'}]]
    ents.each do |ent_value|
      ent = Fdn::Enterprise.new(ent_value[2])
      #org.code = ent.ent_code
      #org.resource_id = ent.id
      #org.resource_type = 'Fdn::Enterprise'.
      ent.save(validate:false)
      org = ent.build_organization
      org.code = ent.ent_code
      org.name = ent_value[0]
      org.short_name = ent_value[0]
      org.save(validate:false)
    end
    ents.each do |ent_value|
      org = Fdn::Organization.find_by(name:ent_value[0])
      parent = Fdn::Organization.find_by(code:ent_value[1])
      parent.with_hierarchy.add_child(org.id,nil,nil)
      parent.with_hierarchy(2).add_child(org.id,nil,nil)
      parent.with_hierarchy(3).add_child(org.id,nil,nil)
      parent.with_hierarchy(4).add_child(org.id,nil,nil)
      parent.with_hierarchy(5).add_child(org.id,nil,nil)
    end



    puts "load completed...#{name}...#{name2}...#{name3}"
  end
end
