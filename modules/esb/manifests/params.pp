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

class esb::params {

  #Deployment configuration
  $package_repo         = $deployment[package_repo]
  $local_package_dir    = $deployment[local_package_dir]

  #ESB Service subdomains configuration
  $domain               = $nodeinfo[domain]
  $esb_subdomain        = $nodeinfo[esb_subdomain]
  $management_subdomain = $nodeinfo[management_subdomain]

  #Depsync repository configuration
  $depsync_svn_repo     = $depsync[depsync_svn_repo]
  $svn_user		= $depsync[svn_user]
  $svn_password		= $depsync[svn_password]

  #MySQL server configuration
  $mysql_server                      = $datasource[mysql_server]
  $mysql_port	                     = $datasource[mysql_port]
  $max_active		             = $datasource[max_active]
  $max_wait		             = $datasource[max_wait]
 
  #Registry Database configuration
  $registry_database_jndi_conf       = $datasource[registry_database_jndi_conf]
  $registry_database	             = $datasource[registry_database]
  $registry_user		     = $datasource[registry_user]
  $registry_password                 = $datasource[registry_password]
  $registry_server_host              = $datasource[registry_server_host]
  $registry_server_port	             = $datasource[registry_server_port]
  $registry_server_url               = $datasource[registry_server_url]

  #UserStore Database configuration
  $userstore_database_jndi_conf      = $datasource[userstore_database_jndi_conf]
  $userstore_database	             = $datasource[userstore_database]
  $userstore_user	             = $datasource[userstore_user]
  $userstore_password	             = $datasource[userstore_password]

}
