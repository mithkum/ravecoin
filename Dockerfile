sudo: required
dist: trusty
os: linux
language: generic
cache:
  directories:
  - depends/built
  - depends/sdk-sources
  - "$HOME/.ccache"
env:
  global:
  - MAKEJOBS=-j3
  - RUN_TESTS=false
  - CHECK_DOC=0
  - BOOST_TEST_RANDOM=1$TRAVIS_BUILD_ID
  - CCACHE_SIZE=100M
  - CCACHE_TEMPDIR=/tmp/.ccache-temp
  - CCACHE_COMPRESS=1
  - BASE_OUTDIR=$TRAVIS_BUILD_DIR/out
  - SDK_URL=https://bitcoincore.org/depends-sources/sdks
  - PYTHON_DEBUG=1
  - WINEDEBUG=fixme-all
  - secure: V+LjR8lbwPpYLxCQVFqdnxBHn3thftQrcm4J3HJWIAoMs3n33ulmSZM06GD82z/ezxoeDgkUHiNIYZY+4hPlVWMVoJ01pH4zBXZUi6VHHdgRUW/vQXhXv+DcvZzF0ozW9M3oD33woxUyLuKErBfh+MrDr1IXX7UxVM0X+yqIEfpLRXWadQX2i/B2ehc6+LYhSW6MHNNlUfgqsNl318jkB/mAKiiNbSbgUiSb5y16es/dbfS2BstSFcthLDrT7JM2/RlT5ghyKwPAuMWSyx9ZX/q8wjt/eRpd8DGlDZB6bv7NnFGzL393PBM+UY0n6StESw8i8yZmHc9Q/vEEFapdlC3AcMrlh9jNaoL0yDOzealPznNhWjHLtyPhWhqR+EkK78+CPKkwdAe4HrejlqjULEJl1QIGAwqCtTEZ62X6u6mKOvkEkdMFBk1M0ZKA9jmcfybAW4ds1h0PSCWawgpCy1KJukva7tswB4TpWX5AqHR+5wnr3oluiS6qVN/ol3qXY1ZQiQ7q1cm+KbdFdgCYkD12IIkia4IVBJO0fAUA0X0pIr3TRgXwxhVWhBMP8zptH3pI4fu3R8K/ltEvpBqNEQsrTEizCqeBJwjCrmbieTguq4dgwI2ND+dVEUh6yqEhC2P9eZBuitug9RXNAu+1WtAUtF+T6pMO1/zwObaGOuY=
  - secure: LQ2dchgiyyFpDddpyMO+fwxzoD+zAM+gxw2d0Ih5k+RLW5030RemKjHobk7gwfTo5Y2rOJzJP1CsmiJqI0gpr32a0bpPmiLidKa1kqGoZOETv4n/LN6c05WKi6DcsOtZeHXT2wzIu0gygzOxjdFX2BShbGCgHaFKXsmDgpsHmyRAlIfcQGgJNYPdT+Y0bauiM/i1LX7biDjoVIxfpcXl+Wlfwzfj4dkD0R2jcS4AfZx3a+2feT3Imnmo2n3Jt0z51okXbILoCWbQcMyZ83Mexx4Rsz7pVuQV+PzJgkYM6r12eyuCdYq7wOsqOt7JyADvtAr0jHBocUZggEs6hF0V6t8CD4QYf9esIE4/HgJDUFyJ4r+Oa7zvIEDSl2HspntwtWtTzd2uDTQeXqAAbFK7RpwvHvrCYwpKxD4okiSRzce7sBo0iRixdW8E4ISmf+7qV2xZNpgowPqipYY9uTRf8t0PCVxJgR/ge5rLjKU8qsSwa5gVRRUW4T+F+jtOBxr+kTfNyG4qPkSkwyplFG7ywtRtShzbIq0ywLrFy32+jGApfWRU7JByQRVDm3P1r9Xm/d1wvwajOLLUXHLbJtBg2L+8L451v2oHOl1GTSS736FvHvs8L6WHsAmw3DpctUOJssTbIDdIY9A0bHH/jnWciBNzD0lPpHPFqKir6nwWBNA=
  matrix:
  - HOST=arm-linux-gnueabihf PACKAGES="g++-arm-linux-gnueabihf" DEP_OPTS="NO_QT=1"
    CHECK_DOC=1 GOAL="install" BITCOIN_CONFIG="--enable-glibc-back-compat --enable-reduce-exports"
  - HOST=i686-w64-mingw32 DPKG_ADD_ARCH="i386" DEP_OPTS="NO_QT=1" PACKAGES="python3
    nsis g++-mingw-w64-i686 wine1.6 bc" RUN_TESTS=true GOAL="install" BITCOIN_CONFIG="--enable-reduce-exports"
  - HOST=i686-pc-linux-gnu PACKAGES="g++-multilib bc python3-zmq" DEP_OPTS="NO_QT=1"
    RUN_TESTS=true GOAL="install" BITCOIN_CONFIG="--enable-zmq --enable-glibc-back-compat
    --enable-reduce-exports LDFLAGS=-static-libstdc++" USE_SHELL="/bin/dash"
  - HOST=x86_64-w64-mingw32 DPKG_ADD_ARCH="i386" DEP_OPTS="NO_QT=1" PACKAGES="python3
    nsis g++-mingw-w64-x86-64 wine1.6 bc" RUN_TESTS=true GOAL="install" BITCOIN_CONFIG="--enable-reduce-exports"
  - HOST=x86_64-unknown-linux-gnu PACKAGES="bc python3-zmq" DEP_OPTS="NO_QT=1 NO_UPNP=1
    DEBUG=1" RUN_TESTS=true GOAL="install" BITCOIN_CONFIG="--enable-zmq --enable-glibc-back-compat
    --enable-reduce-exports CPPFLAGS=-DDEBUG_LOCKORDER"
  - HOST=x86_64-unknown-linux-gnu PACKAGES="python3" DEP_OPTS="NO_WALLET=1" RUN_TESTS=true
    GOAL="install" BITCOIN_CONFIG="--enable-glibc-back-compat --enable-reduce-exports"
  - HOST=x86_64-apple-darwin11 PACKAGES="cmake imagemagick libcap-dev librsvg2-bin
    libz-dev libbz2-dev libtiff-tools python-dev" BITCOIN_CONFIG="--enable-gui --enable-reduce-exports"
    OSX_SDK=10.11 GOAL="deploy"
