# encoding: utf-8

node[:rtn_rbenv] ||= {}

packages = []
packages << 'gcc'
packages << 'git'

case os[:family]
when %r(debian|ubuntu)
  packages << 'zlib-dev'
  packages << 'openssl-dev'
  packages << 'readline-dev'
when %r(redhat|fedora)
  packages << 'zlib-devel'
  packages << 'openssl-devel'
  packages << 'readline-devel'
end

packages.each { |package_name| package package_name }
