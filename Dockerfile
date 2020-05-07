FROM alpine as build
RUN apk update && apk add --no-cache build-base perl-ldap wget
WORKDIR /root
RUN wget https://www.spinnaker.de/lbdb/download/lbdb_0.48.1.tar.gz
RUN tar -zxvf lbdb_0.48.1.tar.gz
WORKDIR /root/lbdb-0.48.1
RUN ./configure --libdir /usr/local/lib/lbdb && make && make install

FROM alpine
COPY --from=build /usr/local/lib/lbdb /usr/local/lib/lbdb
COPY --from=build /usr/local/bin /usr/local/bin
ENTRYPOINT [ "lbdbq" ]
