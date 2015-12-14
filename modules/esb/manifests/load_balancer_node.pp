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

node /loadbalancer/ {

        $loadbalancer = hiera("loadbalancer")

        if $loadbalancer == 'nginx-plus' {
            include 'nginx_plus'
            notify {" ***************** Load balancer set to Nginx Plus. ***************** ": }
        }
        else {
            include 'nginx'
            notify {" ***************** Load balancer set to Nginx CE. ***************** ": }
        }
        ->
        file { "/etc/nginx/conf.d/esb.conf":
            notify  => Service["nginx"],  # this sets up the relationship
            owner   => root,
            group   => root,
            mode    => 775,
            content => template("${deployment_code}/nginx.erb"),
        }
        ->
        exec { "restart_nginx":
                path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
                command => "service nginx restart",
        }

}
