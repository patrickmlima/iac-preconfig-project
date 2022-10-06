#!/bin/bash

echo "Creating directories..."

`mkdir /publico`
directories=('/adm' '/ven' '/sec')

for dir_path in ${directories[@]}; do
    `mkdir $dir_path`
done
echo "Done"
echo ""

echo "Creating groups..."
groups=('GRP_ADM' 'GRP_VEN' 'GRP_SEC')
for group_name in ${groups[@]}
do
    `groupadd $group_name`
done
echo "Done"
echo ""

echo "Creating users..."
adm_users=('carlos' 'maria' 'joao')
ven_users=('debora' 'sebastiana' 'roberto')
sec_users=('josefina' 'amanda' 'rogerio')

create_users_with_group () {
    group_name=$1 && shift
    usernames_list=("$@")
    for username in ${usernames_list[@]}
    do
        echo "Creating ${username} with group ${group_name}"
        `useradd -c $username -m -s /bin/bash -g $group_name -p $(openssl passwd -crypt 123) $username`
    done
}

create_users_with_group ${groups[0]} ${adm_users[@]}
create_users_with_group ${groups[1]} ${ven_users[@]}
create_users_with_group ${groups[2]} ${sec_users[@]}
echo "Done"
echo ""

echo "Granting permissions..."
`chmod 777 /publico`
for i in 0 1 2
do
    `chown root:${groups[i]} ${directories[i]}`
    `chmod -R 770 ${directories[i]}`
done
echo "Done"
echo ""
echo "Environment configured"
