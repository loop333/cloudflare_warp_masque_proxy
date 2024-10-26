FROM debian:bookworm AS build
RUN apt-get update && apt-get install -y curl gpg \
  && curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp.gpg] https://pkg.cloudflareclient.com/ bookworm main" | tee /etc/apt/sources.list.d/cloudflare-client.list \
  && apt-get update && apt-get install -y cloudflare-warp

FROM gcr.io/distroless/base-debian12
COPY --from=build /usr/bin/warp-svc /
COPY --from=build /usr/bin/warp-cli /
COPY --from=build /usr/lib/x86_64-linux-gnu/libdbus-1.so.3 /
COPY --from=build /usr/lib/x86_64-linux-gnu/libnspr4.so /
COPY --from=build /usr/lib/x86_64-linux-gnu/libnss3.so /
COPY --from=build /usr/lib/x86_64-linux-gnu/libsmime3.so /
COPY --from=build /usr/lib/x86_64-linux-gnu/libgcc_s.so.1 /
COPY --from=build /usr/lib/x86_64-linux-gnu/libsystemd.so.0 /
COPY --from=build /usr/lib/x86_64-linux-gnu/libnssutil3.so /
COPY --from=build /usr/lib/x86_64-linux-gnu/libplc4.so /
COPY --from=build /usr/lib/x86_64-linux-gnu/libplds4.so /
COPY --from=build /usr/lib/x86_64-linux-gnu/libcap.so.2 /
COPY --from=build /usr/lib/x86_64-linux-gnu/libgcrypt.so.20 /
COPY --from=build /usr/lib/x86_64-linux-gnu/liblzma.so.5 /
COPY --from=build /usr/lib/x86_64-linux-gnu/libzstd.so.1 /
COPY --from=build /usr/lib/x86_64-linux-gnu/liblz4.so.1 /
COPY --from=build /usr/lib/x86_64-linux-gnu/libgpg-error.so.0 /
COPY --from=build /usr/bin/ln /

WORKDIR /logs
RUN ["/ln", "-sf", "/dev/null", "/logs/cfwarp_service_log.txt"]
RUN ["/ln", "-sf", "/dev/null", "/logs/cfwarp_daemon_dns.txt"]
RUN ["/ln", "-sf", "/dev/null", "/logs/cfwarp_service_dex.txt"]
RUN ["/ln", "-sf", "/dev/null", "/logs/cfwarp_service_dynamic_log.txt"]
RUN ["/ln", "-sf", "/dev/null", "/logs/cfwarp_service_stats.txt"]
RUN ["/ln", "-sf", "/dev/null", "/logs/cfwarp_service_boring.txt"]
RUN ["/ln", "-sf", "/dev/null", "/logs/cfwarp_service_dns_stats.txt"]
RUN ["/ln", "-sf", "/dev/null", "/logs/cfwarp_service_taskdump.txt"]
WORKDIR /
