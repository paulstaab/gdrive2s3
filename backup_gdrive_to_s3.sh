#/bin/sh

mkdir -p .config/rclone
cat <<EOF > .config/rclone/rclone.conf
[gdrive]
type = drive
client_id = 
client_secret = 
service_account_file = 
token = ${gdrive_token}

[s3]
type = s3
env_auth = false
access_key_id = ${s3_access_key}
secret_access_key = ${s3_access_secret}
region = ${s3_region}
endpoint = 
location_constraint = ${s3_location}
acl = private
server_side_encryption = 
storage_class =

[s3encrypted]
type = crypt
remote = s3:${s3_bucket}
filename_encryption = off
directory_name_encryption = false
password = ${enc_secret1}
password2 = ${enc_secret2}
EOF

rclone sync -v gdrive: s3encrypted:
