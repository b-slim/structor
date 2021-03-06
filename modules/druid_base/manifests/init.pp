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

class druid_base {
  require zookeeper_client

  # Install Druid.
  package { "druid${package_version}":
    ensure => installed,
  }

  # Work around some permission issues.
  file { "/var/lib/druid":
    ensure => "directory",
    owner => "druid",
    group => "druid",
    mode => "770",
  } ->
  file { "/usr/hdp/${hdp_version}/druid/conf/_common/common.runtime.properties":
    ensure => file,
    content => template('druid_base/common.runtime.properties.erb'),
  } ->
  file { "/usr/hdp/${hdp_version}/druid/extensions/druid-hdfs-storage/hadoop-lzo.jar":
    ensure => link,
    target => "/usr/hdp/${hdp_version}/hadoop/lib/hadoop-lzo-0.6.0.${hdp_version}.jar",
  }

  # Copy in the site XMLs.
  # Hope to get rid of this at some point.
  file { "/etc/druid/conf/_common/core-site.xml":
    ensure => file,
    source => '/etc/hadoop/conf/core-site.xml',
  } ->
  file { "/etc/druid/conf/_common/hdfs-site.xml":
    ensure => file,
    source => '/etc/hadoop/conf/hdfs-site.xml',
  } ->
  file { "/etc/druid/conf/_common/mapred-site.xml":
    ensure => file,
    source => '/etc/hadoop/conf/mapred-site.xml',
  } ->
  file { "/etc/druid/conf/_common/yarn-site.xml":
    ensure => file,
    source => '/etc/hadoop/conf/yarn-site.xml',
  }

  # Logging configuration.
  file { "/etc/druid/conf/_common/log4j2.xml":
    ensure => file,
    owner => vagrant,
    group => vagrant,
    source => "puppet:///modules/druid_base/log4j2.xml",
  }
}
