# = Class: logstash::server
#
# Description of logstash::server
#
# == Parameters:
#
# $param::   description of parameter. default value if any.
#
# == Actions:
#
# Describe what this class does. What gets configured and how.
#
# == Requires:
#
# Requirements. This could be packages that should be made available.
#
# == Sample Usage:
#
# == Todo:
#
# * Update documentation
#
class logstash::server (
  $verbose = 'no',
  $jarname ='logstash-1.1.9-monolithic.jar'
) {

  file {
    '/etc/rc.d/init.d/logstash-server':
      ensure => 'file',
      group  => '0',
      mode   => '0755',
      owner  => '0',
      source => 'puppet:///modules/logstash/logstash-server';

    '/opt/logstash/conf/server-wrapper.conf':
      ensure   => 'file',
      group    => '0',
      mode     => '0644',
      owner    => '0',
      content  => template('logstash/server-wrapper.conf.erb');
  }

  service { 'logstash-server':
    ensure    => 'running',
    hasstatus => true,
    enable    => true,
    subscribe => Class['logstash::package'];
  }

}

