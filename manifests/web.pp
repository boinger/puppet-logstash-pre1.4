# = Class: logstash::web
#
# Description of logstash::web
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
class logstash::web (
) {

  # make sure the logstash::config class is declared before logstash::indexer
  Class['logstash::config'] -> Class['logstash::web']

  User  <| tag == 'logstash' |>
  Group <| tag == 'logstash' |>

  # startup script
  logstash::javainitscript { 'logstash-web':
    serviceuser    => 'logstash',
    servicegroup   => 'logstash',
    servicehome    => $logstash::config::logstash_home,
    servicelogfile => "$logstash::config::logstash_log/web.log",
    servicejar     => $logstash::package::jar,
    serviceargs    => " web --backend elasticsearch://127.0.0.1:9300/ -l $logstash::config::logstash_log/web.log",
    keyword        => 'logstash/web',
    java_home      => $logstash::config::java_home,
  }

  service { 'logstash-web':
    ensure    => 'running',
    hasstatus => true,
    enable    => true,
    require   => [Logstash::Javainitscript['logstash-web'], User['logstash'], File["${logstash::config::logstash_home}/data"]],
    subscribe => Class['logstash::package'];
  }

}

