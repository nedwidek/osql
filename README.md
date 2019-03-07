# osql

##  What is osql?

osql is a community-oriented fork of osquery with support for CMake, public CI testing, and regular releases.

This repository contains the CMake build system for osquery. The osquery-src folder is a submodule that contains Facebook's osquery experimental branch, unaltered.

Our development branch has the most updated version of Facebook's code. The master branch contains the latest release tag. The osql branch contains the community release.

## Migrating PRs from osquery

In addition to packages aligned to Facebook osquery, we also plan to provide releases with additional features. PRs targeted at osquery can be migrated here to take advantage of our CI system and the faster merge window.

Please bear with us as we work out a detailed plan to accept PRs with changes to osquery. In the meantime, please help review our build and release plans.

## How to build

osql supports Linux (Ubuntu 18.04/18.10), macOS, and Windows. Additional platforms are under consideration.

git, CMake (>= 3.13.3), clang 6.0, Python 2, and Python 3 are required to build. The rest of the dependencies are downloaded by CMake.

The default build type is `RelWithDebInfo` (optimizations active + debug symbols) and can be changed in the CMake configure phase by setting the `CMAKE_BUILD_TYPE` flag to `Release` or `Debug`.

The build type is chosen when building on Windows, not during the configure phase, through the `--config` option.

### Linux

The root folder is assumed to be `/home/<user>`

#### Ubuntu 18.04

```
# Install the prerequisites
sudo apt install git llvm clang cmake libc++-dev libc++abi-dev liblzma-dev python python3

# Build and install a newer CMake (>= 3.13.3)
mkdir cmake-3.13.4; cd cmake-3.13.4
wget https://github.com/Kitware/CMake/releases/download/v3.13.4/cmake-3.13.4.tar.gz
tar xvf cmake-3.13.4.tar.gz
mv cmake-3.13.4 src
mkdir build; cd build
cmake ../src -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
cmake --build . -- -j # // where # is the number of parallel build jobs
sudo cmake --build . --target install
# Verify that `/usr/local/bin` is in the `PATH` and comes before `/usr/bin`
# (optional) remove the old CMake system package with `sudo apt remove cmake`

# Download and build osquery
mkdir osquery-cmake; cd osquery-cmake
git clone --recurse-submodules git@github.com:osql/osql.git -b master src
mkdir build; cd build
cmake ../src -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
cmake --build . -j # // where # is the number of parallel build jobs
```

#### Ubuntu 18.10

```
# Install the prerequisites
sudo apt install git llvm-6.0 clang-6.0 cmake libc++-dev libc++abi-dev liblzma-dev python python3

# Build and install a newer CMake (>= 3.13.3)
mkdir cmake-3.13.4; cd cmake-3.13.4
wget https://github.com/Kitware/CMake/releases/download/v3.13.4/cmake-3.13.4.tar.gz
tar xvf cmake-3.13.4.tar.gz
mv cmake-3.13.4 src
mkdir build; cd build
cmake ../src -DCMAKE_C_COMPILER=clang-6.0 -DCMAKE_CXX_COMPILER=clang++-6.0
cmake --build . -- -j # // where # is the number of parallel build jobs
sudo cmake --build . --target install
# Verify that `/usr/local/bin` is in the `PATH` and comes before `/usr/bin`
# (optional) remove the old CMake system package with `sudo apt remove cmake`

# Download and build osquery
mkdir osquery-cmake; cd osquery-cmake
git clone --recurse-submodules git@github.com:osql/osql.git -b master src
mkdir build; cd build
cmake ../src -DCMAKE_C_COMPILER=clang-6.0 -DCMAKE_CXX_COMPILER=clang++-6.0 (-DBUILD_TESTING=ON for tests)
cmake --build . -j # // where # is the number of parallel build jobs
```

### Windows

The root folder is assumed to be `C:\Users\<user>`

#### Step 1: Install the prerequisites
- [CMake](https://cmake.org/) (>= 3.13.3): be sure to put it into the PATH
- [Build Tools for Visual Studio 2017](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2017): from the installer choose the Workload Visual C++ build tools
- [Git for Windows](https://github.com/git-for-windows/git/releases/latest) (or equivalent)
- [Python 2](https://www.python.org/downloads/windows/)
- [Python 3](https://www.python.org/downloads/windows/)

#### Step 2: Download and build osquery

```
# Download using a PowerShell console
mkdir osquery-cmake; cd osquery-cmake
git clone --recurse-submodules git@github.com:osql/osql.git -b master src

# Configure
mkdir build; cd build
cmake ../src -G "Visual Studio 15 2017 Win64" -T host=x64

# Build
cmake --build . -j # // Number of projects to build in parallel

```

### macOS

Please ensure [homebrew](https://brew.sh/) has been installed. The root folder is assumed to be `/Users/<user>`

```
# Install prerequisites
brew install git cmake llvm@6 python@2 python

# Download and build osquery
mkdir osquery-cmake; cd osquery-cmake
git clone --recurse-submodules git@github.com:osql/osql.git -b master src

# Configure
mkdir build; cd build
cmake ../src -DCMAKE_C_COMPILER=/usr/local/opt/llvm@6/bin/clang -DCMAKE_CXX_COMPILER=/usr/local/opt/llvm@6/bin/clang++

# Build
cmake --build . -j # // where # is the number of parallel build jobs

```

### Tests
To build with tests active, add `-DBUILD_TESTING=ON` to the osquery configure phase, then build the project. CTest will be used to run the tests and give a report.

#### Run tests on Windows
To run the tests and get just a summary report:\
`cmake --build . --config <RelWithDebInfo|Release|Debug> --target run_tests`

To get more information when a test fails:\
`CTEST_OUTPUT_ON_FAILURE=1 cmake --build . --config <RelWithDebInfo|Release|Debug> --target run_tests`

#### Run tests on Linux/macOS
To run the tests and get just a summary report:\
`cmake --build . --target test`

To get more information when a test fails:\
`CTEST_OUTPUT_ON_FAILURE=1 cmake --build . --target test`


## License
TODO
