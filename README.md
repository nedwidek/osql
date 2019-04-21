# osql

[MasterBuild]: https://dev.azure.com/trailofbits/osql/_build/latest?definitionId=1&branchName=master

[Ubuntu1804MasterBuildImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=master&jobName=LinuxBuild
[Ubuntu1804MasterTestsImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=master&jobName=LinuxTest

[macOSMasterBuildImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=master&jobName=macOSBuild
[macOSMasterTestsImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=master&jobName=macOSTest

[WindowsMasterBuildImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=master&jobName=WindowsBuild
[WindowsMasterTestsImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=master&jobName=WindowsTest


[DevelopmentBuild]: https://dev.azure.com/trailofbits/osql/_build/latest?definitionId=1&branchName=development

[Ubuntu1804DevelopmentBuildImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=development&jobName=LinuxBuild
[Ubuntu1804DevelopmentTestsImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=development&jobName=LinuxTest

[macOSDevelopmentBuildImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=development&jobName=macOSBuild
[macOSDevelopmentTestsImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=development&jobName=macOSTest

[WindowsDevelopmentBuildImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=development&jobName=WindowsBuild
[WindowsDevelopmentTestsImage]: https://dev.azure.com/trailofbits/osql/_apis/build/status/osql.osql?branchName=development&jobName=WindowsTest

##  What is osql?

osql is a community-oriented fork of osquery with support for CMake, public CI testing, and regular releases.

This repository contains the CMake build system for osql. The osquery-src folder is a submodule that contains Facebook's osquery experimental branch, unaltered.

Our development branch has the most updated version of Facebook's code. The master branch contains the latest release tag. The osql branch contains the community release.

## Slack channel?

You can find us in the **#osql** channel of the [osquery Slack](https://slack.osquery.io)

#### Master (stable)
|Platform|Build Status|Tests Status|
|--------|------------|------------|
|Ubuntu 18.04|[![Build Status][Ubuntu1804MasterBuildImage]][MasterBuild]|[![Tests Status][Ubuntu1804MasterTestsImage]][MasterBuild]|
|macOS 10.14|[![Build Status][macOSMasterBuildImage]][MasterBuild]|[![Tests Status][macOSMasterTestsImage]][MasterBuild]|
|Windows|[![Build Status][WindowsMasterBuildImage]][MasterBuild]|[![Tests Status][WindowsMasterTestsImage]][MasterBuild]|

#### Development (unstable)
|Platform|Build Status|Tests Status|
|--------|------------|------------|
|Ubuntu 18.04|[![Build Status][Ubuntu1804DevelopmentBuildImage]][DevelopmentBuild]|[![Tests Status][Ubuntu1804DevelopmentTestsImage]][DevelopmentBuild]|
|macOS 10.14|[![Build Status][macOSDevelopmentBuildImage]][DevelopmentBuild]|[![Tests Status][macOSDevelopmentTestsImage]][DevelopmentBuild]|
|Windows|[![Build Status][WindowsDevelopmentBuildImage]][DevelopmentBuild]|[![Tests Status][WindowsDevelopmentTestsImage]][DevelopmentBuild]|

## Migrating PRs from osquery

The build and release process, along with the merging strategy we propose, have been documented in detail in the following [document](https://github.com/osql/osql/wiki/Migrating-PRs-from-osquery). Reviews and suggestions from the community are well accepted.

We aim at providing stable and development releases in different flavours (i.e.: vanilla distribution, new features that we consider stable). \
Please bear with us as we finalize the required infrastructure and CI changes.

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

# Download and build osql
cd $HOME; mkdir osql; cd osql
git clone --recurse-submodules https://github.com/osql/osql.git -b master src
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

# Download and build osql
cd $HOME; mkdir osql; cd osql
git clone --recurse-submodules https://github.com/osql/osql.git -b master src
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

#### Step 2: Download and build osql

```
# Download using a PowerShell console
mkdir osql; cd osql
git clone --recurse-submodules https://github.com/osql/osql.git -b master src

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

# Download and build osql
mkdir osql; cd osql
git clone --recurse-submodules https://github.com/osql/osql.git -b master src

# Configure
mkdir build; cd build
cmake ../src -DCMAKE_C_COMPILER=/usr/local/opt/llvm@6/bin/clang -DCMAKE_CXX_COMPILER=/usr/local/opt/llvm@6/bin/clang++

# Build
cmake --build . -j # // where # is the number of parallel build jobs

```

### Tests
To build with tests active, add `-DBUILD_TESTING=ON` to the osql configure phase, then build the project. CTest will be used to run the tests and give a report.

#### Run tests on Windows
To run the tests and get just a summary report:\
`cmake --build . --config <RelWithDebInfo|Release|Debug> --target run_tests`

To get more information when a test fails using powershell:
```
$Env:CTEST_OUTPUT_ON_FAILURE=1
cmake --build . --config <RelWithDebInfo|Release|Debug> --target run_tests
```

To run a single test, in verbose mode:\
`ctest -R <test name> -C <RelWithDebInfo|Release|Debug> -V`

#### Run tests on Linux/macOS
To run the tests and get just a summary report:\
`cmake --build . --target test`

To get more information when a test fails:\
`CTEST_OUTPUT_ON_FAILURE=1 cmake --build . --target test`

To run a single test, in verbose mode:\
`ctest -R <test name> -V`

## License

The code in this repository is licensed under the [Apache 2.0 license](LICENSE).
