use inc::Module::Install;

name           'Class-Require';
all_from       'lib/Class/Require.pm';

build_requires 'Test::More';

WriteAll;

