# Class: logstash::user
#
# logstash_homeroot must be passed.
class logstash::user (
  $logstash_homeroot = undef
) {

  # make sure the logstash::config class is declared before logstash::user
  Class['logstash::config'] -> Class['logstash::user']

  @user { $logstash::config::user:
    ensure     => present,
    comment    => 'logstash system account',
    tag        => 'logstash',
    uid        => '3300',
    home       => "${logstash_homeroot}",
    managehome => true,
    shell      => '/bin/false',
    system     => true;
  }

  @group { $logstash::config::group:
    ensure  => present,
    gid => '3300',
    tag => 'logstash',
    require => User[$logstash::config::user];
  }
}