before_install:
- export PATH=$(echo $PATH | tr ':' "\n" | sed '/\/opt\/python/d' | tr "\n" ":" |
  sed "s|::|:|g")
install:
- if [ -n "$DPKG_ADD_ARCH" ]; then sudo dpkg --add-architecture "$DPKG_ADD_ARCH" ;
  fi
- if [ -n "$PACKAGES" ]; then travis_retry sudo apt-get update; fi
- if [ -n "$PACKAGES" ]; then travis_retry sudo apt-get install --no-install-recommends
  --no-upgrade -qq $PACKAGES; fi
before_script:
- if [ "$TRAVIS_EVENT_TYPE" = "pull_request" ]; then contrib/devtools/commit-script-check.sh
  $TRAVIS_COMMIT_RANGE; fi
- unset CC; unset CXX
- if [ "$CHECK_DOC" = 1 ]; then contrib/devtools/check-doc.py; fi
- mkdir -p depends/SDKs depends/sdk-sources
- if [ -n "$OSX_SDK" -a ! -f depends/sdk-sources/MacOSX${OSX_SDK}.sdk.tar.gz ]; then
  curl --location --fail $SDK_URL/MacOSX${OSX_SDK}.sdk.tar.gz -o depends/sdk-sources/MacOSX${OSX_SDK}.sdk.tar.gz;
  fi
- if [ -n "$OSX_SDK" -a -f depends/sdk-sources/MacOSX${OSX_SDK}.sdk.tar.gz ]; then
  tar -C depends/SDKs -xf depends/sdk-sources/MacOSX${OSX_SDK}.sdk.tar.gz; fi
- make $MAKEJOBS -C depends HOST=$HOST $DEP_OPTS
script:
- if [ "$CHECK_DOC" = 1 -a "$TRAVIS_REPO_SLUG" = "bitcoin/bitcoin" -a "$TRAVIS_PULL_REQUEST"
  = "false" ]; then while read LINE; do travis_retry gpg --keyserver hkp://subset.pool.sks-keyservers.net
  --recv-keys $LINE; done < contrib/verify-commits/trusted-keys; fi
- if [ "$CHECK_DOC" = 1 -a "$TRAVIS_REPO_SLUG" = "bitcoin/bitcoin" -a "$TRAVIS_PULL_REQUEST"
  = "false" ]; then git fetch --unshallow; fi
- if [ "$CHECK_DOC" = 1 -a "$TRAVIS_REPO_SLUG" = "bitcoin/bitcoin" -a "$TRAVIS_PULL_REQUEST"
  = "false" ]; then contrib/verify-commits/verify-commits.sh; fi
- export TRAVIS_COMMIT_LOG=`git log --format=fuller -1`
- if [ -n "$USE_SHELL" ]; then export CONFIG_SHELL="$USE_SHELL"; fi
- OUTDIR=$BASE_OUTDIR/$TRAVIS_PULL_REQUEST/$TRAVIS_JOB_NUMBER-$HOST
- BITCOIN_CONFIG_ALL="--disable-dependency-tracking --prefix=$TRAVIS_BUILD_DIR/depends/$HOST
  --bindir=$OUTDIR/bin --libdir=$OUTDIR/lib"
- depends/$HOST/native/bin/ccache --max-size=$CCACHE_SIZE
- test -n "$USE_SHELL" && eval '"$USE_SHELL" -c "./autogen.sh"' || ./autogen.sh
- mkdir build && cd build
- "../configure --cache-file=config.cache $BITCOIN_CONFIG_ALL $BITCOIN_CONFIG || (
  cat config.log && false)"
- make distdir VERSION=$HOST
- cd bitcoin-$HOST
- "./configure --cache-file=../config.cache $BITCOIN_CONFIG_ALL $BITCOIN_CONFIG ||
  ( cat config.log && false)"
- make $MAKEJOBS $GOAL || ( echo "Build failure. Verbose build follows." && make $GOAL
  V=1 ; false )
- export LD_LIBRARY_PATH=$TRAVIS_BUILD_DIR/depends/$HOST/lib
- if [ "$RUN_TESTS" = "true" ]; then travis_wait 30 make $MAKEJOBS check VERBOSE=1;
  fi
- if [ "$TRAVIS_EVENT_TYPE" = "cron" ]; then extended="--extended --exclude pruning,dbcrash";
  fi
- if [ "$RUN_TESTS" = "true" ]; then test/functional/test_runner.py --coverage --quiet
  ${extended}; fi
after_script:
- echo $TRAVIS_COMMIT_RANGE
- echo $TRAVIS_COMMIT_LOG
