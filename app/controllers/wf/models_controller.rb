class Wf::ModelsController < ApplicationController
  protect_from_forgery except: [:index, :new]

  def index
    @models = Activiti::RepositoryService.createModelQuery().orderByCreateTime().desc().list()
  end

  def new
  end

  def create
    model = Activiti::RepositoryService.newModel
    model.setName(params[:name])
    model.setCategory(params[:category])
    model.setMetaInfo('{}')
    Activiti::RepositoryService.saveModel(model)

    init_json = '{"id":"canvas","resourceId":"canvas","stencilset":{"namespace":"http://b3mn.org/stencilset/bpmn2.0#"}}'
    Activiti::RepositoryService.addModelEditorSource(model.getId(), init_json.bytes)

    redirect_to url_for("/public/modeler.html?modelId=#{model.getId()}")
  end

  def service_model
    p 'aaaaaaaaaaaaaaaa'
    model = Activiti::RepositoryService.createModelQuery().modelId(params['model_id']).singleResult()
    modeler = org.jrubyactiviti.Modeler.new(Activiti::RepositoryService)
    p modeler.show(model.getId()).to_s
    modeler.show(model.getId()).to_s
  end
end
