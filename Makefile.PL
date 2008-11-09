use inc::Module::Install;

name     'Class-Load';
all_from 'lib/Class/Load.pm';

build_requires 'Test::More';
build_requires 'Test::Exception';

WriteAll;

