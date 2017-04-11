FROM golang:alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
			org.label-schema.name="coreos-clair-client" \
			org.label-schema.description="coreos-clair-client - Coreos Analyze local images: alpine Docker." \
			org.label-schema.url="http://andradaprieto.es" \
			org.label-schema.vcs-ref=$VCS_REF \
			org.label-schema.vcs-url="https://github.com/jandradap/coreos-clair-client" \
			org.label-schema.vendor="Jorge Andrada Prieto" \
			org.label-schema.version=$VERSION \
			org.label-schema.schema-version="1.0" \
			maintainer="Jorge Andrada Prieto <jandradap@gmail.com>" \
			org.label-schema.docker.cmd="docker run --rm --name coreos-clair-client -v $(pwd):/srv jorgeandrada/coreos-clair-client:latest"

RUN apk add --update git docker \
	&& rm -rf /var/cache/apk/* \
	&& go get -u github.com/coreos/clair/contrib/analyze-local-images

CMD ["analyze-local-images"]
