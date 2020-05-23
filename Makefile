all: build

build:
	docker build -t paulstaab/gdrive2s3 .

shell: build
	docker run -ti --rm --env-file secrets.env paulstaab/gdrive2s3 /bin/sh

backup: build
	docker run -ti --rm --env-file secrets.env paulstaab/gdrive2s3

restore: build
	mkdir restore
	docker run -ti --rm --env-file secrets.env -v /home/rclone/restore:${PWD}/restore paulstaab/gdrive2s3 restore

