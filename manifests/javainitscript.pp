# templated java daemon script
define logstash::javainitscript (
  $servicename = $title,
  $serviceuser,
  $servicegroup = $serviceuser,
  $servicehome,
  $serviceuserhome = $servicehome,
  $servicelogfile,
  $servicejar,
  $serviceargs,
  $keyword,
  $java_home = '/usr/lib/jvm/jre-1.7.0-openjdk.x86_64',
  $java_mem_min = '1g',
  $java_mem_max = '2g',
) {

  file { "/etc/init.d/${servicename}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template('logstash/javainitscript.erb'),
    notify  => Service["${servicename}"];
  }
}
