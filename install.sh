cmake -B builddir -S votca  -DCMAKE_INSTALL_PREFIX=${prefix} -DINSTALL_CSGAPPS=ON -DBUILD_OWN_GROMACS=ON -DGMX_EXTRA_CMAKE_ARGS="-DGMX_CUDA_TARGET_SM=90" -DENABLE_REGRESSION_TESTING=ON

-DGROMACS_INCLUDE_DIR=/usr/local/gromacs2019.6/include -DGROMACS_LIBRARY=/usr/local/gromacs2019.6/lib/libgromacs.so -DGROMACS_EXECUTABLE=/usr/local/gromacs2019.6/bin/gmx

-DBUILD_OWN_GROMACS=ON
-DBUILD_XTP=ON
-DBUILD_OWN_LIBINT=ON
-DUSE_CUDA=ON
