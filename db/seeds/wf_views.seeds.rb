ActiveRecord::Base.connection_pool.with_connection do |c|
  puts 'load activiti views'
  c.execute("Create or Replace View ACT_ID_GROUP As
select `fdn_organizations`.`code` AS `ID_`,1 AS `REV_`,`fdn_organizations`.`name` AS `NAME_`,'assignment' AS `TYPE_`,'Fdn::Organization' AS `resource_type`,`fdn_organizations`.`id` AS `resource_id` from `fdn_organizations` union all
select concat(`fdn_organizations`.`code`,'_',`fdn_roles`.`code`) AS `ID_`,1 AS `REV_`,concat(`fdn_organizations`.`name`,'_',`fdn_roles`.`name`) AS `NAME_`,if((`fdn_organizations`.`resource_type` = 'Fdn::Dept'),'security-role','assignment') AS `TYPE_`,'Fdn::Role' AS `resource_type`,`fdn_roles`.`id` AS `resource_id` from (`fdn_roles` join `fdn_organizations`) where (`fdn_roles`.`organization_id` = `fdn_organizations`.`id`)")

  c.execute("Create or Replace View ACT_ID_USER As
select concat(`fdn_organizations`.`code`,'-',`fdn_users`.`username`) AS `ID_`,2 AS `REV_`,`fdn_organizations`.`code` AS `FIRST_`,`fdn_users`.`username` AS `LAST_`,`fdn_users`.`username` AS `EMAIL_`,`fdn_users`.`username` AS `PWD_`,'' AS `PICTURE_ID_`,`fdn_users`.`resource_id` AS `org_id`, fdn_users.id as fdn_user_id from (`fdn_users` join `fdn_organizations`) where (`fdn_users`.`resource_id` = `fdn_organizations`.`id`)")

  c.execute("Create or Replace View ACT_ID_MEMBERSHIP As
select ACT_ID_USER.ID_ as USER_ID_,  ACT_ID_GROUP.ID_ as GROUP_ID_ from ACT_ID_USER, ACT_ID_GROUP where ACT_ID_GROUP.resource_type='Fdn::Organization' and ACT_ID_USER.org_id =  ACT_ID_GROUP.resource_id
union all
select  ACT_ID_USER.ID_ as USRE_ID_,  ACT_ID_GROUP.ID_ as GROUP_ID_  from roles_users, ACT_ID_USER, ACT_ID_GROUP where roles_users.role_id =  ACT_ID_GROUP.resource_id and ACT_ID_GROUP.resource_type='Fdn::Role' and roles_users.user_id = ACT_ID_USER.fdn_user_id")

  puts 'load activiti views completed'

end