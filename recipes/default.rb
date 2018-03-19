#
# Cookbook:: preconf_jenkins
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


#docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home centos_jenkins:latest
#0.0.0.0:8080->8080/tcp, 0.0.0.0:50000->50000/tcp





cookbook_file '/root/workspace/Dockerfile' do
  source 'jenkinsdocker/Dockerfile'
end

# remote_file '/root/workspace/Jenkinsfile' do
#        source 'jenkinsdocker/Jenkinsfile'
#       action :create
#    end

docker_container 'masterjenkins' do
  repo 'centos_jenkins'
  tag 'latest'
  #command 'ls -la /'
  port ['8080:8080','50000:50000']
  #port '50000:50000'
  volumes 'jenkins_home:/var/jenkins_home'
  action :run
end

git '/root/worspace/' do
  repository 'https://github.com/jenkinsci/docker.git'
  revision 'master'
  action :sync
end


docker_container 'masterjenkins' do
      action :stop
end


# docker_container 'alpine_ls' do
#   repo 'alpine'
#   tag '3.1'
#   command 'ls -la /'
#   action :run
# end
