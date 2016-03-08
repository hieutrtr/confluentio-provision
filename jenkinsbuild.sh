#!/bin/bash
# This script is just a wrapper for jenkins

release_staging () {
	case $1 in
		kafka-server-setup)
			ansible-playbook -i ./staging/inventory kafka-server-setup.yml;
			;;
		kafka-server-restart)
			ansible-playbook -i ./staging/inventory kafka-server-restart.yml;
			;;
		zookeeper-setup)
			ansible-playbook -i ./staging/inventory zookeeper-setup.yml;
			;;
		zookeeper-restart)
			ansible-playbook -i ./staging/inventory zookeeper-restart.yml;
			;;

		*)
			echo "Invalid build type"
			return 1;
		;;
	esac
	BUILD_DONE=1;
}

release_production () {
	case $1 in
		kafka-server-setup)
			ansible-playbook -i ./production/inventory kafka-server-setup.yml;
			;;
		kafka-server-restart)
			ansible-playbook -i ./production/inventory kafka-server-restart.yml;
			;;
		zookeeper-setup)
			ansible-playbook -i ./production/inventory zookeeper-setup.yml;
			;;
		zookeeper-restart)
			ansible-playbook -i ./production/inventory zookeeper-restart.yml;
			;;

		*)
			echo "Invalid build type"
			return 1;
		;;
	esac
	BUILD_DONE=1;
}

do_build () {
	case $1 in
		staging)
			release_staging $2
			;;
		production)
			release_production $2
			;;
		*)
			echo "Invalid release type"
			return 1;
			;;
	esac
}

BUILD_DONE=0;
while getopts ":r:t:" opt; do
    case $opt in
		r)
			RELEASE_TYPE=$OPTARG;
			;;
   	t)
  		BUILD_TYPE=$OPTARG;
  		;;
    *)
      exit
      ;;
    esac
done
echo "BUILD TYPE: $BUILD_TYPE";
echo "RELEASE TYPE: $RELEASE_TYPE";
do_build $RELEASE_TYPE $BUILD_TYPE

if [ $BUILD_DONE -eq 0 ]; then
	echo BUILD FAIL !!!;
fi
