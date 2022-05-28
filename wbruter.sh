#!/bin/bash

# - iNFO -----------------------------------------------------------------------------
#
#        Author: wuseman <wuseman@nr1.nu>
#      FileName: wbruter.sh
#       Version: v3.0
#
#       Created: 2018-16 (23:53:08)
#      Modified: 
#
#           iRC: wuseman (Libera/EFnet/LinkNet) 
#       Website: https://www.nr1.nu/
#        GitHub: https://github.com/wuseman/
#
# - Descrpiption --------------------------------------------------------------------
#
#      No description has been added
#
# - LiCENSE -------------------------------------------------------------------------
#
#      Copyright (C) 2022, wuseman                                     
#                                                                       
#      This program is free software; you can redistribute it and/or modify 
#      it under the terms of the GNU General Public License as published by 
#      the Free Software Foundation; either version 3 of the License, or    
#      (at your option) any later version.                                  
#                                                                       
#      This program is distributed in the hope that it will be useful,      
#      but WITHOUT ANY WARRANTY; without even the implied warranty of       
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        
#      GNU General Public License for more details.                         
#                                                                       
#      You must obey the GNU General Public License. If you will modify     
#      the file(s), you may extend this exception to your version           
#      of the file(s), but you are not obligated to do so.  If you do not   
#      wish to do so, delete this exception statement from your version.    
#      If you delete this exception statement from all source files in the  
#      program, then also delete it here.                                   
#
#      You should have received a copy of the GNU General Public License
#      along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# - End of Header -------------------------------------------------------------

function show_help (){
    cat << EOF

      Usage: $basename$0 [-i ip] [-p port] [-u [user] [-P password] ftp_command 

                      -a|--author          - Print author info
                      -i                   - IP adress
                      -p                   - Port number
                      -u                   - Username
                      -P                   - Password
                      -h|--help            - Show this help
                      -v|--version         - Print version
EOF

}

while getopts ":i:p:u:P:avh" o; do
    case "${o}" in
        i)
            i=${OPTARG}
            if ! [[ $i =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                echo -e "$basename$0: internal error -- that is not a real ip, try a real one..."
                exit 
            fi
            ;;
        p)
            p=${OPTARG}

            ;;
        u)
            u=${OPTARG}
            if [[ -z $u ]]; then echo -e "$basename$0: internal error -- specify a username";exit 1;fi
            ;;
        P)
            P=${OPTARG}
            if [[ -z $P ]]; then echo -e "$basename$0: internal error -- specify a password";exit 1; fi
            ;;
        v|-version) 
            cat $basename $0 |grep -w Version: |sed 's/^#       //g' |head -n1; exit 0
            ;;
        *)
            show_help
            ;;
    esac
done
shift $((OPTIND-1))

if [[ $@ = "-a" ]]; then 
    echo "i = ${i}"
    echo "p = ${p}"
    echo "u = ${u}"
    echo "P = ${P}"
    read -p "Connect (y/N): "
    lftp -u ${u}:${p} ${i} -p ${p} -e "$*;exit" 
elif [[ $@ = "-d" ]]; then
    lftp -u ${u}:${p} ${i} -p ${p} -e "$*;exit" 
else
    lftp -u ${u}:${P} ${i} -p ${p} -e "$*;exit" -d 
fi
