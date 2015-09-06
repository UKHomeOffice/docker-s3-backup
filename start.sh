#!/bin/bash -ex

# Make sure share dir exists
if [ ! -d "$SHARE_DIR" ]; then
  mkdir -p ${SHARE_DIR}
fi

# Setup GPG key and trust.
if [ ${GPG_PUBLIC_KEY:+1} ]; then
  echo 'adding pub key'
  echo -e "${GPG_PUBLIC_KEY}" | gpg --import
fi
if [ ${GPG_UID:+1} ]; then
  echo 'trusting keys'
  TRUST_VALUE=':6:'
  TEMP_FILE=FILE
  TEMP_VAR=0
  TRUSTVAR=`gpg --fingerprint ${GPG_UID}|grep Key|cut -d= -f2|sed 's/ //g'`
  echo $TRUSTVAR$TRUST_VALUE >> $TEMP_FILE
  TEMP_VAR=`expr $TEMP_VAR + 1`
  gpg --import-ownertrust $TEMP_FILE
  rm -f ${TEMP_FILE:?}
fi

# Look for any files in share dir, encrypt then upload.
while true; do
  find ${SHARE_DIR} -name "${FILE_NAME}" | while read LINE; do
    gpg --recipient "${GPG_UID}" --encrypt "${LINE}"
    rm -f "${LINE}"
    aws s3 cp --region ${AWS_REGION} "${LINE}" "s3://${AWS_BUCKET}/$(basename ${LINE}).gpg"
    rm -f "$LINE.gpg"
    echo "UPLOADED: ${LINE}"
  done;
  sleep 10;
done;

