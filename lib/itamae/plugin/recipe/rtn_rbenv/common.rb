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
  packages << 'rpmforge-release'
  packages << 'gdbm-devel'
  packages << 'openssl-devel'
  packages << 'libyaml-devel'
  packages << 'readline-devel'
  packages << 'zlib-devel'
  packages << 'ncurses-devel'
  packages << 'libffi-devel'
end

packages.each { |package_name| package package_name }
