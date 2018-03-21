#
# Cookbook:: preconf_jenkins
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


#docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home centos_jenkins:latest
#0.0.0.0:8080->8080/tcp, 0.0.0.0:50000->50000/tcp

docker_installation 'default'

docker_service_manager 'default' do
  action :start
end

directory '/root/workspace/jenkinsdocker' do

end

['Dockerfile', 'tini_pub.gpg','init.groovy', 'jenkins-support','jenkins.sh', 'tini-shim.sh','plugins.sh','install-plugins.sh'].each do |file|
  cookbook_file "/root/workspace/jenkinsdocker/#{file}" do
    source "jenkinsdocker/#{file}"
    mode "0644"
  end
end


# cookbook_file '/root/workspace/Dockerfile' do
#   source 'jenkinsdocker/Dockerfile'
# end
#
# cookbook_file '/root/workspace/tini_pub.gpg' do
#   source 'jenkinsdocker/tini_pub.gpg'
# end
#
# cookbook_file '/root/workspace/init.groovy' do
#   source 'jenkinsdocker/init.groovy'
# end
#
# cookbook_file '/root/workspace/jenkins-support' do
#   source 'jenkinsdocker/jenkins-support'
# end
#
# cookbook_file '/root/workspace/jenkins.sh' do
#   source 'jenkinsdocker/jenkins.sh'
# end
#
# cookbook_file '/root/workspace/tini-shim.sh' do
#   source 'jenkinsdocker/tini-shim.sh'
# end
#
# cookbook_file '/root/workspace/plugins.sh' do
#   source 'jenkinsdocker/plugins.sh'
# end
#
# cookbook_file '/root/workspace/install-plugins.sh' do
#   source 'jenkinsdocker/install-plugins.sh'
# end

docker_image 'centos_jenkins' do
  tag 'latest'
  source '/root/workspace/jenkinsdocker/'
  action :build_if_missing
end

# docker_container 'masterjenkins' do
#   repo 'centos_jenkins'
#   tag 'latest'
#   #command 'ls -la /'
#   port ['8080:8080','50000:50000']
#   #port '50000:50000'
#   volumes 'jenkins_home:/var/jenkins_home'
#   action :run
# end

git '/root/workspace/docker' do
  repository 'https://github.com/jenkinsci/docker.git'
  revision 'master'
  action :sync
end


# docker_container 'masterjenkins' do
#       action :stop
# end


# docker_container 'alpine_ls' do
#   repo 'alpine'
#   tag '3.1'
#   command 'ls -la /'
#   action :run
# end
