#!/bin/bash -e

export SHA=`ruby -e 'require "opendelivery"' -e "puts OpenDelivery::Domain.new('us-west-2').get_property 'honolulu-jenkins-jonny-test','$pipeline_instance_id', 'SHA'"`
echo checking out revision $SHA
git checkout $SHA


gem install trollop opendelivery
gem install aws-sdk-core --pre
export stack_name=HonoluluAnswers-`date +%Y%m%d%H%M%S`
aws cloudformation create-stack --stack-name $stack_name --template-body "`cat infrastructure/config/honolulu.template`" --region ${region}  --disable-rollback --capabilities="CAPABILITY_IAM"
ruby infrastructure/bin/monitor_stack.rb  --stack $stack_name

ruby -e 'require "opendelivery"' -e "OpenDelivery::Domain.new('us-west-2').set_property 'honolulu-jenkins-jonny-test','$pipeline_instance_id', 'stack_name', '$stack_name'"