## Buildstage ##
FROM node:10-alpine as buildstage

# Set work directory
WORKDIR /usr/src/node-red

# copy local files
COPY rootfs/ /root-layer/

RUN \
	echo "**** install packages ****" && \
	cp -f /root-layer/package.json /usr/src/node-red && \
	apk add --no-cache --virtual buildtools build-base linux-headers udev python && \
	npm install --unsafe-perm --no-update-notifier --no-fund --only=production && \
	mkdir -p /root-layer/usr/src/node-red/ && \
	cp -R node_modules /root-layer/usr/src/node-red/

## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /root-layer/ /
