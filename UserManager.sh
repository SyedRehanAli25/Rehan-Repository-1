#!/bin/bash

BASE_HOME="/home"
NINJA_GROUP="ninja"

case $1 in
  addTeam)
    # Add a group (team)
    groupname=$2
    sudo groupadd "$groupname"
    echo "Team $groupname created."
    ;;

  delTeam)
    groupname=$2
    sudo groupdel "$groupname"
    echo "Team $groupname deleted."
    ;;

  addUser)
    username=$2
    teamname=$3
    sudo useradd -m -d "$BASE_HOME/$username" -s /bin/bash -G "$teamname,$NINJA_GROUP" "$username"
    # Create shared dirs
    sudo mkdir -p "$BASE_HOME/$username/team" "$BASE_HOME/$username/ninja"
    # Set ownership
    sudo chown -R "$username:$teamname" "$BASE_HOME/$username"
    # Set permissions on home directory
    sudo chmod 750 "$BASE_HOME/$username"
    # Permissions for team directory (full access to team)
    sudo chmod 770 "$BASE_HOME/$username/team"
    sudo chown "$username:$teamname" "$BASE_HOME/$username/team"
    # Permissions for ninja directory (full access to ninja group)
    sudo chmod 770 "$BASE_HOME/$username/ninja"
    sudo chown "$username:$NINJA_GROUP" "$BASE_HOME/$username/ninja"
    echo "User $username created and added to team $teamname."
    ;;

  delUser)
    username=$2
    sudo userdel -r "$username"
    echo "User $username deleted."
    ;;

  changeShell)
    username=$2
    shell=$3
    sudo chsh -s "$shell" "$username"
    echo "Shell for $username changed to $shell."
    ;;

  changePasswd)
    username=$2
    sudo passwd "$username"
    ;;

  lsUser)
    # List all users and their teams
    getent passwd | awk -F: '{ print $1 }' 
    ;;

  lsTeam)
    # List all groups (teams)
    getent group | awk -F: '{ print $1 }'
    ;;

  *)
    echo "Invalid command"
    ;;
esac
