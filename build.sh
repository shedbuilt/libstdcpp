#!/bin/bash
if [ "$SHED_BUILDMODE" != 'toolchain' ]; then
    echo "This package cannot be built in this build mode: $SHED_BUILDMODE"
    return 1
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
    --with-gxx-include-dir=/tools/${SHED_TOOLCHAIN_TARGET}/include/c++/7.2.0 || exit 1
make -j $SHED_NUMJOBS || exit 1
make DESTDIR="$SHED_FAKEROOT" install || exit 1 
