#!/bin/bash
if [ "$SHED_BUILD_HOST" == "$SHED_NATIVE_TARGET" ]; then
    echo "This package should not be built on the native host"
    exit 1
fi
mkdir -v build &&
cd build &&
../libstdc++-v3/configure           \
    --host=$SHED_BUILD_HOST         \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/${SHED_BUILD_HOST}/include/c++/${SHED_PKG_VERSION} &&
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
