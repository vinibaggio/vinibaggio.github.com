build:
	@echo "Building theme..."
	@docker run -v $(shell pwd)/themes/vb-nuo/:/mnt/src -it node:latest /bin/bash -c "cd /mnt/src && /usr/local/bin/yarn && /usr/local/bin/yarn build"
	@echo "Building blog..."
	@docker run -v $(shell pwd):/mnt/src -it monachus/hugo:latest /bin/bash -c "cd /mnt/src && /usr/local/bin/hugo"
