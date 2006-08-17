use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Convert::Number::Greek',
    AUTHOR              => 'Father Chrysostomos',
    VERSION_FROM        => 'lib/Convert/Number/Greek.pm',
    ABSTRACT_FROM       => 'lib/Convert/Number/Greek.pm',
    PL_FILES            => {},
#    PREREQ_PM => {
#        'Test::More' => 0,
#    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Convert-Number-Greek-*' },
);
