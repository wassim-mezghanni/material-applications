FROM docker:latest

# Install git and bash
RUN apk add --no-cache git bash

# Copy the builder script
COPY builder.sh /usr/local/bin/builder.sh

# Make the script executable
RUN chmod +x /usr/local/bin/builder.sh

# Set the script as the entrypoint
ENTRYPOINT ["/usr/local/bin/builder.sh"]
