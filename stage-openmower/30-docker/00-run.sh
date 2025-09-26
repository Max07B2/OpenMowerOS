#!/bin/bash -e

STAGE_DIR="$(dirname "$0")"

install -m 0644 -D "$STAGE_DIR/files/etc/systemd/system/docker-preload-images.service" "$ROOTFS_DIR/etc/systemd/system/docker-preload-images.service"

# Install bundled docker images
install -d -m 0755 "$ROOTFS_DIR/opt/docker-images"
cp -a "$STAGE_DIR/files/opt/docker-images/." "$ROOTFS_DIR/opt/docker-images/"

# Reassemble split files into their base
DEST="$ROOTFS_DIR/opt/docker-images"
if compgen -G "$DEST"/*.tar.gz.part* > /dev/null; then
    # Build unique list of basenames without the .partNN suffix
    for base in $(for f in "$DEST"/*.tar.gz.part*; do echo "${f%.part*}"; done | sort -u); do
        rm -f "${base}"
        for p in $(ls -1 "${base}".part* 2>/dev/null | sort -V); do
            cat "$p" >> "${base}"
        done
        rm -f "${base}".part*
    done
fi

# Uncompress all .tar.gz files to .tar. OS image get ZIPped anyway but preload service only needs docker load em
for gz in "$DEST"/*.tar.gz; do
    [ -e "$gz" ] || break
    gunzip -f "$gz"
done
