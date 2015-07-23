FROM elasticsearch

COPY discovery /
COPY run.sh /

ENTRYPOINT ["/run.sh"]


