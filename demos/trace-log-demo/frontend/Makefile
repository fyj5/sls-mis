NODE_DOCKER_NAME := sls-registry.cn-beijing.cr.aliyuncs.com/sls-mis/trace-log-demo/frontend
NODE_DOCKER_VERSION := 1.0.0

clean_images:
	docker image prune -f

build_image: clean_images
	docker build -t $(NODE_DOCKER_NAME):$(NODE_DOCKER_VERSION) -t $(NODE_DOCKER_NAME):latest .

push_image: build_image
	docker push $(NODE_DOCKER_NAME):$(NODE_DOCKER_VERSION)

push_latest_image: build_image
	docker push $(NODE_DOCKER_NAME):latest

push_images: push_image push_latest_image
