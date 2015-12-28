NAME = phatlab/or-site-dev-base
VERSION = 0.1.0

.PHONY: all build test tag_latest release ssh

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm image

clean:
	@echo "TODO: Make this less destructive or stop caring about cleaning up after failed builds"
	# @echo $$(docker rm $$(docker ps -a -q))
	# @echo $$(docker rmi $$(docker images | grep "^<none>" | awk "{print $$3}"))

test:
	@env NAME=$(NAME) VERSION=$(VERSION) ./test/runner.sh

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: test tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

ssh:
	@chmod 600 image/services/sshd/keys/insecure_key
	@ID=$$(docker ps | grep -F "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
		EXISTING_CONTAINER="" && \
		if test "$$ID" = ""; then \
			echo "==> Unable to find a running container for $(NAME):$(VERSION)..."; \
			echo "==> Starting container..."; \
			ID=$$(docker run -d -v $$PWD/test:/test $(NAME):$(VERSION) /sbin/my_init --enable-insecure-key); \
			if test "$$ID" = ""; then \
				echo "==> Container failed to start..."; \
				exit 1; \
			fi \
		else \
			echo "==> Found running container $$ID using it..." && \
			EXISTING_CONTAINER="YES"; \
		fi && \
		echo "==> Setting up container for SSH..." && \
		echo "$$(docker exec -t -i $$ID /etc/my_init.d/00_regen_ssh_host_keys.sh -f)" && \
		echo "$$(docker exec -t -i $$ID rm /etc/service/sshd/down)" && \
		echo "$$(docker exec -t -i $$ID sv start /etc/service/sshd)" && \
		IP=$$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" "$$ID") && \
		ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i image/services/sshd/keys/insecure_key root@$$IP -t 'bash -l -c "ls;bash"' && \
		if test "$$EXISTING_CONTAINER" = ""; then \
			echo "==> Stopping container $$ID..." && \
			echo "$$(docker stop $$ID >/dev/null)" && \
			echo "==> Removing container $$ID..." && \
			echo "$$(docker rm $$ID >/dev/null)"; \
		fi
