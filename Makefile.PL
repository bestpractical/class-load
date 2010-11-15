use inc::Module::Install;

name       'Class-Load';
all_from   'lib/Class/Load.pm';
repository 'http://github.com/bestpractical/class-load';

requires 'Scalar::Util';

build_requires 'Test::More';
build_requires 'Test::Fatal';

WriteAll;

