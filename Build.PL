use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Text::ECSV',
    license             => 'perl',
    dist_author         => 'Jozef Kutej <jozef@kutej.net>',
    dist_version_from   => 'lib/Text/ECSV.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Text-ECSV-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
