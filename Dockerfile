# Get an Arch Linux with Roswell image.
FROM shukryzablah/roswell
LABEL MAINTAINER="Shukry Zablah"

# Copy over repository contents to container.
WORKDIR /root/.roswell/local-projects/
COPY . .

# Install dependencies.
RUN pacman -S libev --noconfirm
RUN ros install clack
RUN ros install "amherst-transcript"

# Start the server.
ENV CLACK_PORT=5000
EXPOSE ${CLACK_PORT}
ENTRYPOINT ros exec clackup \
    --system "amherst-transcript" \
    --address 0.0.0.0 \
    --server :woo \
    --port ${CLACK_PORT} \
    src/app.lisp
