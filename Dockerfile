## Buildstage ##
FROM node:10-alpine as buildstage

# Set work directory
WORKDIR /usr/src/root

# copy local files
COPY rootfs/ /root-layer/

RUN \
	echo "**** install packages ****" && \
	cp -f /root-layer/package.json /usr/src/root && \
	apk add --no-cache --virtual buildtools build-base linux-headers udev python && \
	npm install --unsafe-perm --no-update-notifier --no-fund --only=production && \
	mkdir -p /root-layer/usr/src/root/ && \
	cp -R node_modules /root-layer/usr/src/root/

## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /root-layer/ /
