# -------------------------------------------------------------------------- #
# Copyright 2002-2019, OpenNebula Project, OpenNebula Systems                #
#                                                                            #
# Licensed under the Apache License, Version 2.0 (the "License"); you may    #
# not use this file except in compliance with the License. You may obtain    #
# a copy of the License at                                                   #
#                                                                            #
# http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                            #
# Unless required by applicable law or agreed to in writing, software        #
# distributed under the License is distributed on an "AS IS" BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
# See the License for the specific language governing permissions and        #
# limitations under the License.                                             #
#--------------------------------------------------------------------------- #

# install oned system wide

sudo ./install.sh -u travis

# Set credentials
mkdir $HOME/.one
echo "oneadmin:opennebula" > $HOME/.one/one_auth

# Enable dummy drivers
sudo chmod o+w /etc/one/oned.conf
echo 'IM_MAD = [ NAME="dummy", SUNSTONE_NAME="Testing", EXECUTABLE="one_im_dummy"]' >> /etc/one/oned.conf
echo 'VM_MAD = [ NAME="dummy", SUNSTONE_NAME="Testing", EXECUTABLE="one_vmm_dummy",TYPE="xml" ]' >> /etc/one/oned.conf

# start oned
one start

# check it's up
timeout 60 sh -c 'until nc -z $0 $1; do sleep 1; done' localhost 2633

# Create dummy host
onehost create dummy -i dummy -v dummy

