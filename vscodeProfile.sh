#!/usr/bin/env bash

source ./vscodeProfiles.config

NAME=$2

add_profile(){
    mkdir -p $PROFILES_PATH/$NAME/data/User
    mkdir $PROFILES_PATH/$NAME/exts
    cp $SETTINGS_TEMPLATE $PROFILES_PATH/$NAME/data/User/settings.json
    echo "alias $NAME=\"code --extensions-dir $PROFILES_PATH/$NAME/exts --user-data-dir $PROFILES_PATH/$NAME/data\"" >> $ENV_FILE
    echo "$NAME profile is created"
    echo "please, close and open your terminal"
}

remove_profile(){

    if [ ! -d "$PROFILES_PATH/$NAME" ]; then
    echo "this profile does not exist"
    exit 1
    fi
    rm -Rf $PROFILES_PATH/$NAME
    sed -i ".bak" "/$NAME/d" $ENV_FILE
    echo "$NAME profile has been removed"

}

reset_profile(){
    remove_profile
    add_profile
}


if [ ! -f "$SETTINGS_TEMPLATE" ]; then
    echo "settings.json.template does not exist."
    exit 1
fi

case $1 in 'add' )
add_profile
;;
'remove' )
remove_profile
;;
'reset' )
reset_profile
;;
*)
echo "usage: -bash {add profilename|remove profilename|reset profilename}"
exit 1
;;
esac

if [[ $# -ne 2 ]] ; then
    echo 'profile name is mandatory'
    exit 1
fi
