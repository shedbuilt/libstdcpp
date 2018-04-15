#!/bin/bash
if [ "$SHED_BUILD_MODE" != 'toolchain' ]; then
    echo "This package cannot be built in this build mode: '$SHED_BUILD_MODE'"
    exit 1
fi
if [ "$SHED_BUILD_HOST" != 'toolchain' ]; then
    echo "This package cannot be built with this host: '$SHED_BUILD_HOST'"
    exit 1
fi
mkdir -v build
cd build
../libstdc++-v3/configure           \
    --host=$SHED_TOOLCHAIN_TARGET   \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/${SHED_TOOLCHAIN_TARGET}/include/c++/7.3.0 && \
make -j $SHED_NUM_JOBS && \
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1 
