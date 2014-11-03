# encoding: utf-8

node[:rtn_rbenv] ||= {}

packages = []
packages << 'gcc'
packages << 'git'

case os[:family]
when %r(debian|ubuntu)
  packages << 'zlib1g-dev'
  packages << 'libssl-dev'
  packages << 'libreadline6-dev'
when %r(redhat|fedora)
  packages << 'zlib-devel'
  packages << 'openssl-devel'
  packages << 'readline-devel'
end

packages.each { |package_name| package package_name }
