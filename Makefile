all: build

build:
	docker build -t paulstaab/gphotos2s3 .

shell: build
	docker run -ti --rm --env-file secrets.env paulstaab/gphotos2s3 /bin/sh

backup: build
	docker run -ti --rm --env-file secrets.env paulstaab/gphotos2s3

restore: build
	mkdir restore
	docker run -ti --rm --env-file secrets.env -v /home/rclone/restore:${PWD}/restore paulstaab/gphotos2s3 restore
