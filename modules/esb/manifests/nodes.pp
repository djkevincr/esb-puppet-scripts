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

$nodeinfo   = hiera("nodeinfo")
$datasource = hiera("datasources")
$depsync    = hiera("depsync")
$deployment = hiera("deployment")

node /distributednode/ {
  $distributednode = hiera("distributednode")
  class { "esb::esb":
    version                     => $nodeinfo[version],
    owner                       => $nodeinfo[owner],
    group                       => $nodeinfo[group],
    maintenance_mode            => $nodeinfo[maintenance_mode],
    target                      => $nodeinfo[target],
    offset                      => $distributednode[offset],
    sub_cluster_domain          => $distributednode[sub_cluster_domain],
    clustering                  => $distributednode[clustering],
    depsync                     => $distributednode[depsync],
    hazelcast_port              => $distributednode[hazelcast_port],
    members                     => $distributednode[members],
    port_mapping                => $distributednode[port_mapping],    
  }
}

node /standalonenode/ {
  $standalonenode = hiera("standalonenode")
  class { "esb::esb":
    version                     => $nodeinfo[version],
    owner                       => $nodeinfo[owner],
    group                       => $nodeinfo[group],
    maintenance_mode            => $nodeinfo[maintenance_mode],
    target                      => $nodeinfo[target],
    offset                      => $standalonenode[offset],    
  }
}

#
#  $host_configuration = hiera("host_configuration")
#  class { "esb::hosts":
#    node_ip                     => $host_configuration[node_ip],
#    node_host                   => $host_configuration[node_host],
#    host_mappings               => $host_configuration[host_mappings],
#  }

