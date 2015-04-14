#!/bin/bash

echo hello

DATE=`date --date '1 days ago' +%Y%m%d`
SERVER="61.98.77.168"

USER="norion"
PASS="100%norion!"

DOWNLOAD_DIR="/home/ftp"
LOCAL_DIR="/home/norion"
TARGET_FILE="README.tar"

cd $LOCAL_DIR
ftp -n $SERVER << End-Of-Session
user $USER $PASS
bin
cd $DOWNLOAD_DIR
get $TARGET_FILE
bye
End-Of-Session

FILE_PATH=$LOCAL_DIR/$TARGET_FILE
PATH_SIZE=$(expr ${#FILE_PATH[*]})

echo $FILE_PATH

case $FILE_PATH in
	*.zip) unzip $FILE_PATH -d ${FILE_PATH%%.*}
	;;
	*.tar*) 
	if [ -d ${FILE_PATH%%.*} ]; then
		echo "${FILE_PATH%%.*} is exist"
		echo "server stop"
	else
		echo "${FILE_PATH%%.*} is not exist"
		mkdir ${FILE_PATH%%.*}
	fi
	
	tar -xvf $FILE_PATH -C ${FILE_PATH%%.*}
	echo "server start"
	;;
esac

exit 0