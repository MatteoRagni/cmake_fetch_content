# CMake Fetch Content

The repository contains a series of `CMakeLists.txt` files for different libraries that I used across 
different project C/C++ while working or on my own. 

I started with vcpkg, but I found it a little problematic, in particular when you have to deal with different 
libraries versions. I think situation is changing, but in the mean time I moved to CMake Fetch content approach,
and even if it makes build times a lot longer (if you do not put a caching strategy in place), I personally think this
approach suits me better than other solutions.

The library are divided in directories. You can include them in your project by using `add_subdirectory`.