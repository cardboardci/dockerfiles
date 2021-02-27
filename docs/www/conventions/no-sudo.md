# Limited Permissions

The default user configured on each of the machines (`org.cardboardci.image.user`) does not have sudo permissions, and cannot install dependencies by default. Images are encouraged to be extended, rather than installing dependencies at runtime.

This can be inconvenient for experimentation with dependencies to resolve an issue, but is intended to ensure that any rogue dependency cannot sneak into the continuous integration system without going through the necessary vetting procedures to be installable.

Additionally avoiding installing at time of execution can avoid flakeyness in the build process for cdn outages, permanently removed resources, or failure to ensure dependency integrity.

## Pattern for Extension

For extending the images, the following is a common Dockerfile pattern:

```dockerfile
FROM ghcr.io/cardboardci/base:20210211
USER root

ENV DEPENDENCY_VERSION 5.10.15
RUN apt-get update && \
    apt-get install -y ... && \
    rm -rf /var/lib/apt/lists/*

USER cardboardci
```

## Chaining Images

Although extending an image can be effective for tightly coupled utilities, chaining images is a preferred approach. This allows the images to be cached aggressively on build machines, as well as ensuring that each individual step clearly indicates the failure step.

Large linting scripts in the continuous integration process can become unwieldy and be susceptible to complexity in dependency management.
