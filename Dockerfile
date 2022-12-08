FROM python:3.9-alpine3.14 as build

ARG S3S_COMMIT="f4b6a4c"

RUN apk --update --no-cache add build-base zlib-dev jpeg-dev

RUN cd /tmp; wget https://github.com/frozenpandaman/s3s/archive/$S3S_COMMIT.tar.gz \
    && tar xzf $S3S_COMMIT.tar.gz \
    && mv /tmp/$(tar -tf $S3S_COMMIT.tar.gz | head -1 | cut -f1 -d"/") /opt/app

WORKDIR /opt/app

RUN pip install -r requirements.txt

# Make sure *.pyc files have generated
RUN echo '{"api_key": "1234567890123456789012345678901234567890123", "acc_loc": "en-US", "gtoken": "", "bullettoken": "", "session_token": "", "f_gen": "https://api.imink.app/f"}' > config.txt \
    && python3 ./s3s.py -h \
    && rm config.txt

# Cleanup
RUN rm .gitignore requirements.txt

FROM python:3.9-alpine3.14 as package

WORKDIR /opt/app

COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY entrypoint.sh /entrypoint.sh
COPY --from=build /opt/app /opt/app

RUN chmod a+x /entrypoint.sh

ENV S3S_CONFIG=""

ENTRYPOINT ["/entrypoint.sh", "python3", "./s3s.py"]
