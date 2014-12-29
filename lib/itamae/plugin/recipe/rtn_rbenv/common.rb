# encoding: utf-8

node[:rtn_rbenv] ||= {}

packages = []
packages << 'gcc'
packages << 'git'

case os[:family]
when %r(debian|ubuntu)
  packages << 'autoconf'
  packages << 'bison'
  packages << 'build-essential'
  packages << 'libssl-dev'
  packages << 'libyaml-dev'
  packages << 'libreadline6-dev'
  packages << 'zlib1g-dev'
  packages << 'libncurses5-dev'
  packages << 'libffi-dev'
when %r(redhat|fedora)
  packages << 'zlib-devel'
  packages << 'openssl-devel'
  packages << 'readline-devel'
end

packages.each { |package_name| package package_name }
