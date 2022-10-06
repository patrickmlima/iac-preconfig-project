#!/bin/bash

echo "Reverting environment setup..."
# Create directories
`rm -rf /publico`
directories=('/adm' '/ven' '/sec')

for dir_path in ${directories[*]}; do
    `rm -rf $dir_path`
done

# delete users
adm_users=('carlos' 'maria' 'joao')
ven_users=('debora' 'sebastiana' 'roberto')
sec_users=('josefina' 'amanda' 'rogerio')

delete_users () {
    usernames_list=("$@")
    for username in ${usernames_list[*]}
    do
        `userdel -rf $username`
    done
}

delete_users ${adm_users[@]}
delete_users ${ven_users[@]}
delete_users ${sec_users[@]}

# delete groups
groups=('GRP_ADM' 'GRP_VEN' 'GRP_SEC')
for group_name in ${groups[*]}
do
    `groupdel $group_name`
done
echo "Done"
