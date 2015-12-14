# ----------------------------------------------------------------------------
#  Copyright (c) 2015, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
# 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and 
#  limitations under the License.
# ----------------------------------------------------------------------------

class esb::esb (
  $sub_cluster_domain = undef,
  $port_mapping       = undef,
  $version            = '4.9.0',
  $offset             = 0,
  $hazelcast_port     = 4100,
  $maintenance_mode   = 'zero',
  $depsync            = false,
  $clustering         = false,
  $owner              = 'root',
  $group              = 'root',
  $target             = '/mnt',
) inherits params {

  $deployment_code = 'esb'
  $carbon_version  = $version
  $service_code    = 'esb'
  $carbon_home     = "${target}/wso2${service_code}-${carbon_version}"

  $service_templates = $sub_cluster_domain ? {
    'mgt'    => [
      'conf/axis2/axis2.xml',
      'conf/carbon.xml',
      'conf/datasources/master-datasources.xml',
      'conf/registry.xml',
      'conf/user-mgt.xml',
      ],
    'worker' => [
      'conf/axis2/axis2.xml',
      'conf/carbon.xml',
      'conf/datasources/master-datasources.xml',
      'conf/registry.xml',
      'conf/user-mgt.xml',
      ],
    default => [
      'conf/carbon.xml',
      ],
  }

 
  tag($service_code)

  esb::clean { $deployment_code:
    mode   => $maintenance_mode,
    target => $carbon_home,
  }

  esb::initialize { $deployment_code:
    repo      => $package_repo,
    version   => $carbon_version,
    service   => $service_code,
    local_dir => $local_package_dir,
    target    => $target,
    mode      => $maintenance_mode,
    owner     => $owner,
    require   => Esb::Clean[$deployment_code],
  }

  esb::deploy { $deployment_code:
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    require  => Esb::Initialize[$deployment_code],
    notify   => Service["wso2${esb::service_code}"],
  }

  esb::push_templates {
    $service_templates:
      target    => $carbon_home,
      directory => $deployment_code,
      require   => Esb::Deploy[$deployment_code],
  }


  file { "/etc/init.d/wso2${service_code}":
      ensure    => present,
      owner     => 'root',
      group     => 'root',
      mode      => '0775',
      content   => template("${deployment_code}/wso2${service_code}.erb"),
  }

  service { "wso2${service_code}":
      ensure     => running,
      hasstatus  => true,
      hasrestart => true,
      enable     => true,
      require    => [
            Initialize[$deployment_code],
            Deploy[$deployment_code],
            Push_templates[$service_templates],
            File["/etc/init.d/wso2${service_code}"],
      ]
  }
}
