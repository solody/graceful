```bash
RUN curl -sfL $(curl -s https://api.github.com/repos/powerman/dockerize/releases/latest | \
    grep -i /dockerize-$(uname -s)-$(uname -m)\" | \
    cut -d\" -f4) | \
    install /dev/stdin /usr/local/bin/dockerize

# Add helper script to keep container running.
RUN mkdir /app && chmod ugo+rwx /app
RUN chmod ugo+rx /app/*.sh
ENV GRACEFUL_HOME=/app
ENV GRACEFUL_START_TASK=/apollo-configservice/scripts/startup.sh
ENV GRACEFUL_HEALTH_CHECK_WAIT_LIST=tcp://localhost:8090

HEALTHCHECK --start-period=3m --interval=5s --timeout=1m --retries=9999 CMD /app/health-check.sh
RUN date > /app/build-time; env > /app/build-env
```