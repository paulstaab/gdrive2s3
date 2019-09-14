# gdrive2S3

This repo contains a small Docker container, which I use to backup my Google Drive to AWS S3.
The container relies on [rclone](https://rclone.org), which does all the
heavy lifting. I run it as a Scheduled Task on AWS Fargate for a few cents per month,
but it should be executable wherever you can execute Docker containers.

**Do not use this container unless you fully understand what it is doing.
Your files are at risk. I take no responsibility for lost data.**


## Usage

You need to set the values of the rclone config using environment
variables. I recommended to create rclone sources for gdrive, s3 and
encrypted s3 locally, test them an get the values from the rclone config
file.

As describe in the 
[rclone documentation for Google Drive](https://rclone.org/drive) you should [create your own
Google Drive Client Id](https://rclone.org/drive/#making-your-own-client-id) for this.

Once you have the values, you can just execute the container:

```
docker run -i -t --rm \
  -e gdrive_token=<token> \
  -e gdrive_client_id=<id> \
  -e gdrive_client_secret=<secret> \
  -e s3_bucket=<bucket> \
  -e s3_access_key=<access_key> \
  -e s3_access_secret=<access_secret> \
  -e s3_region=<region> \
  -e s3_location=<location> \
  -e enc_secret1=<secret> \ # Encryption PW
  -e enc_secret2=<secret> \ # Salt
  -e rclone_args=<additional_arguments_for_rclone> \
  paulstaab/gdrive2s3
```

## Encryption

This container encrypts your file using rclone's build-in encryption features.
I consider this to be purely opportunistic and not secure in any way, as I
can not judge how reliable the encryption is. Your files are definitely not secure
if you are running the container in a cloud service (like I do), since you have
to upload both encryption secret and the access token for your Google Drive to
the service.

