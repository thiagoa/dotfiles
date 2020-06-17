#!/usr/bin/env ruby

# Examples:
#
# $ aws_rails_console stack-shops-staging-web
# $ aws_rails_console stack-api-beta-web

require 'json'
require 'open3'

SSH_USER = 'ec2-user'.freeze
SSH_KEY_PATH = '~/.ssh/us-east-1-platform-key.pem'.freeze

instance_name = ARGV.shift ||
                abort('Needs an instance name like stack-api-beta-web')

lookup_instances_cmd = [
  'aws', 'ec2',
  'describe-instances',
  '--region', 'us-east-1',
  '--filters',
  "Name=tag:Name,Values=#{instance_name}",
  'Name=instance-state-name,Values=running'
]

instances, _status = Open3.capture2(*lookup_instances_cmd)
instances = JSON.parse(instances)
ip = instances.dig('Reservations', 0, 'Instances', 0, 'PrivateIpAddress') ||
      abort("No IP found for #{instance_name}")

app_env = /\A[a-z]+-[a-z]+-([a-z]+)-[a-z]+\z/.match(instance_name)[1]

unless app_env
  app_env = 'beta'
  warn "Could not get the env from #{instance_name}. Using #{app_env}."
end

find_container = '$(docker container ls | tail -1 | cut -f1 -d" ")'

console_cmd = %('docker exec -it #{find_container}' /bin/bash -c ) +
              %('"source .env.vault; APP_ENV=#{app_env} bundle exec rails c"')

ssh_cmd = "ssh -i #{SSH_KEY_PATH} #{SSH_USER}@#{ip} " \
          "-t #{console_cmd}"

puts ssh_cmd

if app_env == 'production'
  warn "-------------------------------------------------------------------------\n" \
       "!!!! PRODUCTION WARNING !!!!: With great power comes great responsibility\n" \
       "-------------------------------------------------------------------------\n\n"
end

exec ssh_cmd
