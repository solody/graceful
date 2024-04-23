# Graceful Docker Entrypoint

This is a shell lib to make docker container graceful shutdown easy.

## Code example for dockerfile

```bash
# Graceful depend on dockerize command, so we need to install it first.
RUN curl -sfL $(curl -s https://api.github.com/repos/powerman/dockerize/releases/latest | \
    grep -i /dockerize-$(uname -s)-$(uname -m)\" | \
    cut -d\" -f4) | \
    install /dev/stdin /usr/local/bin/dockerize

# Copy Graceful lib to the image, and set the permission.
COPY /path/to/graceful /app
RUN chmod ugo+rwx /app
RUN chmod ugo+rx /app/*.sh

# Root of Graceful lib.
ENV GRACEFUL_HOME=/app
ENV GRACEFUL_START_TASK=/command/to/startup/the/main/application
ENV GRACEFUL_HEALTH_CHECK_WAIT_LIST=tcp://localhost:8090

ENTRYPOINT ["/app/entrypoint.sh"]

HEALTHCHECK --start-period=3m --interval=5s --timeout=1m --retries=9999 CMD /app/health-check.sh
RUN date > /app/build-time; env > /app/build-env
```