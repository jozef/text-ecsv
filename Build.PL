use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Text::ECSV',
    license             => 'perl',
    dist_author         => 'Jozef Kutej <jkutej@cpan.org>',
    dist_version_from   => 'lib/Text/ECSV.pm',
    requires => {
        'Text::CSV_XS'          => 0,
        'Class::Accessor::Fast' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Text-ECSV-*' ],
    create_makefile_pl => 'traditional',
    create_readme       => 1,
    sign                => 1,
);

$builder->create_build_script();
