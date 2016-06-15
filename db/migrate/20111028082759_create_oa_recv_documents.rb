class CreateOaRecvDocuments < ActiveRecord::Migration
  def change
    create_table :oa_recv_documents do |t|
      t.string :doc_type #公文类型
      t.string :doc_type_code #公文类型代码
      t.string :doc_class_code #来文分类
      t.string :doc_word #公文字
      t.integer :year #年号
      t.integer :no #公文号
      t.string :secret_level #密级
      t.string :secret_level_code #密级代码
      t.string :doc_urgency #紧急程度
      t.string :doc_urgency_code #紧急程度代码
      t.integer :sent_organization_id #发文单位
      t.string :signer #签发人
      t.text :content #正文
      t.string :title #标题
      t.datetime :content_time #正文时间？
      t.datetime :sign_time #签发时间？
      t.text :memo #备注
      t.string :keyword #主题词
      t.string :writer #拟搞人
      t.datetime :print_time #印发时间
      t.integer :print_count #印发数量
      t.integer :print_org_id #印发单位id
      t.datetime :finished_time #办结时间
      t.integer :sent_document_id #发文id
      t.string :status #状态
      t.string :gzw_doc_level_code #国资委公文等级
      t.integer :no_arch
      t.datetime :pre_finished_time
      t.integer :gzw_doc_no
      t.string :imp_aff_type_code

      t.timestamps
      t.tracer
    end
  end
end
