#  Licensed to the Apache Software Foundation (ASF) under one or more
#   contributor license agreements.  See the NOTICE file distributed with
#   this work for additional information regarding copyright ownership.
#   The ASF licenses this file to You under the Apache License, Version 2.0
#   (the "License"); you may not use this file except in compliance with
#   the License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

class druid_broker {
  require druid_base
  $path="/bin:/sbin:/usr/bin:/usr/sbin"

  # Configuration files.
  $component="broker"
 file { "/etc/druid/conf/$component/jvm.config":
    ensure => file,
    content => template("druid_$component/jvm.config.erb"),
    before => Service["druid-$component"],
  }

  # Link.
  exec { "hdp-select set druid-broker ${hdp_version}":
    cwd => "/",
    path => "$path",
    before => Service["druid-broker"],
  }

  # Startup.
  if ($operatingsystem == "centos" and $operatingsystemmajrelease == "7") {
    file { "/etc/systemd/system/druid-broker.service":
      ensure => 'file',
      source => "/vagrant/files/systemd/druid-broker.service",
      before => Service["druid-broker"],
    }
  }
  service { 'druid-broker':
    ensure => running,
    enable => true,
  }
}
