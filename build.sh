#!/bin/bash
# Build the share-lan .deb package
set -e

PKG_DIR="share-lan_1.0_all"
OUT="${PKG_DIR}.deb"

cd "$(dirname "$0")"

# Ensure correct permissions before packaging
chmod 755 "$PKG_DIR/DEBIAN/postinst" "$PKG_DIR/DEBIAN/prerm" "$PKG_DIR/DEBIAN/postrm"
chmod 755 "$PKG_DIR/usr/bin/share-lan"
chmod 644 "$PKG_DIR/DEBIAN/control" "$PKG_DIR/DEBIAN/conffiles" \
          "$PKG_DIR/etc/share-lan.conf" \
          "$PKG_DIR/lib/systemd/system/share-lan.service"

fakeroot dpkg-deb --build "$PKG_DIR"
ls -lh "$OUT"
echo "Install with: sudo dpkg -i $OUT"
