# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160603061805) do

  create_table "ACT_GE_BYTEARRAY", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "NAME_", limit: 255
    t.string "DEPLOYMENT_ID_", limit: 64
    t.binary "BYTES_"
    t.integer "GENERATED_", limit: 4
  end

  add_index "ACT_GE_BYTEARRAY", ["DEPLOYMENT_ID_"], name: "ACT_FK_BYTEARR_DEPL", using: :btree

  create_table "ACT_GE_PROPERTY", primary_key: "NAME_", force: :cascade do |t|
    t.string "VALUE_", limit: 300
    t.integer "REV_", limit: 11
  end

  create_table "ACT_HI_ACTINST", primary_key: "ID_", force: :cascade do |t|
    t.string "PROC_DEF_ID_", limit: 64, null: false
    t.string "PROC_INST_ID_", limit: 64, null: false
    t.string "EXECUTION_ID_", limit: 64, null: false
    t.string "ACT_ID_", limit: 255, null: false
    t.string "TASK_ID_", limit: 64
    t.string "CALL_PROC_INST_ID_", limit: 64
    t.string "ACT_NAME_", limit: 255
    t.string "ACT_TYPE_", limit: 255, null: false
    t.string "ASSIGNEE_", limit: 64
    t.datetime "START_TIME_", null: false
    t.datetime "END_TIME_"
    t.integer "DURATION_", limit: 8
  end

  add_index "ACT_HI_ACTINST", ["END_TIME_"], name: "ACT_IDX_HI_ACT_INST_END", using: :btree
  add_index "ACT_HI_ACTINST", ["EXECUTION_ID_", "ACT_ID_"], name: "ACT_IDX_HI_ACT_INST_EXEC", using: :btree
  add_index "ACT_HI_ACTINST", ["PROC_INST_ID_", "ACT_ID_"], name: "ACT_IDX_HI_ACT_INST_PROCINST", using: :btree
  add_index "ACT_HI_ACTINST", ["START_TIME_"], name: "ACT_IDX_HI_ACT_INST_START", using: :btree

  create_table "ACT_HI_ATTACHMENT", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "USER_ID_", limit: 255
    t.string "NAME_", limit: 255
    t.string "DESCRIPTION_", limit: 4000
    t.string "TYPE_", limit: 255
    t.string "TASK_ID_", limit: 64
    t.string "PROC_INST_ID_", limit: 64
    t.string "URL_", limit: 4000
    t.string "CONTENT_ID_", limit: 64
  end

  create_table "ACT_HI_COMMENT", primary_key: "ID_", force: :cascade do |t|
    t.string "TYPE_", limit: 255
    t.datetime "TIME_", null: false
    t.string "USER_ID_", limit: 255
    t.string "TASK_ID_", limit: 64
    t.string "PROC_INST_ID_", limit: 64
    t.string "ACTION_", limit: 255
    t.string "MESSAGE_", limit: 4000
    t.binary "FULL_MSG_"
  end

  create_table "ACT_HI_DETAIL", primary_key: "ID_", force: :cascade do |t|
    t.string "TYPE_", limit: 255, null: false
    t.string "PROC_INST_ID_", limit: 64
    t.string "EXECUTION_ID_", limit: 64
    t.string "TASK_ID_", limit: 64
    t.string "ACT_INST_ID_", limit: 64
    t.string "NAME_", limit: 255, null: false
    t.string "VAR_TYPE_", limit: 255
    t.integer "REV_", limit: 11
    t.datetime "TIME_", null: false
    t.string "BYTEARRAY_ID_", limit: 64
    t.float "DOUBLE_"
    t.integer "LONG_", limit: 8
    t.string "TEXT_", limit: 4000
    t.string "TEXT2_", limit: 4000
  end

  add_index "ACT_HI_DETAIL", ["ACT_INST_ID_"], name: "ACT_IDX_HI_DETAIL_ACT_INST", using: :btree
  add_index "ACT_HI_DETAIL", ["NAME_"], name: "ACT_IDX_HI_DETAIL_NAME", using: :btree
  add_index "ACT_HI_DETAIL", ["PROC_INST_ID_"], name: "ACT_IDX_HI_DETAIL_PROC_INST", using: :btree
  add_index "ACT_HI_DETAIL", ["TASK_ID_"], name: "ACT_IDX_HI_DETAIL_TASK_ID", using: :btree
  add_index "ACT_HI_DETAIL", ["TIME_"], name: "ACT_IDX_HI_DETAIL_TIME", using: :btree

  create_table "ACT_HI_IDENTITYLINK", primary_key: "ID_", force: :cascade do |t|
    t.string "GROUP_ID_", limit: 255
    t.string "TYPE_", limit: 255
    t.string "USER_ID_", limit: 255
    t.string "TASK_ID_", limit: 64
    t.string "PROC_INST_ID_", limit: 64
  end

  add_index "ACT_HI_IDENTITYLINK", ["PROC_INST_ID_"], name: "ACT_IDX_HI_IDENT_LNK_PROCINST", using: :btree
  add_index "ACT_HI_IDENTITYLINK", ["TASK_ID_"], name: "ACT_IDX_HI_IDENT_LNK_TASK", using: :btree
  add_index "ACT_HI_IDENTITYLINK", ["USER_ID_"], name: "ACT_IDX_HI_IDENT_LNK_USER", using: :btree

  create_table "ACT_HI_PROCINST", primary_key: "ID_", force: :cascade do |t|
    t.string "PROC_INST_ID_", limit: 64, null: false
    t.string "BUSINESS_KEY_", limit: 255
    t.string "PROC_DEF_ID_", limit: 64, null: false
    t.datetime "START_TIME_", null: false
    t.datetime "END_TIME_"
    t.integer "DURATION_", limit: 8
    t.string "START_USER_ID_", limit: 255
    t.string "START_ACT_ID_", limit: 255
    t.string "END_ACT_ID_", limit: 255
    t.string "SUPER_PROCESS_INSTANCE_ID_", limit: 64
    t.string "DELETE_REASON_", limit: 4000
  end

  add_index "ACT_HI_PROCINST", ["BUSINESS_KEY_"], name: "ACT_IDX_HI_PRO_I_BUSKEY", using: :btree
  add_index "ACT_HI_PROCINST", ["END_TIME_"], name: "ACT_IDX_HI_PRO_INST_END", using: :btree
  add_index "ACT_HI_PROCINST", ["PROC_DEF_ID_", "BUSINESS_KEY_"], name: "ACT_UNIQ_HI_BUS_KEY", unique: true, using: :btree
  add_index "ACT_HI_PROCINST", ["PROC_INST_ID_"], name: "PROC_INST_ID_", unique: true, using: :btree

  create_table "ACT_HI_TASKINST", primary_key: "ID_", force: :cascade do |t|
    t.string "PROC_DEF_ID_", limit: 64
    t.string "TASK_DEF_KEY_", limit: 255
    t.string "PROC_INST_ID_", limit: 64
    t.string "EXECUTION_ID_", limit: 64
    t.string "NAME_", limit: 255
    t.string "PARENT_TASK_ID_", limit: 64
    t.string "DESCRIPTION_", limit: 4000
    t.string "OWNER_", limit: 255
    t.string "ASSIGNEE_", limit: 255
    t.datetime "START_TIME_", null: false
    t.datetime "CLAIM_TIME_"
    t.datetime "END_TIME_"
    t.integer "DURATION_", limit: 8
    t.string "DELETE_REASON_", limit: 4000
    t.integer "PRIORITY_", limit: 11
    t.datetime "DUE_DATE_"
    t.string "FORM_KEY_", limit: 255
  end

  create_table "ACT_HI_VARINST", primary_key: "ID_", force: :cascade do |t|
    t.string "PROC_INST_ID_", limit: 64
    t.string "EXECUTION_ID_", limit: 64
    t.string "TASK_ID_", limit: 64
    t.string "NAME_", limit: 255, null: false
    t.string "VAR_TYPE_", limit: 100
    t.integer "REV_", limit: 11
    t.string "BYTEARRAY_ID_", limit: 64
    t.float "DOUBLE_"
    t.integer "LONG_", limit: 8
    t.string "TEXT_", limit: 4000
    t.string "TEXT2_", limit: 4000
  end

  add_index "ACT_HI_VARINST", ["NAME_", "VAR_TYPE_"], name: "ACT_IDX_HI_PROCVAR_NAME_TYPE", using: :btree
  add_index "ACT_HI_VARINST", ["PROC_INST_ID_"], name: "ACT_IDX_HI_PROCVAR_PROC_INST", using: :btree

  create_table "ACT_RE_DEPLOYMENT", primary_key: "ID_", force: :cascade do |t|
    t.string "NAME_", limit: 255
    t.string "CATEGORY_", limit: 255
    t.datetime "DEPLOY_TIME_", null: false
  end

  create_table "ACT_RE_MODEL", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "NAME_", limit: 255
    t.string "KEY_", limit: 255
    t.string "CATEGORY_", limit: 255
    t.datetime "CREATE_TIME_"
    t.datetime "LAST_UPDATE_TIME_"
    t.integer "VERSION_", limit: 11
    t.string "META_INFO_", limit: 4000
    t.string "DEPLOYMENT_ID_", limit: 64
    t.string "EDITOR_SOURCE_VALUE_ID_", limit: 64
    t.string "EDITOR_SOURCE_EXTRA_VALUE_ID_", limit: 64
  end

  add_index "ACT_RE_MODEL", ["DEPLOYMENT_ID_"], name: "ACT_FK_MODEL_DEPLOYMENT", using: :btree
  add_index "ACT_RE_MODEL", ["EDITOR_SOURCE_EXTRA_VALUE_ID_"], name: "ACT_FK_MODEL_SOURCE_EXTRA", using: :btree
  add_index "ACT_RE_MODEL", ["EDITOR_SOURCE_VALUE_ID_"], name: "ACT_FK_MODEL_SOURCE", using: :btree

  create_table "ACT_RE_PROCDEF", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "CATEGORY_", limit: 255
    t.string "NAME_", limit: 255
    t.string "KEY_", limit: 255, null: false
    t.integer "VERSION_", limit: 11, null: false
    t.string "DEPLOYMENT_ID_", limit: 64
    t.string "RESOURCE_NAME_", limit: 4000
    t.string "DGRM_RESOURCE_NAME_", limit: 4000
    t.string "DESCRIPTION_", limit: 4000
    t.integer "HAS_START_FORM_KEY_", limit: 4
    t.integer "SUSPENSION_STATE_", limit: 11
  end

  add_index "ACT_RE_PROCDEF", ["KEY_", "VERSION_"], name: "ACT_UNIQ_PROCDEF", unique: true, using: :btree

  create_table "ACT_RU_EVENT_SUBSCR", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "EVENT_TYPE_", limit: 255, null: false
    t.string "EVENT_NAME_", limit: 255
    t.string "EXECUTION_ID_", limit: 64
    t.string "PROC_INST_ID_", limit: 64
    t.string "ACTIVITY_ID_", limit: 64
    t.string "CONFIGURATION_", limit: 255
    t.datetime "CREATED_", null: false
  end

  add_index "ACT_RU_EVENT_SUBSCR", ["CONFIGURATION_"], name: "ACT_IDX_EVENT_SUBSCR_CONFIG_", using: :btree
  add_index "ACT_RU_EVENT_SUBSCR", ["EXECUTION_ID_"], name: "ACT_FK_EVENT_EXEC", using: :btree

  create_table "ACT_RU_EXECUTION", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "PROC_INST_ID_", limit: 64
    t.string "BUSINESS_KEY_", limit: 255
    t.string "PARENT_ID_", limit: 64
    t.string "PROC_DEF_ID_", limit: 64
    t.string "SUPER_EXEC_", limit: 64
    t.string "ACT_ID_", limit: 255
    t.integer "IS_ACTIVE_", limit: 4
    t.integer "IS_CONCURRENT_", limit: 4
    t.integer "IS_SCOPE_", limit: 4
    t.integer "IS_EVENT_SCOPE_", limit: 4
    t.integer "SUSPENSION_STATE_", limit: 11
    t.integer "CACHED_ENT_STATE_", limit: 11
  end

  add_index "ACT_RU_EXECUTION", ["BUSINESS_KEY_"], name: "ACT_IDX_EXEC_BUSKEY", using: :btree
  add_index "ACT_RU_EXECUTION", ["PARENT_ID_"], name: "ACT_FK_EXE_PARENT", using: :btree
  add_index "ACT_RU_EXECUTION", ["PROC_DEF_ID_", "BUSINESS_KEY_"], name: "ACT_UNIQ_RU_BUS_KEY", unique: true, using: :btree
  add_index "ACT_RU_EXECUTION", ["PROC_INST_ID_"], name: "ACT_FK_EXE_PROCINST", using: :btree
  add_index "ACT_RU_EXECUTION", ["SUPER_EXEC_"], name: "ACT_FK_EXE_SUPER", using: :btree

  create_table "ACT_RU_IDENTITYLINK", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "GROUP_ID_", limit: 255
    t.string "TYPE_", limit: 255
    t.string "USER_ID_", limit: 255
    t.string "TASK_ID_", limit: 64
    t.string "PROC_INST_ID_", limit: 64
    t.string "PROC_DEF_ID_", limit: 64
  end

  add_index "ACT_RU_IDENTITYLINK", ["GROUP_ID_"], name: "ACT_IDX_IDENT_LNK_GROUP", using: :btree
  add_index "ACT_RU_IDENTITYLINK", ["PROC_DEF_ID_"], name: "ACT_IDX_ATHRZ_PROCEDEF", using: :btree
  add_index "ACT_RU_IDENTITYLINK", ["PROC_INST_ID_"], name: "ACT_FK_IDL_PROCINST", using: :btree
  add_index "ACT_RU_IDENTITYLINK", ["TASK_ID_"], name: "ACT_FK_TSKASS_TASK", using: :btree
  add_index "ACT_RU_IDENTITYLINK", ["USER_ID_"], name: "ACT_IDX_IDENT_LNK_USER", using: :btree

  create_table "ACT_RU_JOB", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "TYPE_", limit: 255, null: false
    t.datetime "LOCK_EXP_TIME_"
    t.string "LOCK_OWNER_", limit: 255
    t.integer "EXCLUSIVE_", limit: 1
    t.string "EXECUTION_ID_", limit: 64
    t.string "PROCESS_INSTANCE_ID_", limit: 64
    t.string "PROC_DEF_ID_", limit: 64
    t.integer "RETRIES_", limit: 11
    t.string "EXCEPTION_STACK_ID_", limit: 64
    t.string "EXCEPTION_MSG_", limit: 4000
    t.datetime "DUEDATE_"
    t.string "REPEAT_", limit: 255
    t.string "HANDLER_TYPE_", limit: 255
    t.string "HANDLER_CFG_", limit: 4000
  end

  add_index "ACT_RU_JOB", ["EXCEPTION_STACK_ID_"], name: "ACT_FK_JOB_EXCEPTION", using: :btree

  create_table "ACT_RU_TASK", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "EXECUTION_ID_", limit: 64
    t.string "PROC_INST_ID_", limit: 64
    t.string "PROC_DEF_ID_", limit: 64
    t.string "NAME_", limit: 255
    t.string "PARENT_TASK_ID_", limit: 64
    t.string "DESCRIPTION_", limit: 4000
    t.string "TASK_DEF_KEY_", limit: 255
    t.string "OWNER_", limit: 255
    t.string "ASSIGNEE_", limit: 255
    t.string "DELEGATION_", limit: 64
    t.integer "PRIORITY_", limit: 11
    t.datetime "CREATE_TIME_", null: false
    t.datetime "DUE_DATE_"
    t.integer "SUSPENSION_STATE_", limit: 11
  end

  add_index "ACT_RU_TASK", ["CREATE_TIME_"], name: "ACT_IDX_TASK_CREATE", using: :btree
  add_index "ACT_RU_TASK", ["EXECUTION_ID_"], name: "ACT_FK_TASK_EXE", using: :btree
  add_index "ACT_RU_TASK", ["PROC_DEF_ID_"], name: "ACT_FK_TASK_PROCDEF", using: :btree
  add_index "ACT_RU_TASK", ["PROC_INST_ID_"], name: "ACT_FK_TASK_PROCINST", using: :btree

  create_table "ACT_RU_VARIABLE", primary_key: "ID_", force: :cascade do |t|
    t.integer "REV_", limit: 11
    t.string "TYPE_", limit: 255, null: false
    t.string "NAME_", limit: 255, null: false
    t.string "EXECUTION_ID_", limit: 64
    t.string "PROC_INST_ID_", limit: 64
    t.string "TASK_ID_", limit: 64
    t.string "BYTEARRAY_ID_", limit: 64
    t.float "DOUBLE_"
    t.integer "LONG_", limit: 8
    t.string "TEXT_", limit: 4000
    t.string "TEXT2_", limit: 4000
  end

  add_index "ACT_RU_VARIABLE", ["BYTEARRAY_ID_"], name: "ACT_FK_VAR_BYTEARRAY", using: :btree
  add_index "ACT_RU_VARIABLE", ["EXECUTION_ID_"], name: "ACT_FK_VAR_EXE", using: :btree
  add_index "ACT_RU_VARIABLE", ["PROC_INST_ID_"], name: "ACT_FK_VAR_PROCINST", using: :btree
  add_index "ACT_RU_VARIABLE", ["TASK_ID_"], name: "ACT_IDX_VARIABLE_TASK_ID", using: :btree

  create_table "aae_balances", force: :cascade do |t|
    t.integer "fs_id", limit: 11
    t.decimal "start_attr1", precision: 20, scale: 2
    t.decimal "end_attr1", precision: 20, scale: 2
    t.decimal "start_attr2", precision: 20, scale: 2
    t.decimal "end_attr2", precision: 20, scale: 2
    t.decimal "start_attr3", precision: 20, scale: 2
    t.decimal "end_attr3", precision: 20, scale: 2
    t.decimal "start_attr4", precision: 20, scale: 2
    t.decimal "end_attr4", precision: 20, scale: 2
    t.decimal "start_attr5", precision: 20, scale: 2
    t.decimal "end_attr5", precision: 20, scale: 2
    t.decimal "start_attr6", precision: 20, scale: 2
    t.decimal "end_attr6", precision: 20, scale: 2
    t.decimal "start_attr7", precision: 20, scale: 2
    t.decimal "end_attr7", precision: 20, scale: 2
    t.decimal "start_attr8", precision: 20, scale: 2
    t.decimal "end_attr8", precision: 20, scale: 2
    t.decimal "start_attr9", precision: 20, scale: 2
    t.decimal "end_attr9", precision: 20, scale: 2
    t.decimal "start_attr10", precision: 20, scale: 2
    t.decimal "end_attr10", precision: 20, scale: 2
    t.decimal "start_attr11", precision: 20, scale: 2
    t.decimal "end_attr11", precision: 20, scale: 2
    t.decimal "start_attr12", precision: 20, scale: 2
    t.decimal "end_attr12", precision: 20, scale: 2
    t.decimal "start_attr13", precision: 20, scale: 2
    t.decimal "end_attr13", precision: 20, scale: 2
    t.decimal "start_attr14", precision: 20, scale: 2
    t.decimal "end_attr14", precision: 20, scale: 2
    t.decimal "start_attr15", precision: 20, scale: 2
    t.decimal "end_attr15", precision: 20, scale: 2
    t.decimal "start_attr16", precision: 20, scale: 2
    t.decimal "end_attr16", precision: 20, scale: 2
    t.decimal "start_attr17", precision: 20, scale: 2
    t.decimal "end_attr17", precision: 20, scale: 2
    t.decimal "start_attr18", precision: 20, scale: 2
    t.decimal "end_attr18", precision: 20, scale: 2
    t.decimal "start_attr19", precision: 20, scale: 2
    t.decimal "end_attr19", precision: 20, scale: 2
    t.decimal "start_attr20", precision: 20, scale: 2
    t.decimal "end_attr20", precision: 20, scale: 2
    t.decimal "start_attr21", precision: 20, scale: 2
    t.decimal "end_attr21", precision: 20, scale: 2
    t.decimal "start_attr22", precision: 20, scale: 2
    t.decimal "end_attr22", precision: 20, scale: 2
    t.decimal "start_attr23", precision: 20, scale: 2
    t.decimal "end_attr23", precision: 20, scale: 2
    t.decimal "start_attr24", precision: 20, scale: 2
    t.decimal "end_attr24", precision: 20, scale: 2
    t.decimal "start_attr25", precision: 20, scale: 2
    t.decimal "end_attr25", precision: 20, scale: 2
    t.decimal "start_attr26", precision: 20, scale: 2
    t.decimal "end_attr26", precision: 20, scale: 2
    t.decimal "start_attr27", precision: 20, scale: 2
    t.decimal "end_attr27", precision: 20, scale: 2
    t.decimal "start_attr28", precision: 20, scale: 2
    t.decimal "end_attr28", precision: 20, scale: 2
    t.decimal "start_attr29", precision: 20, scale: 2
    t.decimal "end_attr29", precision: 20, scale: 2
    t.decimal "start_attr30", precision: 20, scale: 2
    t.decimal "end_attr30", precision: 20, scale: 2
    t.decimal "start_attr31", precision: 20, scale: 2
    t.decimal "end_attr31", precision: 20, scale: 2
    t.decimal "start_attr32", precision: 20, scale: 2
    t.decimal "end_attr32", precision: 20, scale: 2
    t.decimal "start_attr33", precision: 20, scale: 2
    t.decimal "end_attr33", precision: 20, scale: 2
    t.decimal "start_attr34", precision: 20, scale: 2
    t.decimal "end_attr34", precision: 20, scale: 2
    t.decimal "start_attr35", precision: 20, scale: 2
    t.decimal "end_attr35", precision: 20, scale: 2
    t.decimal "start_attr36", precision: 20, scale: 2
    t.decimal "end_attr36", precision: 20, scale: 2
    t.decimal "start_attr37", precision: 20, scale: 2
    t.decimal "end_attr37", precision: 20, scale: 2
    t.decimal "start_attr38", precision: 20, scale: 2
    t.decimal "end_attr38", precision: 20, scale: 2
    t.decimal "end_attr39", precision: 20, scale: 2
    t.decimal "start_attr39", precision: 20, scale: 2
    t.decimal "end_attr40", precision: 20, scale: 2
    t.decimal "start_attr40", precision: 20, scale: 2
    t.decimal "start_attr41", precision: 20, scale: 2
    t.decimal "end_attr41", precision: 20, scale: 2
    t.decimal "start_attr42", precision: 20, scale: 2
    t.decimal "end_attr42", precision: 20, scale: 2
    t.decimal "start_attr43", precision: 20, scale: 2
    t.decimal "end_attr43", precision: 20, scale: 2
    t.decimal "start_attr44", precision: 20, scale: 2
    t.decimal "end_attr44", precision: 20, scale: 2
    t.decimal "start_attr45", precision: 20, scale: 2
    t.decimal "end_attr45", precision: 20, scale: 2
    t.decimal "start_attr46", precision: 20, scale: 2
    t.decimal "end_attr46", precision: 20, scale: 2
    t.decimal "start_attr47", precision: 20, scale: 2
    t.decimal "end_attr47", precision: 20, scale: 2
    t.decimal "start_attr48", precision: 20, scale: 2
    t.decimal "end_attr48", precision: 20, scale: 2
    t.decimal "start_attr49", precision: 20, scale: 2
    t.decimal "end_attr49", precision: 20, scale: 2
    t.decimal "start_attr50", precision: 20, scale: 2
    t.decimal "end_attr50", precision: 20, scale: 2
    t.decimal "start_attr51", precision: 20, scale: 2
    t.decimal "end_attr51", precision: 20, scale: 2
    t.decimal "start_attr52", precision: 20, scale: 2
    t.decimal "end_attr52", precision: 20, scale: 2
    t.decimal "start_attr53", precision: 20, scale: 2
    t.decimal "end_attr53", precision: 20, scale: 2
    t.decimal "start_attr66", precision: 20, scale: 2
    t.decimal "end_attr66", precision: 20, scale: 2
    t.decimal "start_attr67", precision: 20, scale: 2
    t.decimal "end_attr67", precision: 20, scale: 2
    t.decimal "start_attr68", precision: 20, scale: 2
    t.decimal "end_attr68", precision: 20, scale: 2
    t.decimal "start_attr69", precision: 20, scale: 2
    t.decimal "end_attr69", precision: 20, scale: 2
    t.decimal "start_attr70", precision: 20, scale: 2
    t.decimal "end_attr70", precision: 20, scale: 2
    t.decimal "start_attr71", precision: 20, scale: 2
    t.decimal "end_attr71", precision: 20, scale: 2
    t.decimal "start_attr72", precision: 20, scale: 2
    t.decimal "end_attr72", precision: 20, scale: 2
    t.decimal "start_attr73", precision: 20, scale: 2
    t.decimal "end_attr73", precision: 20, scale: 2
    t.decimal "start_attr74", precision: 20, scale: 2
    t.decimal "end_attr74", precision: 20, scale: 2
    t.decimal "start_attr75", precision: 20, scale: 2
    t.decimal "end_attr75", precision: 20, scale: 2
    t.decimal "start_attr76", precision: 20, scale: 2
    t.decimal "end_attr76", precision: 20, scale: 2
    t.decimal "start_attr77", precision: 20, scale: 2
    t.decimal "end_attr77", precision: 20, scale: 2
    t.decimal "start_attr78", precision: 20, scale: 2
    t.decimal "end_attr78", precision: 20, scale: 2
    t.decimal "start_attr79", precision: 20, scale: 2
    t.decimal "end_attr79", precision: 20, scale: 2
    t.decimal "start_attr80", precision: 20, scale: 2
    t.decimal "end_attr80", precision: 20, scale: 2
    t.decimal "start_attr81", precision: 20, scale: 2
    t.decimal "end_attr81", precision: 20, scale: 2
    t.decimal "start_attr82", precision: 20, scale: 2
    t.decimal "end_attr82", precision: 20, scale: 2
    t.decimal "start_attr83", precision: 20, scale: 2
    t.decimal "end_attr83", precision: 20, scale: 2
    t.decimal "start_attr84", precision: 20, scale: 2
    t.decimal "end_attr84", precision: 20, scale: 2
    t.decimal "start_attr85", precision: 20, scale: 2
    t.decimal "end_attr85", precision: 20, scale: 2
    t.decimal "start_attr86", precision: 20, scale: 2
    t.decimal "end_attr86", precision: 20, scale: 2
    t.decimal "start_attr87", precision: 20, scale: 2
    t.decimal "end_attr87", precision: 20, scale: 2
    t.decimal "start_attr88", precision: 20, scale: 2
    t.decimal "end_attr88", precision: 20, scale: 2
    t.decimal "start_attr89", precision: 20, scale: 2
    t.decimal "end_attr89", precision: 20, scale: 2
    t.decimal "start_attr90", precision: 20, scale: 2
    t.decimal "end_attr90", precision: 20, scale: 2
    t.decimal "start_attr91", precision: 20, scale: 2
    t.decimal "end_attr91", precision: 20, scale: 2
    t.decimal "start_attr92", precision: 20, scale: 2
    t.decimal "end_attr92", precision: 20, scale: 2
    t.decimal "start_attr93", precision: 20, scale: 2
    t.decimal "end_attr93", precision: 20, scale: 2
    t.decimal "start_attr94", precision: 20, scale: 2
    t.decimal "end_attr94", precision: 20, scale: 2
    t.decimal "start_attr95", precision: 20, scale: 2
    t.decimal "end_attr95", precision: 20, scale: 2
    t.decimal "start_attr96", precision: 20, scale: 2
    t.decimal "end_attr96", precision: 20, scale: 2
    t.decimal "start_attr97", precision: 20, scale: 2
    t.decimal "end_attr97", precision: 20, scale: 2
    t.decimal "start_attr98", precision: 20, scale: 2
    t.decimal "end_attr98", precision: 20, scale: 2
    t.decimal "start_attr99", precision: 20, scale: 2
    t.decimal "end_attr99", precision: 20, scale: 2
    t.decimal "start_attr100", precision: 20, scale: 2
    t.decimal "end_attr100", precision: 20, scale: 2
    t.decimal "start_attr101", precision: 20, scale: 2
    t.decimal "end_attr101", precision: 20, scale: 2
    t.decimal "start_attr102", precision: 20, scale: 2
    t.decimal "end_attr102", precision: 20, scale: 2
    t.decimal "start_attr103", precision: 20, scale: 2
    t.decimal "end_attr103", precision: 20, scale: 2
    t.decimal "start_attr104", precision: 20, scale: 2
    t.decimal "end_attr104", precision: 20, scale: 2
    t.decimal "start_attr105", precision: 20, scale: 2
    t.decimal "end_attr105", precision: 20, scale: 2
    t.decimal "start_attr106", precision: 20, scale: 2
    t.decimal "end_attr106", precision: 20, scale: 2
    t.decimal "start_attr107", precision: 20, scale: 2
    t.decimal "end_attr107", precision: 20, scale: 2
    t.decimal "start_attr108", precision: 20, scale: 2
    t.decimal "end_attr108", precision: 20, scale: 2
    t.decimal "start_attr109", precision: 20, scale: 2
    t.decimal "end_attr109", precision: 20, scale: 2
    t.decimal "start_attr110", precision: 20, scale: 2
    t.decimal "end_attr110", precision: 20, scale: 2
    t.decimal "start_attr111", precision: 20, scale: 2
    t.decimal "end_attr111", precision: 20, scale: 2
    t.decimal "start_attr112", precision: 20, scale: 2
    t.decimal "end_attr112", precision: 20, scale: 2
    t.decimal "start_attr113", precision: 20, scale: 2
    t.decimal "end_attr113", precision: 20, scale: 2
    t.decimal "start_attr114", precision: 20, scale: 2
    t.decimal "end_attr114", precision: 20, scale: 2
    t.decimal "start_attr115", precision: 20, scale: 2
    t.decimal "end_attr115", precision: 20, scale: 2
    t.decimal "start_attr116", precision: 20, scale: 2
    t.decimal "end_attr116", precision: 20, scale: 2
    t.decimal "start_attr117", precision: 20, scale: 2
    t.decimal "end_attr117", precision: 20, scale: 2
    t.decimal "start_attr118", precision: 20, scale: 2
    t.decimal "end_attr118", precision: 20, scale: 2
    t.decimal "start_attr119", precision: 20, scale: 2
    t.decimal "end_attr119", precision: 20, scale: 2
    t.decimal "start_attr120", precision: 20, scale: 2
    t.decimal "end_attr120", precision: 20, scale: 2
    t.decimal "start_attr121", precision: 20, scale: 2
    t.decimal "end_attr121", precision: 20, scale: 2
    t.decimal "start_attr122", precision: 20, scale: 2
    t.decimal "end_attr122", precision: 20, scale: 2
    t.decimal "start_attr123", precision: 20, scale: 2
    t.decimal "end_attr123", precision: 20, scale: 2
    t.decimal "start_attr124", precision: 20, scale: 2
    t.decimal "end_attr124", precision: 20, scale: 2
    t.decimal "start_attr125", precision: 20, scale: 2
    t.decimal "end_attr125", precision: 20, scale: 2
    t.decimal "start_attr126", precision: 20, scale: 2
    t.decimal "end_attr126", precision: 20, scale: 2
    t.decimal "start_attr127", precision: 20, scale: 2
    t.decimal "end_attr127", precision: 20, scale: 2
    t.decimal "start_attr128", precision: 20, scale: 2
    t.decimal "end_attr128", precision: 20, scale: 2
    t.decimal "start_attr129", precision: 20, scale: 2
    t.decimal "end_attr129", precision: 20, scale: 2
    t.decimal "start_attr130", precision: 20, scale: 2
    t.decimal "end_attr130", precision: 20, scale: 2
    t.decimal "start_attr131", precision: 20, scale: 2
    t.decimal "end_attr131", precision: 20, scale: 2
    t.decimal "start_attr132", precision: 20, scale: 2
    t.decimal "end_attr132", precision: 20, scale: 2
  end

  create_table "aae_cash_flows", force: :cascade do |t|
    t.integer "fs_id", limit: 11
    t.decimal "attr1", precision: 20, scale: 2
    t.decimal "attr2", precision: 20, scale: 2
    t.decimal "attr3", precision: 20, scale: 2
    t.decimal "attr4", precision: 20, scale: 2
    t.decimal "attr5", precision: 20, scale: 2
    t.decimal "attr6", precision: 20, scale: 2
    t.decimal "attr7", precision: 20, scale: 2
    t.decimal "attr8", precision: 20, scale: 2
    t.decimal "attr9", precision: 20, scale: 2
    t.decimal "attr10", precision: 20, scale: 2
    t.decimal "attr11", precision: 20, scale: 2
    t.decimal "attr12", precision: 20, scale: 2
    t.decimal "attr13", precision: 20, scale: 2
    t.decimal "attr14", precision: 20, scale: 2
    t.decimal "attr15", precision: 20, scale: 2
    t.decimal "attr16", precision: 20, scale: 2
    t.decimal "attr17", precision: 20, scale: 2
    t.decimal "attr18", precision: 20, scale: 2
    t.decimal "attr19", precision: 20, scale: 2
    t.decimal "attr20", precision: 20, scale: 2
    t.decimal "attr21", precision: 20, scale: 2
    t.decimal "attr22", precision: 20, scale: 2
    t.decimal "attr23", precision: 20, scale: 2
    t.decimal "attr24", precision: 20, scale: 2
    t.decimal "attr25", precision: 20, scale: 2
    t.decimal "attr26", precision: 20, scale: 2
    t.decimal "attr27", precision: 20, scale: 2
    t.decimal "attr28", precision: 20, scale: 2
    t.decimal "attr29", precision: 20, scale: 2
    t.decimal "attr30", precision: 20, scale: 2
    t.decimal "attr31", precision: 20, scale: 2
    t.decimal "attr32", precision: 20, scale: 2
    t.decimal "attr33", precision: 20, scale: 2
    t.decimal "attr34", precision: 20, scale: 2
    t.decimal "attr35", precision: 20, scale: 2
    t.decimal "attr36", precision: 20, scale: 2
    t.decimal "attr37", precision: 20, scale: 2
    t.decimal "attr38", precision: 20, scale: 2
    t.decimal "attr39", precision: 20, scale: 2
    t.decimal "attr40", precision: 20, scale: 2
    t.decimal "attr41", precision: 20, scale: 2
    t.decimal "attr42", precision: 20, scale: 2
    t.decimal "attr43", precision: 20, scale: 2
    t.decimal "attr44", precision: 20, scale: 2
    t.decimal "attr45", precision: 20, scale: 2
    t.decimal "attr46", precision: 20, scale: 2
    t.decimal "attr47", precision: 20, scale: 2
    t.decimal "attr48", precision: 20, scale: 2
    t.decimal "attr49", precision: 20, scale: 2
    t.decimal "attr50", precision: 20, scale: 2
    t.decimal "attr51", precision: 20, scale: 2
    t.decimal "attr52", precision: 20, scale: 2
    t.decimal "attr53", precision: 20, scale: 2
    t.decimal "attr54", precision: 20, scale: 2
    t.decimal "attr55", precision: 20, scale: 2
    t.decimal "attr56", precision: 20, scale: 2
    t.decimal "attr57", precision: 20, scale: 2
    t.decimal "attr58", precision: 20, scale: 2
    t.decimal "attr59", precision: 20, scale: 2
    t.decimal "attr60", precision: 20, scale: 2
    t.decimal "attr61", precision: 20, scale: 2
    t.decimal "attr64", precision: 20, scale: 2
    t.decimal "attr65", precision: 20, scale: 2
    t.decimal "attr66", precision: 20, scale: 2
    t.decimal "attr67", precision: 20, scale: 2
    t.decimal "attr68", precision: 20, scale: 2
    t.decimal "attr69", precision: 20, scale: 2
    t.decimal "attr70", precision: 20, scale: 2
    t.decimal "attr71", precision: 20, scale: 2
    t.decimal "attr72", precision: 20, scale: 2
    t.decimal "attr73", precision: 20, scale: 2
    t.decimal "attr74", precision: 20, scale: 2
    t.decimal "attr75", precision: 20, scale: 2
    t.decimal "attr76", precision: 20, scale: 2
    t.decimal "attr77", precision: 20, scale: 2
    t.decimal "attr78", precision: 20, scale: 2
    t.decimal "attr79", precision: 20, scale: 2
    t.decimal "attr80", precision: 20, scale: 2
    t.decimal "attr81", precision: 20, scale: 2
    t.decimal "attr82", precision: 20, scale: 2
    t.decimal "attr83", precision: 20, scale: 2
    t.decimal "attr84", precision: 20, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aae_financial_statements", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.integer "year", limit: 11
    t.integer "month", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "aae_indicators", force: :cascade do |t|
    t.integer "fs_id", limit: 11
    t.decimal "indicator_attr1", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr2", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr3", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr4", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr5", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr6", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr7", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr8", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr9", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr10", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr11", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr12", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr13", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr14", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr15", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr16", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr17", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr18", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr19", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr20", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr21", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr22", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr23", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr24", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr25", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr26", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr27", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr28", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr29", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr30", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr31", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr32", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr33", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr34", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr35", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr36", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr37", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr38", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr39", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr40", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr41", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr42", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr43", precision: 20, scale: 2, default: 0.0
    t.decimal "indicator_attr44", precision: 20, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aae_profits", force: :cascade do |t|
    t.integer "fs_id", limit: 11
    t.decimal "m_attr1", precision: 20, scale: 2
    t.decimal "y_attr1", precision: 20, scale: 2
    t.decimal "m_attr2", precision: 20, scale: 2
    t.decimal "y_attr2", precision: 20, scale: 2
    t.decimal "m_attr3", precision: 20, scale: 2
    t.decimal "y_attr3", precision: 20, scale: 2
    t.decimal "m_attr4", precision: 20, scale: 2
    t.decimal "y_attr4", precision: 20, scale: 2
    t.decimal "m_attr5", precision: 20, scale: 2
    t.decimal "y_attr5", precision: 20, scale: 2
    t.decimal "m_attr6", precision: 20, scale: 2
    t.decimal "y_attr6", precision: 20, scale: 2
    t.decimal "m_attr7", precision: 20, scale: 2
    t.decimal "y_attr7", precision: 20, scale: 2
    t.decimal "m_attr8", precision: 20, scale: 2
    t.decimal "y_attr8", precision: 20, scale: 2
    t.decimal "m_attr9", precision: 20, scale: 2
    t.decimal "y_attr9", precision: 20, scale: 2
    t.decimal "m_attr10", precision: 20, scale: 2
    t.decimal "y_attr10", precision: 20, scale: 2
    t.decimal "m_attr11", precision: 20, scale: 2
    t.decimal "y_attr11", precision: 20, scale: 2
    t.decimal "m_attr12", precision: 20, scale: 2
    t.decimal "y_attr12", precision: 20, scale: 2
    t.decimal "m_attr13", precision: 20, scale: 2
    t.decimal "y_attr13", precision: 20, scale: 2
    t.decimal "m_attr14", precision: 20, scale: 2
    t.decimal "y_attr14", precision: 20, scale: 2
    t.decimal "m_attr15", precision: 20, scale: 2
    t.decimal "y_attr15", precision: 20, scale: 2
    t.decimal "m_attr16", precision: 20, scale: 2
    t.decimal "y_attr16", precision: 20, scale: 2
    t.decimal "m_attr17", precision: 20, scale: 2
    t.decimal "y_attr17", precision: 20, scale: 2
    t.decimal "m_attr18", precision: 20, scale: 2
    t.decimal "y_attr18", precision: 20, scale: 2
    t.decimal "m_attr19", precision: 20, scale: 2
    t.decimal "y_attr19", precision: 20, scale: 2
    t.decimal "m_attr20", precision: 20, scale: 2
    t.decimal "y_attr20", precision: 20, scale: 2
    t.decimal "m_attr21", precision: 20, scale: 2
    t.decimal "y_attr21", precision: 20, scale: 2
    t.decimal "m_attr22", precision: 20, scale: 2
    t.decimal "y_attr22", precision: 20, scale: 2
    t.decimal "m_attr23", precision: 20, scale: 2
    t.decimal "y_attr23", precision: 20, scale: 2
    t.decimal "m_attr24", precision: 20, scale: 2
    t.decimal "y_attr24", precision: 20, scale: 2
    t.decimal "m_attr25", precision: 20, scale: 2
    t.decimal "y_attr25", precision: 20, scale: 2
    t.decimal "m_attr26", precision: 20, scale: 2
    t.decimal "y_attr26", precision: 20, scale: 2
    t.decimal "m_attr27", precision: 20, scale: 2
    t.decimal "y_attr27", precision: 20, scale: 2
    t.decimal "m_attr28", precision: 20, scale: 2
    t.decimal "y_attr28", precision: 20, scale: 2
    t.decimal "m_attr29", precision: 20, scale: 2
    t.decimal "y_attr29", precision: 20, scale: 2
    t.decimal "m_attr30", precision: 20, scale: 2
    t.decimal "y_attr30", precision: 20, scale: 2
    t.decimal "m_attr31", precision: 20, scale: 2
    t.decimal "y_attr31", precision: 20, scale: 2
    t.decimal "m_attr32", precision: 20, scale: 2
    t.decimal "y_attr32", precision: 20, scale: 2
    t.decimal "m_attr33", precision: 20, scale: 2
    t.decimal "y_attr33", precision: 20, scale: 2
    t.decimal "m_attr34", precision: 20, scale: 2
    t.decimal "y_attr34", precision: 20, scale: 2
    t.decimal "m_attr35", precision: 20, scale: 2
    t.decimal "y_attr35", precision: 20, scale: 2
    t.decimal "m_attr36", precision: 20, scale: 2
    t.decimal "y_attr36", precision: 20, scale: 2
    t.decimal "m_attr37", precision: 20, scale: 2
    t.decimal "y_attr37", precision: 20, scale: 2
    t.decimal "m_attr38", precision: 20, scale: 2
    t.decimal "y_attr38", precision: 20, scale: 2
    t.decimal "m_attr39", precision: 20, scale: 2
    t.decimal "y_attr39", precision: 20, scale: 2
    t.decimal "m_attr40", precision: 20, scale: 2
    t.decimal "y_attr40", precision: 20, scale: 2
    t.decimal "m_attr41", precision: 20, scale: 2
    t.decimal "y_attr41", precision: 20, scale: 2
    t.decimal "m_attr42", precision: 20, scale: 2
    t.decimal "y_attr42", precision: 20, scale: 2
    t.decimal "m_attr43", precision: 20, scale: 2
    t.decimal "y_attr43", precision: 20, scale: 2
    t.decimal "m_attr44", precision: 20, scale: 2
    t.decimal "y_attr44", precision: 20, scale: 2
    t.decimal "m_attr45", precision: 20, scale: 2
    t.decimal "y_attr45", precision: 20, scale: 2
    t.decimal "m_attr46", precision: 20, scale: 2
    t.decimal "y_attr46", precision: 20, scale: 2
    t.decimal "m_attr47", precision: 20, scale: 2
    t.decimal "y_attr47", precision: 20, scale: 2
    t.decimal "m_attr48", precision: 20, scale: 2
    t.decimal "y_attr48", precision: 20, scale: 2
    t.decimal "m_attr49", precision: 20, scale: 2
    t.decimal "y_attr49", precision: 20, scale: 2
    t.decimal "m_attr50", precision: 20, scale: 2
    t.decimal "y_attr50", precision: 20, scale: 2
    t.decimal "m_attr51", precision: 20, scale: 2
    t.decimal "y_attr51", precision: 20, scale: 2
    t.decimal "m_attr52", precision: 20, scale: 2
    t.decimal "y_attr52", precision: 20, scale: 2
    t.decimal "m_attr53", precision: 20, scale: 2
    t.decimal "y_attr53", precision: 20, scale: 2
    t.decimal "m_attr54", precision: 20, scale: 2
    t.decimal "y_attr54", precision: 20, scale: 2
    t.decimal "m_attr55", precision: 20, scale: 2
    t.decimal "y_attr55", precision: 20, scale: 2
    t.decimal "m_attr56", precision: 20, scale: 2
    t.decimal "y_attr56", precision: 20, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cl_contents", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "row", limit: 11
    t.integer "col", limit: 11
    t.integer "rows", limit: 11
    t.integer "cols", limit: 11
    t.string "code", limit: 255
    t.integer "header_id", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cl_headers", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "resource_type", limit: 255
    t.string "code", limit: 255
    t.integer "order", limit: 11
    t.text "ary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fdn_announcements", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "content"
    t.integer "seq", limit: 11
    t.integer "useful", limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "fdn_dashboards", force: :cascade do |t|
    t.integer "user_id", limit: 11
    t.integer "organization_id", limit: 11
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.integer "active", limit: 11
    t.text "layout"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_dashboards", ["organization_id", "active"], name: "index_fdn_dashboards_on_organization_id_and_active", using: :btree
  add_index "fdn_dashboards", ["user_id", "active"], name: "index_fdn_dashboards_on_user_id_and_active", using: :btree

  create_table "fdn_dept_histories", force: :cascade do |t|
    t.integer "dept_id", limit: 11
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "seq", limit: 11
    t.integer "internal", limit: 11
    t.string "type_code", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fdn_depts", force: :cascade do |t|
    t.integer "seq", limit: 11
    t.integer "internal", limit: 11
    t.datetime "start_time"
    t.string "type_code", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_depts", ["internal"], name: "index_fdn_depts_on_internal", using: :btree

  create_table "fdn_ent_ind_histories", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.integer "industry_id", limit: 11
    t.integer "seq", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fdn_ent_individual_histories", force: :cascade do |t|
    t.string "individual_name", limit: 255
    t.string "actual_investor", limit: 255
    t.integer "ent_id", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "last_id", limit: 11
  end

  create_table "fdn_ent_individuals", force: :cascade do |t|
    t.string "individual_name", limit: 255
    t.string "actual_investor", limit: 255
    t.integer "ent_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fdn_ent_investor_histories", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.string "investor_type_code", limit: 255
    t.integer "org_id", limit: 11
    t.string "investor_name", limit: 255
    t.string "region_code", limit: 255
    t.string "org_type_code", limit: 255
    t.string "industry_code", limit: 255
    t.decimal "amount", precision: 20, scale: 2
    t.decimal "percentage", precision: 20, scale: 2
    t.integer "lock_version", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
    t.decimal "actual_amt", precision: 10, scale: 2
    t.integer "last_id", limit: 11
    t.decimal "actual_amt_foreign", precision: 10, scale: 2
    t.decimal "capital_contribution", precision: 10, scale: 2
    t.decimal "capital_contribution_foreign", precision: 10, scale: 2
    t.decimal "foreign_currency", precision: 10, scale: 2
  end

  create_table "fdn_ent_investors", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.string "investor_type_code", limit: 255
    t.integer "org_id", limit: 11
    t.string "investor_name", limit: 255
    t.string "region_code", limit: 255
    t.string "org_type_code", limit: 255
    t.string "industry_code", limit: 255
    t.decimal "amount", precision: 20, scale: 2
    t.decimal "percentage", precision: 20, scale: 2
    t.integer "lock_version", limit: 11
    t.decimal "actual_amt", precision: 10, scale: 2
    t.integer "last_id", limit: 11
    t.decimal "actual_amt_foreign", precision: 10, scale: 2
    t.decimal "capital_contribution", precision: 10, scale: 2
    t.decimal "capital_contribution_foreign", precision: 10, scale: 2
    t.decimal "foreign_currency", precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_ent_investors", ["ent_id"], name: "index_fdn_ent_investors_on_ent_id", using: :btree
  add_index "fdn_ent_investors", ["org_id"], name: "index_fdn_ent_investors_on_org_id", using: :btree

  create_table "fdn_ent_result_histories", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.integer "row_template_id", limit: 11
    t.decimal "value", precision: 20, scale: 2
    t.integer "lock_version", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
    t.decimal "exchange_rate", precision: 20, scale: 2
    t.decimal "foreign_currency", precision: 20, scale: 2
    t.integer "currency_code", limit: 11
    t.decimal "ent_declare_value", precision: 20, scale: 2
    t.decimal "app_value", precision: 20, scale: 2
    t.decimal "last_reg_value", precision: 20, scale: 2
  end

  create_table "fdn_ent_results", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.integer "row_template_id", limit: 11
    t.decimal "value", precision: 20, scale: 2
    t.integer "lock_version", limit: 11
    t.decimal "exchange_rate", precision: 20, scale: 2
    t.decimal "foreign_currency", precision: 20, scale: 2
    t.integer "currency_code", limit: 11
    t.decimal "ent_declare_value", precision: 20, scale: 2
    t.decimal "app_value", precision: 20, scale: 2
    t.decimal "last_reg_value", precision: 20, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_ent_results", ["ent_id"], name: "index_fdn_ent_results_on_ent_id", using: :btree
  add_index "fdn_ent_results", ["row_template_id"], name: "index_fdn_ent_results_on_row_template_id", using: :btree

  create_table "fdn_enterprise_histories", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "ent_code", limit: 255
    t.string "status", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.string "legal", limit: 255
    t.string "ent_level_code", limit: 255
    t.string "parent_group_code", limit: 255
    t.string "currency_code", limit: 255
    t.decimal "reg_amt", precision: 20, scale: 2
    t.string "address", limit: 100
    t.string "postal_code", limit: 255
    t.integer "latest_ppr_id", limit: 11
    t.string "ppr_status_code", limit: 10
    t.string "ent_type_code", limit: 255
    t.string "operate_status_code", limit: 255
    t.string "statistics_code", limit: 255
    t.string "main_ind_code", limit: 255
    t.string "ent_region_code", limit: 255
    t.date "reg_date"
    t.integer "is_reg", limit: 11
    t.integer "is_outside_to_inside", limit: 11
    t.integer "is_foreign", limit: 11
    t.integer "is_gov_inv_main_ind", limit: 11
    t.integer "main_inv_org_id", limit: 11
    t.integer "purpose", limit: 11
    t.decimal "exchange_rate", precision: 20, scale: 2
    t.integer "individual", limit: 11
    t.date "purpose_to"
    t.decimal "foreign_currency", precision: 20, scale: 2
    t.string "purpose_from", limit: 255
    t.decimal "reg_amt_foreign", precision: 20, scale: 6
    t.integer "gov_inv_id", limit: 11
    t.string "dept_name", limit: 255
    t.integer "dept_id", limit: 11
    t.integer "sasac_dept_id", limit: 11
    t.integer "is_direct_sup", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "fdn_enterprises", force: :cascade do |t|
    t.string "ent_code", limit: 255
    t.string "status", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.string "legal", limit: 255
    t.string "ent_level_code", limit: 255
    t.string "parent_group_code", limit: 255
    t.string "currency_code", limit: 255
    t.decimal "reg_amt", precision: 20, scale: 2
    t.string "address", limit: 100
    t.string "postal_code", limit: 255
    t.string "ent_industry_code", limit: 255
    t.integer "latest_ppr_id", limit: 11
    t.string "ppr_status_code", limit: 10
    t.string "ent_type_code", limit: 255
    t.string "operate_status_code", limit: 255
    t.string "statistics_code", limit: 255
    t.string "main_ind_code", limit: 255
    t.string "ent_region_code", limit: 255
    t.date "reg_date"
    t.integer "is_reg", limit: 11
    t.integer "is_outside_to_inside", limit: 11
    t.integer "is_foreign", limit: 11
    t.integer "is_gov_inv_main_ind", limit: 11
    t.integer "main_inv_org_id", limit: 11
    t.integer "purpose", limit: 11
    t.decimal "exchange_rate", precision: 20, scale: 2
    t.integer "individual", limit: 11
    t.date "purpose_to"
    t.decimal "foreign_currency", precision: 20, scale: 2
    t.datetime "start_time"
    t.string "purpose_from", limit: 255
    t.decimal "reg_amt_foreign", precision: 20, scale: 6
    t.integer "gov_inv_id", limit: 11
    t.string "dept_name", limit: 255
    t.integer "dept_id", limit: 11
    t.integer "sasac_dept_id", limit: 11
    t.integer "is_direct_sup", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_enterprises", ["ent_code"], name: "fdn_enterprises_ind1", using: :btree
  add_index "fdn_enterprises", ["ent_level_code", "ent_type_code", "operate_status_code"], name: "fdn_enterprises_ind2", using: :btree
  add_index "fdn_enterprises", ["ent_region_code"], name: "fdn_enterprises_ind4", using: :btree
  add_index "fdn_enterprises", ["is_foreign"], name: "fdn_enterprises_ind5", using: :btree
  add_index "fdn_enterprises", ["main_ind_code"], name: "fdn_enterprises_ind3", using: :btree

  create_table "fdn_enterprises_industries", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.string "industry_id", limit: 255
    t.integer "seq", limit: 11
    t.integer "last_id", limit: 11
  end

  add_index "fdn_enterprises_industries", ["ent_id", "industry_id", "seq"], name: "fdn_enterprises_industries_ind1", unique: true, using: :btree

  create_table "fdn_events", force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "resource_type", limit: 255
    t.integer "resource_id", limit: 11
    t.integer "template_id", limit: 11
    t.string "person_in_charge", limit: 255
    t.string "contact", limit: 255
    t.string "abstract", limit: 255
    t.date "event_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_events", ["created_by", "start_at", "end_at"], name: "fdn_events_ind1", using: :btree
  add_index "fdn_events", ["resource_type", "resource_id"], name: "fdn_events_ind2", using: :btree

  create_table "fdn_file_resources", force: :cascade do |t|
    t.integer "resource_id", limit: 11
    t.string "resource_type", limit: 255
    t.integer "ffx_file_size", limit: 11
    t.string "ffx_content_type", limit: 255
    t.string "ffx_file_name", limit: 255
    t.string "display_name", limit: 255
    t.string "status", limit: 255
    t.string "file_desc", limit: 255
    t.integer "file_class_id", limit: 11
    t.integer "file_template_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_file_resources", ["resource_id", "resource_type", "file_class_id"], name: "fdn_file_resources_ind1", using: :btree

  create_table "fdn_file_templates", force: :cascade do |t|
    t.string "resource_type", limit: 80
    t.string "template_class", limit: 50
    t.string "template_name", limit: 255
    t.string "file_name", limit: 255
    t.integer "seq", limit: 11
    t.string "template_type", limit: 30
    t.string "status", limit: 10
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_file_templates", ["resource_type", "template_class", "template_type", "status"], name: "fdn_file_templates_ind1", using: :btree
  add_index "fdn_file_templates", ["resource_type"], name: "index_fdn_file_templates_on_resource_type", using: :btree

  create_table "fdn_homepages", force: :cascade do |t|
    t.integer "dashboard_id", limit: 11
    t.integer "organization_id", limit: 11
    t.integer "user_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_homepages", ["organization_id", "dashboard_id"], name: "index_fdn_homepages_on_organization_id_and_dashboard_id", using: :btree
  add_index "fdn_homepages", ["user_id", "dashboard_id"], name: "index_fdn_homepages_on_user_id_and_dashboard_id", using: :btree

  create_table "fdn_jq_users", force: :cascade do |t|
    t.string "user_name", limit: 255
    t.string "resource_type", limit: 255
    t.integer "resource_id", limit: 11
    t.string "memo", limit: 255
    t.string "status", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fdn_legend_categories", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.integer "parent_id", limit: 11
    t.string "status", limit: 255, default: "Y"
    t.integer "children_count", limit: 11
    t.integer "position", limit: 11
    t.integer "depth", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "fdn_legend_menhus", force: :cascade do |t|
    t.string "position", limit: 255
    t.integer "legend_category_id", limit: 11
    t.string "memo", limit: 255
    t.string "title", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fdn_legends", force: :cascade do |t|
    t.integer "org_id", limit: 11
    t.string "type_code", limit: 255
    t.string "title", limit: 255
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "fdn_loggers", force: :cascade do |t|
    t.integer "user_id", limit: 11
    t.string "ip", limit: 20
    t.string "controller", limit: 100
    t.string "action", limit: 100
    t.datetime "act_at"
  end

  add_index "fdn_loggers", ["controller", "action"], name: "fdn_loggers_ind1", using: :btree
  add_index "fdn_loggers", ["user_id"], name: "index_fdn_loggers_on_user_id", using: :btree

  create_table "fdn_lookups", force: :cascade do |t|
    t.string "code", limit: 255
    t.string "type", limit: 255
    t.string "type_name", limit: 255
    t.string "value", limit: 255
    t.string "description", limit: 255
    t.string "status", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.integer "seq", limit: 11
    t.integer "parent_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_lookups", ["parent_id"], name: "fdn_lookups_ind3", using: :btree
  add_index "fdn_lookups", ["type", "code"], name: "fdn_lookups_ind2", using: :btree
  add_index "fdn_lookups", ["type", "status"], name: "fdn_lookups_ind1", using: :btree

  create_table "fdn_menus", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.string "description", limit: 255
    t.string "title_img", limit: 255
    t.string "controller", limit: 255
    t.string "action", limit: 255
    t.string "params", limit: 255
    t.string "route_path", limit: 255
    t.integer "parent_id", limit: 11
    t.integer "children_count", limit: 11
    t.integer "position", limit: 11
    t.integer "depth", limit: 11
    t.string "status", limit: 1, default: "Y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_menus", ["code"], name: "index_fdn_menus_on_code", using: :btree
  add_index "fdn_menus", ["parent_id"], name: "index_fdn_menus_on_parent_id", using: :btree
  add_index "fdn_menus", ["status"], name: "index_fdn_menus_on_status", using: :btree

  create_table "fdn_messages", force: :cascade do |t|
    t.string "subject", limit: 255
    t.text "body"
    t.string "sender_type", limit: 255
    t.integer "sender_id", limit: 11
    t.integer "reply_of", limit: 11
    t.integer "forward_from", limit: 11
    t.integer "group_id", limit: 11
    t.integer "trashed_by_sender", limit: 11, default: 0
    t.string "status", limit: 255
    t.text "receivers"
    t.string "msg_type", limit: 255
    t.integer "msg_type_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_messages", ["sender_id", "sender_type", "trashed_by_sender", "status", "created_at"], name: "fdn_messages_ind1", using: :btree

  create_table "fdn_old_codes", force: :cascade do |t|
    t.string "code", limit: 255
    t.string "name", limit: 255
    t.string "short_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fdn_org_groups", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "org_ids", limit: 255
    t.string "desc", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "fdn_org_hie_elements", force: :cascade do |t|
    t.integer "org_hie_version_id", limit: 11
    t.integer "parent_id", limit: 11
    t.integer "child_id", limit: 11
    t.integer "root_id", limit: 11
    t.integer "distance", limit: 11
    t.integer "seq", limit: 11
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "org_hierarchy_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_org_hie_elements", ["end_time"], name: "fdn_org_hie_elements_ind6", using: :btree
  add_index "fdn_org_hie_elements", ["org_hie_version_id", "child_id", "distance"], name: "fdn_org_hie_elements_ind2", using: :btree
  add_index "fdn_org_hie_elements", ["org_hie_version_id", "parent_id", "distance"], name: "fdn_org_hie_elements_ind1", using: :btree
  add_index "fdn_org_hie_elements", ["org_hie_version_id", "root_id", "distance"], name: "fdn_org_hie_elements_ind3", using: :btree
  add_index "fdn_org_hie_elements", ["start_time", "end_time"], name: "fdn_org_hie_elements_ind4", using: :btree
  add_index "fdn_org_hie_elements", ["start_time"], name: "fdn_org_hie_elements_ind5", using: :btree

  create_table "fdn_org_hie_versions", force: :cascade do |t|
    t.integer "org_hierarchy_id", limit: 11
    t.integer "ver", limit: 11
    t.date "start_date"
    t.date "end_date"
    t.integer "current_flag", limit: 11
    t.integer "resource_id", limit: 11
    t.string "resource_type", limit: 255
    t.integer "version", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_org_hie_versions", ["org_hierarchy_id", "current_flag"], name: "fdn_org_hie_versions_ind1", using: :btree
  add_index "fdn_org_hie_versions", ["org_hierarchy_id", "ver"], name: "fdn_org_hie_versions_ind2", using: :btree
  add_index "fdn_org_hie_versions", ["resource_id", "resource_type"], name: "fdn_org_hie_versions_ind3", using: :btree

  create_table "fdn_org_hierarchies", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "short_name", limit: 255
    t.string "code", limit: 255
    t.integer "main_flag", limit: 11
    t.integer "org_id", limit: 11
    t.integer "version", limit: 11
    t.string "icon", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_org_hierarchies", ["code"], name: "index_fdn_org_hierarchies_on_code", using: :btree
  add_index "fdn_org_hierarchies", ["main_flag"], name: "index_fdn_org_hierarchies_on_main_flag", using: :btree
  add_index "fdn_org_hierarchies", ["org_id"], name: "index_fdn_org_hierarchies_on_org_id", using: :btree

  create_table "fdn_org_shorts", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "organization_id", limit: 11
    t.integer "act_dept_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_org_shorts", ["organization_id", "act_dept_id"], name: "fdn_org_shorts_ind1", using: :btree

  create_table "fdn_org_tree_changes", force: :cascade do |t|
    t.integer "hierarchy_id", limit: 11
    t.datetime "change_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "fdn_organization_histories", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "name", limit: 255
    t.text "description"
    t.string "code", limit: 255
    t.string "short_name", limit: 255
    t.string "org_type", limit: 255
    t.string "resource_type", limit: 255
    t.integer "resource_id", limit: 11
    t.integer "lock_version", limit: 11
    t.string "purpose_from", limit: 255
    t.decimal "reg_amt_foreign", precision: 20, scale: 6
    t.integer "gov_inv_id", limit: 11
    t.string "dept_name", limit: 255
    t.integer "dept_id", limit: 11
    t.integer "sasac_dept_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "fdn_organizations", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.string "code", limit: 255
    t.string "short_name", limit: 255
    t.string "org_type", limit: 255
    t.string "resource_type", limit: 255
    t.integer "resource_id", limit: 11
    t.integer "version", limit: 11
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_organizations", ["code"], name: "index_fdn_organizations_on_code", using: :btree
  add_index "fdn_organizations", ["org_type"], name: "index_fdn_organizations_on_org_type", using: :btree
  add_index "fdn_organizations", ["resource_type", "resource_id"], name: "fdn_organizations_ind1", using: :btree

  create_table "fdn_predef_opinion_templates", force: :cascade do |t|
    t.string "type_code", limit: 255
    t.string "content", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_predef_opinion_templates", ["type_code"], name: "index_fdn_predef_opinion_templates_on_type_code", using: :btree

  create_table "fdn_predef_opinions", force: :cascade do |t|
    t.string "type_code", limit: 255
    t.string "content", limit: 255
    t.integer "user_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_predef_opinions", ["user_id", "type_code"], name: "fdn_predef_opinions_ind1", using: :btree

  create_table "fdn_received_messages", force: :cascade do |t|
    t.integer "message_id", limit: 11
    t.integer "receiver_id", limit: 11
    t.string "receiver_type", limit: 255
    t.integer "trashed_by_receiver", limit: 11, default: 0
    t.integer "read", limit: 11, default: 0
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_received_messages", ["message_id"], name: "index_fdn_received_messages_on_message_id", using: :btree
  add_index "fdn_received_messages", ["receiver_id", "receiver_type", "trashed_by_receiver", "created_at", "read"], name: "fdn_received_messages_ind1", using: :btree

  create_table "fdn_regions", force: :cascade do |t|
    t.string "region_code", limit: 255
    t.string "country", limit: 255
    t.string "province", limit: 255
    t.string "city", limit: 255
    t.string "county", limit: 255
    t.integer "parent_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_regions", ["country", "province", "city"], name: "fdn_regions_ind1", using: :btree
  add_index "fdn_regions", ["country"], name: "index_fdn_regions_on_country", using: :btree
  add_index "fdn_regions", ["parent_id"], name: "index_fdn_regions_on_parent_id", using: :btree
  add_index "fdn_regions", ["region_code"], name: "index_fdn_regions_on_region_code", using: :btree

  create_table "fdn_rights", force: :cascade do |t|
    t.string "code", limit: 255
    t.string "type_code", limit: 255
    t.string "description", limit: 255
    t.string "app_code", limit: 255
    t.string "controller", limit: 255
    t.string "action", limit: 255
    t.integer "menu_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_rights", ["app_code"], name: "index_fdn_rights_on_app_code", using: :btree
  add_index "fdn_rights", ["menu_id"], name: "index_fdn_rights_on_menu_id", using: :btree
  add_index "fdn_rights", ["type_code", "code"], name: "fdn_rights_ind1", using: :btree

  create_table "fdn_roles", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.string "description", limit: 255
    t.integer "organization_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_roles", ["code"], name: "index_fdn_roles_on_code", using: :btree
  add_index "fdn_roles", ["organization_id"], name: "index_fdn_roles_on_organization_id", using: :btree

  create_table "fdn_templates", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.text "content"
    t.integer "menu_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_templates", ["code"], name: "index_fdn_templates_on_code", using: :btree
  add_index "fdn_templates", ["menu_id"], name: "index_fdn_templates_on_menu_id", using: :btree

  create_table "fdn_user_groups", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "contact_ids", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_user_groups", ["created_by"], name: "index_fdn_user_groups_on_created_by", using: :btree

  create_table "fdn_user_informations", force: :cascade do |t|
    t.string "full_name", limit: 255
    t.string "tel", limit: 255
    t.string "mobile", limit: 255
    t.string "fax", limit: 255
    t.string "address", limit: 255
    t.string "postal_code", limit: 255
    t.string "email", limit: 255
    t.string "post", limit: 255
    t.string "im_soft", limit: 255
    t.text "memo"
    t.integer "user_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_user_informations", ["user_id", "full_name"], name: "fdn_user_informations_ind1", using: :btree

  create_table "fdn_users", force: :cascade do |t|
    t.string "username", limit: 255, null: false
    t.string "encrypted_password", limit: 255, null: false
    t.string "password_salt", limit: 255, null: false
    t.string "persistence_token", limit: 255, null: false
    t.string "single_access_token", limit: 255, null: false
    t.string "perishable_token", limit: 255, null: false
    t.string "resource_type", limit: 255
    t.integer "resource_id", limit: 11
    t.string "status", limit: 255
    t.string "ghost", limit: 255, default: "N"
    t.integer "login_count", limit: 11, default: 0, null: false
    t.integer "failed_login_count", limit: 11, default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string "current_login_ip", limit: 255
    t.string "last_login_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_users", ["persistence_token"], name: "index_fdn_users_on_persistence_token", using: :btree
  add_index "fdn_users", ["resource_type", "resource_id"], name: "fdn_users_ind1", using: :btree
  add_index "fdn_users", ["status"], name: "index_fdn_users_on_status", using: :btree
  add_index "fdn_users", ["username"], name: "index_fdn_users_on_username", using: :btree

  create_table "fdn_widget_actions", force: :cascade do |t|
    t.integer "widget_id", limit: 11
    t.string "value", limit: 255
    t.string "icon", limit: 255
    t.text "href"
    t.text "onclick"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_widget_actions", ["widget_id"], name: "index_fdn_widget_actions_on_widget_id", using: :btree

  create_table "fdn_widgets", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.string "url", limit: 255
    t.string "title", limit: 255
    t.integer "bold", limit: 11
    t.integer "higher", limit: 11
    t.string "params", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  add_index "fdn_widgets", ["code"], name: "index_fdn_widgets_on_code", using: :btree

  create_table "fdn_work_calendars", force: :cascade do |t|
    t.integer "year", limit: 11
    t.integer "qtr", limit: 11
    t.integer "month", limit: 11
    t.integer "day_of_week", limit: 11
    t.date "day_name"
    t.integer "is_working", limit: 11
    t.integer "is_weekend", limit: 11
    t.integer "is_holiday", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fdn_work_calendars", ["year", "month"], name: "fdn_work_calendars_ind1", using: :btree

  create_table "hr_assesses", force: :cascade do |t|
    t.string "people_id", limit: 255
    t.string "assess_class", limit: 255
    t.string "assess_unit", limit: 255
    t.date "assess_start_time"
    t.date "assess_end_time"
    t.string "assess_result", limit: 255
    t.string "help_attach", limit: 255
    t.text "explain"
    t.integer "worker_code", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_degrees", force: :cascade do |t|
    t.string "people_id", limit: 255
    t.string "form_learn", limit: 255
    t.string "e_experience", limit: 255
    t.string "degree_two_code", limit: 255
    t.string "major", limit: 255
    t.date "admission_time"
    t.date "graduation_time"
    t.string "g_school_unit", limit: 255
    t.string "degree", limit: 255
    t.date "degree_time"
    t.string "degree_unit", limit: 255
    t.integer "worker_code", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_demobilizeds", force: :cascade do |t|
    t.string "people_id", limit: 255
    t.date "demobilized_year"
    t.string "retired_Post", limit: 255
    t.integer "worker_code", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_educations", force: :cascade do |t|
    t.string "people_id", limit: 255
    t.string "education_nature", limit: 255
    t.string "education_mode", limit: 255
    t.string "education_content", limit: 255
    t.string "education_class", limit: 255
    t.string "education_result", limit: 255
    t.string "credit", limit: 255
    t.date "start_time"
    t.date "end_time"
    t.string "unit_nature", limit: 255
    t.integer "worker_code", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_ent_cars", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.string "id_code", limit: 255
    t.string "car_status", limit: 255
    t.integer "is_rent", limit: 11
    t.string "rent_price", limit: 255
    t.string "total_price", limit: 255
    t.date "buy_date"
    t.decimal "displacement", precision: 20, scale: 2
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_ent_managers", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.string "name", limit: 255
    t.integer "job_id", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_ent_talents", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "sex", limit: 255
    t.date "birthday"
    t.string "national_code", limit: 255
    t.string "native_place_code", limit: 255
    t.date "work_date"
    t.string "phone", limit: 255
    t.string "education", limit: 255
    t.string "type_code", limit: 255
    t.string "pro_tech_qua", limit: 255
    t.integer "ent_id", limit: 11
    t.integer "seq", limit: 11
    t.string "card_num", limit: 255
    t.string "status", limit: 255, default: "N"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_holidays", force: :cascade do |t|
    t.string "user_id", limit: 255
    t.string "dept_id", limit: 255
    t.text "reason"
    t.string "phone", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.text "main_work"
    t.string "status", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "hr_hospitals", id: false, force: :cascade do |t|
    t.integer "hr_retirement_id", limit: 11
    t.integer "hospital_id", limit: 11
  end

  add_index "hr_hospitals", ["hr_retirement_id", "hospital_id"], name: "hr_hospitals_ind1", unique: true, using: :btree

  create_table "hr_job_levels", force: :cascade do |t|
    t.string "code", limit: 255
    t.string "name", limit: 255
    t.string "status", limit: 255
    t.string "major_class", limit: 255
    t.string "minor_class", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_jobs", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.string "type_code", limit: 255
    t.string "status", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_leader_salaries", force: :cascade do |t|
    t.integer "person_id", limit: 11
    t.integer "year", limit: 11
    t.integer "month", limit: 11
    t.string "status", limit: 255
    t.string "remark", limit: 255
    t.decimal "post_salary", precision: 20, scale: 2
    t.decimal "full_attendance_bonus", precision: 20, scale: 2
    t.decimal "allowance", precision: 20, scale: 2
    t.decimal "basic_salary", precision: 20, scale: 2
    t.decimal "performance_standards", precision: 20, scale: 2
    t.decimal "performance_percent", precision: 20, scale: 2
    t.decimal "pay_for_performance", precision: 20, scale: 2
    t.decimal "overtime_hours", precision: 20, scale: 2
    t.decimal "overtime_pay", precision: 20, scale: 2
    t.decimal "holiday_overtime_hours", precision: 20, scale: 2
    t.decimal "holiday_overtime_pay", precision: 20, scale: 2
    t.decimal "total_overtime_pay", precision: 20, scale: 2
    t.decimal "gross_salary", precision: 20, scale: 2
    t.decimal "social_insurance", precision: 20, scale: 2
    t.decimal "housing_fund", precision: 20, scale: 2
    t.decimal "personal_income_tax", precision: 20, scale: 2
    t.decimal "leave_days", precision: 20, scale: 2
    t.decimal "leave", precision: 20, scale: 2
    t.decimal "late_times", precision: 20, scale: 2
    t.decimal "late", precision: 20, scale: 2
    t.decimal "other_deduction", precision: 20, scale: 2
    t.decimal "total_deduction", precision: 20, scale: 2
    t.decimal "net_salary", precision: 20, scale: 2
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_majors", force: :cascade do |t|
    t.string "sort", limit: 255
    t.string "major_code", limit: 255
    t.string "category", limit: 255
    t.string "name", limit: 255
    t.string "parent_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_people", force: :cascade do |t|
    t.string "full_name", limit: 255
    t.string "sex", limit: 255
    t.date "birth_date"
    t.string "org_id", limit: 255
    t.string "id_card_number", limit: 40
    t.string "nationality_code", limit: 20
    t.string "native_place_code", limit: 20
    t.string "place_of_birth", limit: 100
    t.string "political_landscape_code", limit: 100
    t.date "participate_work_time"
    t.date "party_date"
    t.string "state_of_health", limit: 255
    t.integer "job_level_id", limit: 11
    t.integer "job_id", limit: 11
    t.string "preparation_class", limit: 20
    t.string "myself_status", limit: 255
    t.string "degree_code", limit: 20
    t.string "job_status_code", limit: 255
    t.string "people_category_code", limit: 100
    t.string "cadres_category_code", limit: 20
    t.integer "dept_id", limit: 11
    t.string "entry_ways_code", limit: 20
    t.date "entry_ways_date"
    t.date "into_unit_date"
    t.string "demob_class_code", limit: 20
    t.integer "pf_area_flag", limit: 11
    t.integer "pf_sp_exam_flag", limit: 11
    t.string "organ_letter", limit: 100
    t.string "medical_insurance_code", limit: 20
    t.string "endowment_insurance_code", limit: 20
    t.string "pf_category_code", limit: 20
    t.integer "financial_position_flag", limit: 11
    t.integer "payrol_flag", limit: 11
    t.text "memo"
    t.text "resume"
    t.string "assesses_class", limit: 255
    t.integer "worker_code", limit: 11
    t.string "now_title", limit: 255
    t.string "now_com_title", limit: 255
    t.text "work_resume"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "hr_person_histories", force: :cascade do |t|
    t.integer "hr_person_id", limit: 11
    t.string "full_name", limit: 255
    t.string "sex", limit: 255
    t.date "birth_date"
    t.string "org_id", limit: 255
    t.string "id_card_number", limit: 40
    t.string "nationality_code", limit: 20
    t.string "native_place_code", limit: 20
    t.string "place_of_birth", limit: 100
    t.string "political_landscape_code", limit: 100
    t.date "participate_work_time"
    t.date "party_date"
    t.string "state_of_health", limit: 255
    t.integer "job_level_id", limit: 11
    t.integer "job_id", limit: 11
    t.string "preparation_class", limit: 20
    t.string "myself_status", limit: 255
    t.string "degree_code", limit: 20
    t.string "job_status_code", limit: 255
    t.string "people_category_code", limit: 100
    t.string "cadres_category_code", limit: 20
    t.integer "dept_id", limit: 11
    t.string "entry_ways_code", limit: 20
    t.date "entry_ways_date"
    t.date "into_unit_date"
    t.string "demob_class_code", limit: 20
    t.integer "pf_area_flag", limit: 11
    t.integer "pf_sp_exam_flag", limit: 11
    t.string "organ_letter", limit: 100
    t.string "medical_insurance_code", limit: 20
    t.string "endowment_insurance_code", limit: 20
    t.string "pf_category_code", limit: 20
    t.integer "financial_position_flag", limit: 11
    t.integer "payrol_flag", limit: 11
    t.text "memo"
    t.text "resume"
    t.string "assesses_class", limit: 255
    t.integer "worker_code", limit: 11
    t.string "now_title", limit: 255
    t.string "now_com_title", limit: 255
    t.text "work_resume"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "hr_positions", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.string "status", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.integer "parent_id", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "hr_punishes", force: :cascade do |t|
    t.string "people_id", limit: 255
    t.string "punish_name", limit: 255
    t.string "punish_category", limit: 255
    t.string "punish_reasons", limit: 255
    t.date "punish_time"
    t.string "punish_unit", limit: 255
    t.string "punish_organ", limit: 255
    t.date "punish_revoca"
    t.date "punish_remove"
    t.integer "worker_code", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_qua_reports", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.date "sub_date"
    t.string "qua_num", limit: 255
    t.text "content"
    t.string "status", limit: 255
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_quarters", force: :cascade do |t|
    t.string "qua_num", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_retirements", force: :cascade do |t|
    t.integer "user_id", limit: 11
    t.integer "ent_id", limit: 11
    t.string "name", limit: 255
    t.string "sex", limit: 255
    t.string "nationality_code", limit: 255
    t.string "native_place_code", limit: 255
    t.date "birthday"
    t.string "id_card_number", limit: 255
    t.string "school_record_code", limit: 255
    t.date "work_date"
    t.string "work_phase", limit: 255
    t.date "party_date"
    t.string "pro_title_code", limit: 255
    t.string "retire_status_code", limit: 255
    t.date "legal_retire_date"
    t.date "actual_retire_date"
    t.string "ent_name", limit: 255
    t.string "last_title_code", limit: 255
    t.date "date_of_office"
    t.string "benefit_standard_code", limit: 255
    t.string "home_address", limit: 255
    t.integer "post_code", limit: 11
    t.string "home_phone", limit: 255
    t.string "cell_phone", limit: 255
    t.string "mate_name", limit: 255
    t.string "mate_status_code", limit: 255
    t.string "filial_phone", limit: 255
    t.string "medical_code", limit: 255
    t.string "hospital_name", limit: 255
    t.date "dead_date"
    t.text "resume"
    t.text "memo"
    t.string "ent_description", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "hr_rewards", force: :cascade do |t|
    t.string "people_id", limit: 255
    t.string "reward_name", limit: 255
    t.string "honor_title", limit: 255
    t.string "reward_category", limit: 255
    t.string "reward_reasons", limit: 255
    t.date "reward_time"
    t.string "reward_unit", limit: 255
    t.string "honor_title_level", limit: 255
    t.integer "worker_code", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_salaries", force: :cascade do |t|
    t.integer "person_id", limit: 11
    t.integer "year", limit: 11
    t.integer "month", limit: 11
    t.string "status", limit: 255
    t.string "remark", limit: 255
    t.decimal "post_salary", precision: 20, scale: 2
    t.decimal "full_attendance_bonus", precision: 20, scale: 2
    t.decimal "allowance", precision: 20, scale: 2
    t.decimal "basic_salary", precision: 20, scale: 2
    t.decimal "performance_standards", precision: 20, scale: 2
    t.decimal "performance_percent", precision: 20, scale: 2
    t.decimal "pay_for_performance", precision: 20, scale: 2
    t.decimal "overtime_hours", precision: 20, scale: 2
    t.decimal "overtime_pay", precision: 20, scale: 2
    t.decimal "holiday_overtime_hours", precision: 20, scale: 2
    t.decimal "holiday_overtime_pay", precision: 20, scale: 2
    t.decimal "total_overtime_pay", precision: 20, scale: 2
    t.decimal "gross_salary", precision: 20, scale: 2
    t.decimal "social_insurance", precision: 20, scale: 2
    t.decimal "housing_fund", precision: 20, scale: 2
    t.decimal "personal_income_tax", precision: 20, scale: 2
    t.decimal "leave_days", precision: 20, scale: 2
    t.decimal "leave", precision: 20, scale: 2
    t.decimal "late_times", precision: 20, scale: 2
    t.decimal "late", precision: 20, scale: 2
    t.decimal "other_deduction", precision: 20, scale: 2
    t.decimal "total_deduction", precision: 20, scale: 2
    t.decimal "net_salary", precision: 20, scale: 2
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_salary_budgets", force: :cascade do |t|
    t.integer "org_id", limit: 11
    t.integer "year", limit: 11
    t.string "status", limit: 255
    t.string "remark", limit: 255
    t.decimal "basic_salary", precision: 20, scale: 2
    t.decimal "pay_for_performance", precision: 20, scale: 2
    t.decimal "total_overtime_pay", precision: 20, scale: 2
    t.decimal "gross_salary", precision: 20, scale: 2
    t.decimal "social_insurance", precision: 20, scale: 2
    t.decimal "housing_fund", precision: 20, scale: 2
    t.decimal "personal_income_tax", precision: 20, scale: 2
    t.decimal "total_deduction", precision: 20, scale: 2
    t.decimal "net_salary", precision: 20, scale: 2
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_salary_levels", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.string "type_code", limit: 255
    t.string "status", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_title_says", force: :cascade do |t|
    t.string "major_class", limit: 255
    t.string "title_code", limit: 255
    t.string "minor_class", limit: 255
    t.string "name", limit: 255
    t.string "parent_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_titles", force: :cascade do |t|
    t.string "people_id", limit: 255
    t.string "title_say", limit: 255
    t.date "give_title_day"
    t.date "title_end_day"
    t.integer "worker_code", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_training_courses", force: :cascade do |t|
    t.integer "org_id", limit: 11
    t.string "name", limit: 255
    t.string "content", limit: 255
    t.date "set_date"
    t.string "memo", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_training_infos", force: :cascade do |t|
    t.integer "tc_id", limit: 11
    t.string "name", limit: 255
    t.date "date"
    t.text "people"
    t.string "charge_man", limit: 255
    t.integer "org_id", limit: 11
    t.string "lecturer", limit: 255
    t.string "charge_contact", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_treatments", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.integer "manager_id", limit: 11
    t.integer "car_id", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_w_experiens", force: :cascade do |t|
    t.string "people_id", limit: 255
    t.date "start_time"
    t.date "end_time"
    t.string "work_way", limit: 255
    t.string "office_property", limit: 255
    t.integer "job_level_id", limit: 11
    t.integer "job_id", limit: 11
    t.string "tenure_category", limit: 255
    t.string "treatment_level", limit: 255
    t.string "work_unit_dept", limit: 255
    t.integer "worker_code", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_week_nums", force: :cascade do |t|
    t.string "seq", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hr_weeklies", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.date "sub_date"
    t.string "seq", limit: 255
    t.text "content"
    t.string "status", limit: 255
    t.date "f_date"
    t.date "l_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "oa_recv_documents", force: :cascade do |t|
    t.string "doc_type", limit: 255
    t.string "doc_type_code", limit: 255
    t.string "doc_class_code", limit: 255
    t.string "doc_word", limit: 255
    t.integer "year", limit: 11
    t.integer "no", limit: 11
    t.string "secret_level", limit: 255
    t.string "secret_level_code", limit: 255
    t.string "doc_urgency", limit: 255
    t.string "doc_urgency_code", limit: 255
    t.integer "sent_organization_id", limit: 11
    t.string "signer", limit: 255
    t.text "content"
    t.string "title", limit: 255
    t.datetime "content_time"
    t.datetime "sign_time"
    t.text "memo"
    t.string "keyword", limit: 255
    t.string "writer", limit: 255
    t.datetime "print_time"
    t.integer "print_count", limit: 11
    t.integer "print_org_id", limit: 11
    t.datetime "finished_time"
    t.integer "sent_document_id", limit: 11
    t.string "status", limit: 255
    t.string "gzw_doc_level_code", limit: 255
    t.integer "no_arch", limit: 11
    t.datetime "pre_finished_time"
    t.integer "gzw_doc_no", limit: 11
    t.string "imp_aff_type_code", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "oa_sent_documents", force: :cascade do |t|
    t.string "doc_type_code", limit: 255
    t.string "secret_level_code", limit: 255
    t.string "doc_urgency_code", limit: 255
    t.string "doc_word_code", limit: 255
    t.integer "year", limit: 11
    t.integer "no", limit: 11
    t.string "title", limit: 255
    t.text "content"
    t.integer "organization_id", limit: 11
    t.string "pri_sent_org_name", limit: 255
    t.string "cc_sent_org_name", limit: 255
    t.string "ccr_sent_org_name", limit: 255
    t.datetime "sign_time"
    t.string "keyword", limit: 255
    t.text "memo"
    t.integer "print_org_id", limit: 11
    t.datetime "print_time"
    t.integer "print_count", limit: 11
    t.integer "print_template_id", limit: 11
    t.datetime "sent_time"
    t.string "status", limit: 255
    t.string "gzw_doc_level_code", limit: 255
    t.integer "no_arch", limit: 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "old_codes_organizations", id: false, force: :cascade do |t|
    t.integer "old_code_id", limit: 11
    t.integer "organization_id", limit: 11
  end

  create_table "pm_comments", force: :cascade do |t|
    t.text "content"
    t.datetime "comment_time"
    t.integer "user_id", limit: 11
    t.integer "resource_id", limit: 11
    t.string "resource_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pm_nodes", force: :cascade do |t|
    t.integer "percent", limit: 11
    t.text "content"
    t.string "name", limit: 255
    t.integer "plan_id", limit: 11
    t.integer "sort_seq", limit: 11
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pm_plans", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "contact", limit: 255
    t.string "phone", limit: 255
    t.text "content"
    t.integer "org_id", limit: 11
    t.integer "stage", limit: 11
    t.string "state", limit: 255
    t.integer "resource_id", limit: 11
    t.string "resource_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pm_progresses", force: :cascade do |t|
    t.integer "sort_seq", limit: 11
    t.integer "status", limit: 11
    t.integer "percent", limit: 11
    t.string "content", limit: 255
    t.string "node", limit: 255
    t.integer "node_id", limit: 11
    t.integer "plan_id", limit: 11
    t.string "state", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pm_tasks", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "content", limit: 255
    t.integer "org_id", limit: 11
    t.integer "resource_id", limit: 11
    t.string "resource_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pm_work_flows", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "state", limit: 255
    t.integer "wfable_id", limit: 11
    t.string "wfable_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
  end

  create_table "rad_corporate_bonds", force: :cascade do |t|
    t.integer "ent_id", limit: 11
    t.string "bond_name", limit: 255
    t.string "bond_type", limit: 255
    t.date "bond_date"
    t.decimal "bond_total", precision: 20, scale: 2
    t.integer "distribute_num", limit: 11
    t.date "distribute_deadline"
    t.decimal "distribute_price", precision: 20, scale: 2
    t.string "used", limit: 255
    t.decimal "repayments_rate", precision: 20, scale: 2
    t.date "repayments_date"
    t.decimal "repayments_total", precision: 20, scale: 2
    t.string "cooperation_agency", limit: 255
    t.string "guarantee_info", limit: 255
    t.decimal "et_assets", precision: 20, scale: 2
    t.string "status", limit: 255
    t.integer "created_by", limit: 11
    t.integer "updated_by", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rad_investments", force: :cascade do |t|
    t.integer "year", limit: 11
    t.integer "ent_id", limit: 11
    t.integer "project_type", limit: 11
    t.integer "start_year", limit: 11
    t.integer "end_year", limit: 11
    t.string "project_name", limit: 255
    t.integer "parent_id", limit: 11
    t.integer "position", limit: 11
    t.integer "depth", limit: 11
    t.decimal "accounting", precision: 20, scale: 6
    t.decimal "year_accounting", precision: 20, scale: 6
    t.decimal "last_year_accounting", precision: 20, scale: 6
    t.decimal "end_last_year_accounting", precision: 20, scale: 6
    t.text "reason"
    t.date "before_date"
    t.date "middle_date"
    t.date "after_date"
    t.text "memo"
    t.string "status", limit: 255
    t.integer "person_begin_code", limit: 11
    t.integer "show_type_code", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rad_jw_opinions", force: :cascade do |t|
    t.date "opinion_date"
    t.string "resource_type", limit: 255
    t.integer "resource_id", limit: 11
    t.string "opinion", limit: 255
    t.integer "user_id", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rad_repayments", force: :cascade do |t|
    t.date "repay_date"
    t.decimal "repayments", precision: 20, scale: 2
    t.decimal "debt_radio", precision: 20, scale: 2
    t.decimal "repay_rate", precision: 20, scale: 2
    t.decimal "interest", precision: 20, scale: 2
    t.integer "cor_bond_id", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rights_roles", id: false, force: :cascade do |t|
    t.integer "right_id", limit: 11
    t.integer "role_id", limit: 11
  end

  add_index "rights_roles", ["right_id", "role_id"], name: "rights_roles_ind1", unique: true, using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 11
    t.integer "user_id", limit: 11
  end

  add_index "roles_users", ["role_id", "user_id"], name: "roles_users_ind1", unique: true, using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", limit: 255, null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string "key", limit: 40
    t.string "value", limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "users_enterprises", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 11
    t.integer "enterprise_id", limit: 11
  end

  add_index "users_enterprises", ["user_id", "enterprise_id"], name: "users_enterprises_ind1", unique: true, using: :btree

  create_table "wf_proc_resources", force: :cascade do |t|
    t.integer "inst_id", limit: 11
    t.string "deployment_name", limit: 255
    t.text "variables"
    t.integer "resource_id", limit: 11
    t.string "resource_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wf_simple_operations", force: :cascade do |t|
    t.integer "workflow_id", limit: 11
    t.integer "org_id", limit: 11
    t.integer "parent_id", limit: 11
    t.integer "user_id", limit: 11
    t.string "message", limit: 255
    t.string "operate", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wf_simple_workflows", force: :cascade do |t|
    t.string "resource_type", limit: 255
    t.integer "resource_id", limit: 11
    t.integer "start_org_id", limit: 11
    t.integer "current_org_id", limit: 11
    t.string "status", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wf_task_opinions", force: :cascade do |t|
    t.integer "task_id", limit: 11
    t.string "opinion", limit: 255
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
