require 'java'
$CLASSPATH << File.join(Rails.root, "config", "activiti")

# require 'deps/activiti-engine-5.13.jar'
# require 'deps/activiti-bpmn-model-5.13.jar'
# require 'deps/activiti-bpmn-converter-5.13.jar'
# require 'deps/activiti-bpmn-layout-5.13.jar'
# require 'deps/spring-core-3.1.2.RELEASE.jar'
# require 'deps/spring-beans-3.1.2.RELEASE.jar'
# require 'deps/spring-asm-3.1.2.RELEASE.jar'
# require 'deps/slf4j-log4j12-1.7.5.jar'
# require 'deps/slf4j-api-1.7.2.jar'
# require 'deps/log4j-1.2.17.jar'
# require 'deps/commons-logging-1.1.1.jar'
# require 'deps/commons-lang-2.4.jar'
# require 'deps/mybatis-3.2.2.jar'
# require 'deps/postgresql-9.1-901.jdbc4.jar'
# require 'deps/mysql-connector-java-5.1.25-bin.jar'

$CLASSPATH << File.join(Rails.root, "deps")
require 'activiti-engine-5.13.jar'
require 'slf4j-log4j12-1.7.5.jar'
require 'mysql-connector-java-5.1.25-bin.jar'

require 'activiti-bpmn-model-5.13.jar'
require 'activiti-bpmn-converter-5.13.jar'
require 'activiti-bpmn-layout-5.13.jar' #
require 'spring-core-3.1.2.RELEASE.jar'
require 'spring-beans-3.1.2.RELEASE.jar'
require 'spring-asm-3.1.2.RELEASE.jar' #
require 'slf4j-api-1.7.2.jar'
require 'log4j-1.2.17.jar'
require 'commons-logging-1.1.1.jar'
require 'commons-lang-2.4.jar'
require 'mybatis-3.2.2.jar'
require 'postgresql-9.1-901.jdbc4.jar' #


# require 'activiti-engine-5.20.0.jar'
# require 'slf4j-log4j12-1.7.21.jar'
# require 'mysql-connector-java-5.1.38.jar'
# require 'activiti-modeler-5.20.0.jar'

activiti_process_engine = org.activiti.engine.ProcessEngines.getDefaultProcessEngine


WfActiviti = {
    runtime: activiti_process_engine.getRuntimeService,
    repository: activiti_process_engine.getRepositoryService,
    task: activiti_process_engine.getTaskService,
    form: activiti_process_engine.getFormService,
    history: activiti_process_engine.getHistoryService
}

# Activiti = {
#     management: JrubyActiviti.get_engine_instance.getManagementService,
#     identity: JrubyActiviti.get_engine_instance.getIdentityService,
#      runtime: JrubyActiviti.get_engine_instance.getRuntimeService,
#      repository: JrubyActiviti.get_engine_instance.getRepositoryService,
#      task: JrubyActiviti.get_engine_instance.getTaskService,
#      form: JrubyActiviti.get_engine_instance.getFormService,
#      history: JrubyActiviti.get_engine_instance.getHistoryService
# }

#	org.activiti.engine.ProcessEngines.getDefaultProcessEngine.close


# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
